import express from 'express'
import bodyParser from 'body-parser';
import { handleNewToken, handleRegister, handleCallHooks, handleUnregister } from './handlers.js'
import { HandleCallHooksOperation } from './enums.js'
import { initDb } from './db.js'

const app = express()
const port = 8090

initDb()

app.use(bodyParser.json());

app.post('/buy10000litersofmilk', (req, res) => {
    handleCallHooks(req, res, HandleCallHooksOperation.Flow)
})

app.post('/ping', (req, res) => {
    handleCallHooks(req, res, HandleCallHooksOperation.Ping)
})

app.post('/register', (req, res) => {
    handleRegister(req, res)
})

app.post('/unregister', (req, res) => {
    handleUnregister(req, res)
})

app.get('/newtoken', (_, res) => {
    handleNewToken(res)
})

app.listen(port, () => {
    console.log(`Webhooks app listening on port ${port}`)
})
