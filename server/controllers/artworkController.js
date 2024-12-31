const asyncHandler = require('express-async-handler');
const { ArtworkModel } = require('../models/artworkModel');
const { getTodaysDate } = require('../utils');

exports.getAllArtworks = asyncHandler(async (req, res) => {
    try {
        const artwork = await ArtworkModel.find({}).populate('artist');
        res.status(200).json({
            message: 'Successfully got all artworks',
            data: artwork,
        });
    } catch (error) {
        res.status(404).json({
            message: 'Error getting all artworks',
            error: error,
        });
    }
});

exports.getArtworkById = asyncHandler(async (req, res) => {
    try {
        const artwork = await ArtworkModel.findById(req.params.id).populate('artist');
        if (!artwork) {
            throw 'No artwork found with that id';
        }
        res.status(200).json({
            message: 'Successfully got artwork by id',
            data: artwork,
        });
    } catch (error) {
        res.status(404).json({
            message: 'Error getting artwork by id',
            error: error,
        });
    }
});

exports.getArtworkByStyle = asyncHandler(async (req, res) => {
    try {
        const artwork = await ArtworkModel.find({ styles: req.params.id }).populate('artist');
        if (!artwork) {
            throw 'No artwork found with that style';
        }
        res.status(200).json({
            message: 'Successfully got artworks by style',
            data: artwork,
        });
    } catch (error) {
        res.status(404).json({
            message: 'Error getting artwork by style',
            error: error,
        });
    }
});

exports.getArtworkByMedium = asyncHandler(async (req, res) => {
    try {
        const artwork = await ArtworkModel.find({ mediums: req.params.id }).populate('artist');
        if (!artwork) {
            throw 'No artwork found with that medium';
        }
        res.status(200).json({
            message: 'Successfully got artworks by medium',
            data: artwork,
        });
    } catch (error) {
        res.status(404).json({
            message: 'Error getting artwork by medium',
            error: error,
        });
    }
});

exports.getArtworkByArtist = asyncHandler(async (req, res) => {
    try {
        const artwork = await ArtworkModel.find({ artist: req.params.id }).populate('artist');
        if (!artwork) {
            throw 'No artwork found with that artist';
        }
        res.status(200).json({
            message: 'Successfully got artworks by artist',
            data: artwork,
        });
    } catch (error) {
        res.status(404).json({
            message: 'Error getting artworks by artist',
            error: error,
        });
    }
});

exports.createNewArtwork = asyncHandler(async (req, res) => {
    try {
        const newArtwork = { ...req.body, createdAt: getTodaysDate() };
        const artwork = new ArtworkModel(newArtwork);

        await artwork.save();

        res.status(201).json({
            message: 'Successfully created a artworks',
            data: artwork,
        });
    } catch (error) {
        res.status(404).json({
            message: 'Error creating a new artwork',
            error: error,
        });
    }
});
