import express from 'express'
import { handleRegister } from './handlers'

const app = express()
const port = 8090

app.get('/buy10000litersofmilk', (req, res) => {
    res.send('Hello World!')
})

app.get('/ping', (req, res) => {
    res.send('Hello World!')
})

app.post('/register', (req, res) => {
    const payload = JSON.parse(req.body)
    if ("event" in payload && "url" in payload) {
        handleRegister(payload.event, payload.url, res)
    }
})

app.post('/unregister', (req, res) => {
    const payload = JSON.parse(req.body)
    if ("event" in payload && "url" in payload) {
        handleRegister(payload.event, payload.url, res)
    }
})

app.get('/newtoken', (req, res) => {

})

app.listen(port, () => {
    console.log(`Webhooks app listening on port ${port}`)
})
