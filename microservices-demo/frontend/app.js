const express = require("express")
const app = express()

app.get("/", (req,res)=>{
  res.send("Hello Anjan This is from Frontend")
})

app.listen(3000)