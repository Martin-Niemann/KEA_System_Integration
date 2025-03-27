import yaml
import pandas as pd
import io
import pprint
import socket
import json
import signal
import sys


def tcp_server():
    host = ("localhost", 5174)

    tcp_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    tcp_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    tcp_socket.bind(host)
    tcp_socket.listen(1)

    def signal_handler(sig, frame):
        print("Stopping web server..")
        tcp_socket.close()
        sys.exit(0)

    # Do a graceful shutdown when hitting CTRL+C
    signal.signal(signal.SIGINT, signal_handler)

    while True:
        print("Waiting for connections.")
        client_socket, client_info = tcp_socket.accept()

        try:
            print("Connection from {}".format(client_info))

            is_first_packet = True
            msg_length = 0
            complete_data = bytearray()
            while len(complete_data) < msg_length or is_first_packet:
                received_data = client_socket.recv(1024)

                if is_first_packet:
                    (body_length_bytes, _) = received_data.split(maxsplit=1)
                    body_length_int = int(body_length_bytes)

                    # Calculating the total size of the whole message.
                    # +1 takes into account the whitespace character that is stripped by split().
                    msg_length = body_length_int + len(body_length_bytes) + 1

                    complete_data.extend(received_data)
                    complete_data.strip()
                    print(complete_data.decode(encoding="utf-8"))

                    is_first_packet = False
                else:
                    complete_data.extend(received_data)

            print("Received payload from client.")

            json = parseToJson(complete_data.decode(encoding="utf-8"))

            client_socket.sendall(json.encode(encoding="utf-8"))

        finally:
            client_socket.close()
            print("Closed connection to client.")


def parseToJson(data: str) -> str:
    (_, content_type, body) = data.split(" ", 2)

    python_object: Any = None
    if content_type == "YAML":
        python_object = yaml.safe_load(body)
    if content_type == "CSV":
        dataframa = pd.read_csv(io.StringIO(body), sep=";")
        python_object = dataframa.to_dict()
    if content_type == "NOVEL":
        python_object = my_novel_text_format_parser(body)

    return json.dumps(python_object)


def my_novel_text_format_parser(body: str):
    person = []

    sections = body.split("[")
    sections.pop(0)

    for section in sections:
        split_string = section.split("]")
        object_name = split_string[0]
        fields = split_string[1]

        fields_lines = fields.strip()
        fields_lines = fields_lines.splitlines()

        fields_dicts = []
        for field in fields_lines:
            field_name_and_value = field.split(": ")

            if len(field_name_and_value) == 1:
                field_name_and_value.append("")

            fields_dicts.append(
                dict(name=field_name_and_value[0], value=field_name_and_value[1])
            )

        if object_name == "me":
            me = dict(
                name=field_value_for_name("name", fields_dicts),
                occupation=field_value_for_name("occupation", fields_dicts),
            )
            person.append(me)

        if object_name == "studies":
            studies = dict(
                name=field_value_for_name("name", fields_dicts),
                address=field_value_for_name("address", fields_dicts),
                program=field_value_for_name("program", fields_dicts),
            )
            person.append(studies)

        if object_name == "hobbies":
            hobbies = []
            for field in fields_dicts:
                hobbies.append(list(field.values())[0])
            person.append(hobbies)

    return person


def field_value_for_name(name: str, fields_dicts: []):
    for field in fields_dicts:
        if list(field.values())[0] == name:
            return list(field.values())[1]


if __name__ == "__main__":
    tcp_server()
