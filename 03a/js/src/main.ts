import express from 'express'
import bodyParser from 'body-parser';
import net from 'net';

const app = express()
const express_port = 5173

const tcp_port = 5174;
const host = 'localhost';

// parse all bodies to text in req.body,
// so we can manually handle parsing afterwards
app.use(bodyParser.text({ type: ['application/yaml', 'application/json', 'text/csv', 'text/plain'] }));

app.post("/parse", (req, res) => {
  // https://mimetype.io/all-types
  // List of MIME types.
  if (req.headers['content-type'] == "text/plain") {
    sendForParseAndGetJsonResponse("NOVEL", req.body, res)
  }
  if (req.headers['content-type'] == "text/csv") {
    sendForParseAndGetJsonResponse("CSV", req.body, res)
  }
  if (req.headers['content-type'] == "application/yaml") {
    sendForParseAndGetJsonResponse("YAML", req.body, res)
  }
})

app.listen(express_port, () => {
  console.log(`Listening on port ${express_port}`)
})

function sendForParseAndGetJsonResponse(type: string, body: string, res: any) {
  let buffer: any[] = []

  const client = net.createConnection(tcp_port, host, () => {
    console.log('Succesfully connected to server.');
    const message: string = `${type} ${body}`
    client.write(`${message.length} ${message}`);
  });

  client.on('data', (chunk) => {
    console.log('Got response from server.');
    buffer.push(chunk)
  });

  client.on('end', () => {
    client.end()
    let message = Buffer.concat(buffer).toString('utf-8');
    message = JSON.parse(message)
    console.log(message)
    message = JSON.stringify(message)
    res.send(message)
  })

  client.on('close', () => {
    console.log('Connection closed.');
  });
}