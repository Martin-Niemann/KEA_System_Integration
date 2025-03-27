import express from 'express'
import YAML from 'yaml'
import { parse } from 'csv-parse/sync';
import bodyParser from 'body-parser';

const app = express()
const port = 5173

// parse all bodies to text in req.body,
// so we can manually handle parsing afterwards
app.use(bodyParser.text({ type: ['application/yaml', 'application/json', 'text/csv', 'text/plain'] }));

app.post("/parse", (req, res) => {
  // https://mimetype.io/all-types
  // List of MIME types.
  if (req.headers['content-type'] == "text/plain") {
    let person = myNovelTextFormatParser(req.body)
    console.log(person)
    res.send(person)
  }
  if (req.headers['content-type'] == "text/csv") {
    const rows = parse(req.body, {
      columns: true,
      skip_empty_lines: true,
      delimiter: ";"
    })
    console.log(rows)
    res.send(rows)
  }
  if (req.headers['content-type'] == "application/json") {
    const json = JSON.parse(req.body)
    console.log(json)
    res.send(json)
  }
  if (req.headers['content-type'] == "application/yaml") {
    const yaml = YAML.parse(req.body)
    console.log(yaml)
    res.send(yaml)
  }
})

app.listen(port, () => {
  console.log(`Listening on port ${port}`)
})

function myNovelTextFormatParser(body: String) {
  let person = {} as personObject

  // split string at the start of every header
  let sections = body.split("[")

  sections.forEach((section) => {
    let objectName = section.substring(0, section.indexOf("]"))

    // https://stackoverflow.com/questions/21895233/how-to-split-string-with-newline-n-in-node#comment77609681_21895354
    // Covering all newline edge cases with a regex.
    let fieldsLines = section.substring(section.indexOf("]")).split(/[\r\n]+/)

    // Clean up
    fieldsLines.shift()
    if (fieldsLines[-1] === "") {
      fieldsLines.pop()
    }

    let fieldsObjects: any[] = []
    fieldsLines.forEach((field) => {
      let field_name_and_value = field.split(": ")
      fieldsObjects.push(Object.assign({}, field_name_and_value))
    })

    if (objectName == "me") {
      let me: meObject = {
        name: fieldValueForName("name", fieldsObjects),
        occupation: fieldValueForName("occupation", fieldsObjects)
      }
      person.me = me
    }

    if (objectName == "studies") {
      let studies: studiesObject = {
        name: fieldValueForName("name", fieldsObjects),
        address: fieldValueForName("address", fieldsObjects),
        program: fieldValueForName("program", fieldsObjects),
      }
      person.studies = studies
    }

    if (objectName == "hobbies") {
      let hobbies: string[] = []
      fieldsObjects.forEach((fieldObject) => {
        hobbies.push(fieldObject[0])
      })
      person.hobbies = hobbies
    }
  })

  return person
}

function fieldValueForName(name: String, fieldsObjects: String[]): String {
  let fieldValue = fieldsObjects.find((object) => object[0] == name)
  if (fieldValue != undefined) {
    fieldValue = fieldValue[1]
    return fieldValue
  } else {
    throw new Error("Illegal field name detected. Check your text for mistakes.")
  }
}

interface meObject {
  name: String
  occupation: String
}

interface studiesObject {
  name: String,
  address: String,
  program: String
}

interface personObject {
  me: meObject,
  studies: studiesObject,
  hobbies: string[]
}