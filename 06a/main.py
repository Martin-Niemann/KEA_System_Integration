import json
import uvicorn
from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from fastapi.staticfiles import StaticFiles


class ConnectionManager:
    def __init__(self):
        self.active_connections: list[WebSocket] = []

    async def connect(self, websocket: WebSocket):
        await websocket.accept()
        self.active_connections.append(websocket)

    def disconnect(self, websocket: WebSocket):
        self.active_connections.remove(websocket)

    async def broadcast(self, message: str):
        for connection in self.active_connections:
            await connection.send_text(message)


def main():
    app = FastAPI()

    manager = ConnectionManager()

    @app.websocket("/ws")
    async def websocket_endpoint(websocket: WebSocket):
        await manager.connect(websocket)
        try:
            while True:
                data = await websocket.receive_text()
                data = json.loads(data)

                if data.get("action") is not None:
                    if data.get("action") == "join":
                        joined_message = {}
                        joined_message["type"] = "system_message"
                        joined_message["message"] = (
                            f"{data.get("username")} has joined the chat."
                        )
                        json_message = json.dumps(joined_message)
                        await manager.broadcast(json_message)
                    if data.get("action") == "send_message":
                        user_message = {}
                        user_message["type"] = "user_message"
                        user_message["username"] = data.get("username")
                        user_message["message"] = data.get("message")
                        json_message = json.dumps(user_message)
                        await manager.broadcast(json_message)
                    if data.get("action") == "leaving":
                        leave_message = {}
                        leave_message["type"] = "system_message"
                        leave_message["message"] = (
                            f"{data.get("username")} has left the chat."
                        )
                        json_message = json.dumps(leave_message)
                        await manager.broadcast(json_message)

        except WebSocketDisconnect:
            manager.disconnect(websocket)

    app.mount("/", StaticFiles(directory="static", html=True), name="static")

    uvicorn.run(app, port=8090)


if __name__ == "__main__":
    main()
