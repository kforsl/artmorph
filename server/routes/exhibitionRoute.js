const express = require('express');
const controller = require('../controllers/exhibitionController');
const router = express.Router();

router.get('/', controller.getAllExhibition);
router.get('/:id', controller.getExhibitionById);
router.get('/style/:id', controller.getExhibitionByStyle);
router.get('/medium/:id', controller.getExhibitionByMedium);

router.post('/', controller.createExhibition);

module.exports = router;
