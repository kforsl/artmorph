const { Schema, model } = require('mongoose');

const ExhibitionSchema = new Schema({
    title: {
        type: String,
        required: true,
    },
    description: {
        type: String,
        required: true,
    },
    thumbnailUrl: {
        type: String,
        required: true,
    },
    artworks: [
        {
            type: Schema.Types.ObjectId,
            ref: 'Artwork',
            require: true,
        },
    ],
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

const ExhibitionModel = model('Exhibition', ExhibitionSchema);
module.exports = { ExhibitionModel, ExhibitionSchema };
