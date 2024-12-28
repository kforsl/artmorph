const express = require('express');
const controller = require('../controllers/artworkController');

const router = express.Router();

router.get('/', controller.getAllArtworks);
router.get('/:id', controller.getArtworkById);
router.get('/style/:id', controller.getArtworkByStyle);
router.get('/medium/:id', controller.getArtworkByMedium);
router.get('/artist/:id', controller.getArtworkByArtist);

router.post('/', controller.createNewArtwork);

module.exports = router;
