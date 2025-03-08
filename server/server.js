const express = require('express');
const mongoose = require('mongoose');
var cors = require('cors')
const helmet = require('helmet');

const app = express();

require('dotenv').config();

const artworkRoute = require('./routes/artworkRoute');
const artistRoute = require('./routes/artistRoute');
const exhibitionRoute = require('./routes/exhibitionRoute');

const PORT = process.env.PORT;

app.use(
    helmet.contentSecurityPolicy({
        directives: {
            scriptSrc: ["'self'"],
            defaultSrc: ["'self'"],
            fontSrc: ["'self'"],
            imgSrc: ["'self'",
                'https://artmorph-images.s3.eu-north-1.amazonaws.com'],
            connectSrc: [
                "'self'",
                'https://d1964um5pbaqp4.cloudfront.net',
            ],
        },
    })
);
app.use(cors({
    credentials: true,
    origin: [
        'http://localhost:3000',
        'http://localhost:8000',
        'https://d1964um5pbaqp4.cloudfront.net',
    ],
}))
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
