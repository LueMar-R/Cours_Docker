const express = require('express');
const app = express();
app.get('*', (req, res) => {
    res.status(200).json('Hello le World!');
})
app.listen(80);