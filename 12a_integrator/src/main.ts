import express from 'express'
import bodyParser from 'body-parser';

const app = express()
const port = 8091

app.use(bodyParser.json());

app.post('/webhooks/kristian', (req, res) => {
    const payload = req.body
    res.status(200).send()
    console.log(payload)
})

app.listen(port, () => {
    console.log(`Webhooks client app listening on port ${port}`)
})