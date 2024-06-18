const prisma = require('../prisma/index'); 
const cookieToken = require('../utils/cookieToken');

// Create Event Controller
exports.createEvent = async (req, res) => {
    try {
        const { id, imageUrl, title, price, date, location, company } = req.body;

        // Check if all fields are provided
        if (!id || !imageUrl || !title || !price || !date || !location || !company) {
            throw new Error("Please provide all fields");
        }

        const event = await prisma.events.create({
            data: {
                id,
                imageUrl,
                title,
                price,
                date,
                location,
                company
            }
        });

        // Send an event token
        cookieToken(event, res);

    } catch (error) {
        res.status(500).send(error.message);
    }
};

// Fetch Event by ID Middleware
const fetchEventByIdMiddleware = async (req, res, next) => {
    const { id } = req.params;

    const parsedId = parseInt(id);

    if (isNaN(parsedId)) {
        return res.sendStatus(400);
    }

    const event = await prisma.events.findUnique({
        where: {
            id: parsedId,
        },
    });

    if (!event) {
        return res.status(404).json({ error: "Event not found" });
    }

    req.event = event;
    next();
};
exports.fetchEventByIdMiddleware = fetchEventByIdMiddleware;

// Delete Event Controller
exports.deleteEventController = async (req, res) => {
    const { event } = req;
    await prisma.events.delete({
        where: {
            id: event.id,
        },
    });

    res.status(200).json({ message: "Event deleted successfully" });
};

// Update Event Controller
exports.updateEventController = async (req, res) => {
    const { event } = req;
    const { imageUrl, title, price, date, location, company } = req.body;

    const updatedEvent = await prisma.events.update({
        where: {
            id: event.id,
        },
        data: {
            imageUrl: imageUrl || event.imageUrl,
            title: title || event.title,
            price: price || event.price,
            date: date || event.date,
            location: location || event.location,
            company: company || event.company,
        },
    });

    res.status(200).json({ message: "Event updated successfully", event: updatedEvent });
};

// Get All Events Controller
exports.getAllEvents = async (req, res) => {
    const events = await prisma.events.findMany();
    res.status(200).json(events);
};
