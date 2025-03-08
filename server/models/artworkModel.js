const { Schema, model } = require('mongoose');

const ArtworkSchema = new Schema({
    title: {
        type: String,
        required: true,
    },
    description: {
        type: String,
        required: true,
    },
    artist: {
        type: Schema.Types.ObjectId,
        ref: 'Artist',
        require: true,
    },
    imageUrl: {
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

const ArtworkModel = model('Artwork', ArtworkSchema);
module.exports = { ArtworkModel, ArtworkSchema };
