const express = require('express');
const mongoose = require('mongoose');

const app = express();

require('dotenv').config();

const artworkRoute = require('./routes/artworkRoute');
const artistRoute = require('./routes/artistRoute');
const exhibitionRoute = require('./routes/exhibitionRoute');

const PORT = process.env.PORT;

app.use(express.json());

app.use('/api/artwork', artworkRoute);
app.use('/api/artist', artistRoute);
app.use('/api/exhibition', exhibitionRoute);

const run = async () => {
    try {
        await mongoose.connect(process.env.DB_URL);
        app.listen(PORT, () => console.log(`Server started on PORT ${PORT}`));
    } catch (err) {
        console.error(err);
        process.exit(1);
    }
};

run();
