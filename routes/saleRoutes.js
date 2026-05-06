const express = require("express");
const router = express.Router();

const verifyToken = require("../authMiddleware");
const {
  buyReport
} = require("../controllers/saleController");

// Purchase content
router.post("/buy", verifyToken, buyReport);

module.exports = router;
