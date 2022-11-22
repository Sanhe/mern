'use strict';

const dotenv = require('dotenv');
const express = require('express');

dotenv.config({ path: './.env' });
const port = process.env.PORT;
const host = process.env.HOST;

// App
const app = express();
app.get('/', (req, res) => {
    res.send('Hello World!');
});

app.listen(port, host, () => {
    console.log(`Running on ${host}:${port}`);
});
