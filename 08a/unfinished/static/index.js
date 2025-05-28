const socket = io();

const constraints = { audio: true, video: true };
const selfVideo = document.querySelector("video.self-view");
const remoteVideo = document.querySelector("video.remote-view");

const form = document.getElementById('form');
const name = document.getElementById('name');
const input = document.getElementById('input');
const messages = document.getElementById('messages');

form.addEventListener('submit', (e) => {
    e.preventDefault();
    if (input.value) {
        socket.emit('chat message', input.value, name.value);
        input.value = '';
    }
});

socket.on('chat message', (msg, name) => {
    const item = document.createElement('li');
    item.textContent = name + ": " + msg;
    messages.appendChild(item);
});

socket.on('webrtc',)

const config = {
    iceServers: [
        { urls: "stun:stun.l.google.com:19302" },
        { urls: "stun:stun.l.google.com:5349" },
        { urls: "stun:stun1.l.google.com:3478" },
        { urls: "stun:stun1.l.google.com:5349" },
        { urls: "stun:stun2.l.google.com:19302" },
        { urls: "stun:stun2.l.google.com:5349" },
        { urls: "stun:stun3.l.google.com:3478" },
        { urls: "stun:stun3.l.google.com:5349" },
        { urls: "stun:stun4.l.google.com:19302" },
        { urls: "stun:stun4.l.google.com:5349" }
    ],
};

const conn = new RTCPeerConnection(config);

async function start() {
    try {
        const stream = await navigator.mediaDevices.getUserMedia(constraints);

        for (const track of stream.getTracks()) {
            conn.addTrack(track, stream);
        }
        selfVideo.srcObject = stream;
    } catch (err) {
        console.error(err);
    }
}

conn.ontrack = ({ track, streams }) => {
    track.onunmute = () => {
        if (remoteVideo.srcObject) {
            return;
        }
        remoteVideo.srcObject = streams[0];
    };
};

let makingOffer = false;

conn.onnegotiationneeded = async () => {
    try {
        makingOffer = true;
        await conn.setLocalDescription();
        socket.emit("webrtc", { "description": pc.localDescription });
    } catch (err) {
        console.error(err);
    } finally {
        makingOffer = false;
    }
};

conn.onicecandidate = ({ candidate }) => socket.emit("webrtc", { "candidate": candidate });
