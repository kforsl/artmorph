const express = require('express');
const controller = require('../controllers/artistController');

const router = express.Router();

router.get('/', controller.getAllArtist);
router.get('/:id', controller.getArtistById);
router.get('/style/:id', controller.getArtistByStyle);
router.get('/medium/:id', controller.getArtistByMedium);

router.post('/', controller.createNewArtist);

module.exports = router;
