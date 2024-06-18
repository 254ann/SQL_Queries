const cookieParser = require('cookie-parser');
require('dotenv').config();
const express = require("express");
const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Cookie middleware
app.use(cookieParser());

const eventRouter = require('./routes/eventRoutes');

app.use('/api', eventRouter);
app.get('/', (req, res) => {
    res.send('Hi from Ann');
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server running on port: ${PORT}`);
});
