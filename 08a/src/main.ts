import express from 'express';
import { createServer } from 'node:http';
import path, { dirname } from 'node:path';
import { fileURLToPath } from 'node:url';
import { Server } from 'socket.io';

const app = express();
const server = createServer(app);
const io = new Server(server);

const root = dirname(fileURLToPath(import.meta.url));

app.get('/', (_, res) => {
    res.sendFile(path.join(root, "../static/index.html"));
});

app.get('/index.js', (_, res) => {
    res.sendFile(path.join(root, "../static/index.js"));
});

io.on('connection', (socket) => {
    console.log('a user connected');
    socket.on('disconnect', () => {
        console.log('user disconnected');
    });
    socket.on('chat message', (msg, name) => {
        io.emit('chat message', msg, name);
    });
    socket.on('webrtc', (desc) => {
        socket.broadcast.emit('webrtc', desc);
    });
});

server.listen(8090, () => {
    console.log('server running at http://localhost:8090');
});