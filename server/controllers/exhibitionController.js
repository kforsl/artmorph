const asyncHandler = require('express-async-handler');
const { ExhibitionModel } = require('../models/exhibitionModel');
const { getTodaysDate } = require('../utils');

exports.getAllExhibition = asyncHandler(async (req, res) => {
    try {
        const exhibition = await ExhibitionModel.find({}).populate('artworks');
        res.status(200).json({
            message: 'Successfully got all exhibition',
            data: exhibition,
        });
    } catch (error) {
        res.status(404).json({
            message: 'Error getting all exhibition',
            error: error,
        });
    }
});

exports.getExhibitionById = asyncHandler(async (req, res) => {
    try {
        const exhibition = await ExhibitionModel.findById(req.params.id).populate('artworks');
        if (!exhibition) {
            throw 'No exhibition found with that id';
        }
        res.status(200).json({
            message: 'Successfully got exhibition by id',
            data: exhibition,
        });
    } catch (error) {
        res.status(404).json({
            message: 'Error getting exhibition by id',
            error: error,
        });
    }
});

exports.getExhibitionByStyle = asyncHandler(async (req, res) => {
    try {
        const exhibition = await ExhibitionModel.find({ styles: req.params.id }).populate('artworks');
        if (!exhibition) {
            throw 'No exhibition found with that style';
        }
        res.status(200).json({
            message: 'Successfully got exhibition by style',
            data: exhibition,
        });
    } catch (error) {
        res.status(404).json({
            message: 'Error getting Exhibition by style',
            error: error,
        });
    }
});

exports.getExhibitionByMedium = asyncHandler(async (req, res) => {
    try {
        const exhibition = await ExhibitionModel.find({ mediums: req.params.id }).populate('artworks');
        if (!exhibition) {
            throw 'No exhibition found with that medium';
        }
        res.status(200).json({
            message: 'Successfully got exhibition by medium',
            data: exhibition,
        });
    } catch (error) {
        res.status(404).json({
            message: 'Error getting Exhibition by medium',
            error: error,
        });
    }
});

exports.createExhibition = asyncHandler(async (req, res) => {
    try {
        const newExhibition = { ...req.body, createdAt: getTodaysDate() };
        const exhibition = new ExhibitionModel(newExhibition);

        await exhibition.save();

        res.status(201).json({
            message: 'Successfully created a exhibition',
            data: exhibition,
        });
    } catch (error) {
        res.status(404).json({
            message: 'Error creating a new exhibition',
            error: error,
        });
    }
});
