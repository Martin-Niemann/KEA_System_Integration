import uvicorn
from fastapi import FastAPI, Request
import yaml
import pandas as pd
import io
import pprint

app = FastAPI()


@app.post("/parse")
async def parse(req: Request):
    content_type = req.headers.get("Content-Type")
    if content_type == "application/json":
        print(await req.json())
    if content_type == "application/yaml":
        print(yaml.safe_load(await req.body()))
    if content_type == "text/csv":
        dataframa = pd.read_csv(
            io.StringIO(str(await req.body(), encoding="utf-8")), sep=";"
        )
        person_dict = dataframa.to_dict()
        pprint.pprint(person_dict)
    if content_type == "text/plain":
        person = my_novel_text_format_parser(str(await req.body(), encoding="utf-8"))
        pprint.pprint(person)


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
    uvicorn.run(app, port=5173)
