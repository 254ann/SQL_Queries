const jwt = require("jsonwebtoken");

const getJwtToken = (eventId) => {
  return jwt.sign({ eventId: eventId }, process.env.JWT_SECRET, {
    expiresIn: "1 day",
  });
};

module.exports = getJwtToken;