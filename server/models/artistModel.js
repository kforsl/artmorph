const { Schema, model } = require('mongoose');

const ArtistSchema = new Schema({
    name: {
        type: String,
        required: true,
    },
    aboutMe: {
        type: String,
        required: true,
    },
    profileImgUrl: {
        type: String,
        required: true,
    },
    mediums: [
        {
            type: String,
            required: true,
        },
    ],
    styles: [
        {
            type: String,
            required: true,
        },
    ],

    createdAt: {
        type: Date,
        required: true,
    },
});

const ArtistModel = model('Artist', ArtistSchema);
module.exports = { ArtistModel, ArtistSchema };
