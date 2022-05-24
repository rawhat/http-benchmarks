const express = require('express')
const app = express();

app.get('/', (req, res) => {
  res.send("");
})

app.get('/user/:id', (req, res) => {
  res.send(req.params.id)
})

app.post('/user', (req, res) => {
  res.send(req.body)
})

app.listen(8080, () => {
  console.log("Listening on port 8080...")
})
