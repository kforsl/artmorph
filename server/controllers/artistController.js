const asyncHandler = require('express-async-handler');
const { ArtistModel } = require('../models/artistModel');
const { getTodaysDate } = require('../utils');

exports.getAllArtist = asyncHandler(async (req, res) => {
    try {
        const artist = await ArtistModel.find({});
        res.status(200).json({
            message: 'Successfully got all artist',
            data: artist,
        });
    } catch (error) {
        res.status(404).json({
            message: 'Error getting all artist',
            error: error,
        });
    }
});

exports.getArtistById = asyncHandler(async (req, res) => {
    try {
        const artist = await ArtistModel.findById(req.params.id);
        if (!artist) {
            throw 'No artist found with that id';
        }
        res.status(200).json({
            message: 'Successfully got artist by id',
            data: artist,
        });
    } catch (error) {
        res.status(404).json({
            message: 'Error getting artist by id',
            error: error,
        });
    }
});

exports.getArtistByStyle = asyncHandler(async (req, res) => {
    try {
        const artist = await ArtistModel.find({ styles: req.params.id });
        if (!artist) {
            throw 'No artist found with that style';
        }
        res.status(200).json({
            message: 'Successfully got artist by style',
            data: artist,
        });
    } catch (error) {
        res.status(404).json({
            message: 'Error getting artist by style',
            error: error,
        });
    }
});

exports.getArtistByMedium = asyncHandler(async (req, res) => {
    try {
        const artist = await ArtistModel.find({ mediums: req.params.id });
        if (!artist) {
            throw 'No artist found with that medium';
        }
        res.status(200).json({
            message: 'Successfully got artist by medium',
            data: artist,
        });
    } catch (error) {
        res.status(404).json({
            message: 'Error getting artist by medium',
            error: error,
        });
    }
});

exports.createNewArtist = asyncHandler(async (req, res) => {
    try {
        const newArtist = { ...req.body, createdAt: getTodaysDate() };
        const artist = new ArtistModel(newArtist);

        await artist.save();

        res.status(201).json({
            message: 'Successfully created a artist',
            data: artist,
        });
    } catch (error) {
        res.status(404).json({
            message: 'Error creating a new artist',
            error: error,
        });
    }
});
