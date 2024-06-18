const express = require('express');
const router = express.Router();

const { 
    createEvent, 
    deleteEventController, 
    updateEventController, 
    getAllEvents, 
    fetchEventByIdMiddleware 
} = require('../controllers/eventControllers');

router.route('/createEvent').post(createEvent);
router.route('/deleteEvent/:id').delete(fetchEventByIdMiddleware, deleteEventController);
router.route('/updateEvent/:id').put(fetchEventByIdMiddleware, updateEventController);
router.route('/events').get(getAllEvents);

module.exports = router;
