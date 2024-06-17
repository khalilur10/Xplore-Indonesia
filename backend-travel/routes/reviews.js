const express = require('express');
const { Review, User, Destinasi } = require('../models');
const { success, error } = require('../helpers/responseHelper');
const router = express.Router();

const BASE_URL = `http://localhost:3000`;

// Create a new review
router.post('/', async (req, res) => {
  try {
    const { user_id, destinasi_id, rating, komentar } = req.body;

    // Create new review
    const newReview = await Review.create({ user_id, destinasi_id, rating, komentar });
    res.status(200).json(success(newReview));
  } catch (err) {
    res.status(200).json(error(err.message));
  }
});

// Get all reviews
router.get('/', async (req, res) => {
  try {
    const reviews = await Review.findAll({
      include: [
        {
          model: User,
          attributes: ['name', 'email', 'phone'],
        },
        {
          model: Destinasi,
          attributes: ['name', 'alamat', 'daerah', 'negara', 'images', 'deskripsi'],
        }
      ]
    });

    const result = reviews.map(review => {
      if (review.Destinasi) {
        review.Destinasi.images = `${BASE_URL}${review.Destinasi.images}`;
      }
      return review;
    });

    res.status(200).json(success(result));
  } catch (err) {
    res.status(200).json(error(err.message));
  }
});

// Get reviews by destinasi_id
router.get('/destinasi/:destinasi_id', async (req, res) => {
  try {
    const { destinasi_id } = req.params;
    const reviews = await Review.findAll({
      where: { destinasi_id },
      include: [
        {
          model: User,
          attributes: ['name', 'email', 'phone'],
        },
        {
          model: Destinasi,
          attributes: ['name', 'alamat', 'daerah', 'negara', 'images', 'deskripsi'],
        }
      ]
    });

    const result = reviews.map(review => {
      if (review.Destinasi) {
        review.Destinasi.images = `${BASE_URL}${review.Destinasi.images}`;
      }
      return review;
    });

    if (result.length > 0) {
      res.status(200).json(success(result));
    } else {
      res.status(200).json(error('No reviews found for this destinasi.'));
    }
  } catch (err) {
    res.status(200).json(error(err.message));
  }
});

// Get reviews by user_id
router.get('/user/:user_id', async (req, res) => {
  try {
    const { user_id } = req.params;
    const reviews = await Review.findAll({
      where: { user_id },
      include: [
        {
          model: User,
          attributes: ['name', 'email', 'phone'],
        },
        {
          model: Destinasi,
          attributes: ['name', 'alamat', 'daerah', 'negara', 'images', 'deskripsi'],
        }
      ]
    });

    const result = reviews.map(review => {
      if (review.Destinasi) {
        review.Destinasi.images =`${BASE_URL}${review.Destinasi.images}`;;
      }
      return review;
    });

    if (result.length > 0) {
      res.status(200).json(success(result));
    } else {
      res.status(200).json(error('No reviews found for this user.'));
    }
  } catch (err) {
    res.status(200).json(error(err.message));
  }
});

// Get a review by ID
router.get('/:id', async (req, res) => {
  try {
    const review = await Review.findByPk(req.params.id, {
      include: [
        {
          model: User,
          attributes: ['name', 'email', 'phone'],
        },
        {
          model: Destinasi,
          attributes: ['name', 'alamat', 'daerah', 'negara', 'images', 'deskripsi'],
        }
      ]
    });

    if (review) {
      if (review.Destinasi) {
        review.Destinasi.images = `${BASE_URL}${review.Destinasi.images}`;
      }
      res.status(200).json(success(review));
    } else {
      res.status(200).json(error('Review not found'));
    }
  } catch (err) {
    res.status(200).json(error(err.message));
  }
});

// Update a review
router.put('/:id', async (req, res) => {
  try {
    const { user_id, destinasi_id, rating, komentar } = req.body;

    if (!user_id && !destinasi_id && !rating && !komentar) {
      return res.status(200).json(error('At least one field must be provided'));
    }

    const updateFields = {};
    if (user_id) updateFields.user_id = user_id;
    if (destinasi_id) updateFields.destinasi_id = destinasi_id;
    if (rating) updateFields.rating = rating;
    if (komentar) updateFields.komentar = komentar;

    const [updated] = await Review.update(updateFields, {
      where: { review_id: req.params.id }
    });

    if (updated) {
      const updatedReview = await Review.findByPk(req.params.id, {
        include: [
          {
            model: User,
            attributes: ['name', 'email', 'phone'],
          },
          {
            model: Destinasi,
            attributes: ['name', 'alamat', 'daerah', 'negara', 'images', 'deskripsi'],
          }
        ]
      });

      if (updatedReview.Destinasi) {
        updatedReview.Destinasi.images = `${BASE_URL}${updatedReview.Destinasi.images}`;
      }

      res.status(200).json(success(updatedReview));
    } else {
      res.status(200).json(error('Review not found'));
    }
  } catch (err) {
    res.status(200).json(error(err.message));
  }
});

// Delete a review
router.delete('/:id', async (req, res) => {
  try {
    const deleted = await Review.destroy({
      where: { review_id: req.params.id }
    });

    if (deleted) {
      res.status(200).json(success(null, 'Review deleted successfully'));
    } else {
      res.status(200).json(error('Review not found'));
    }
  } catch (err) {
    res.status(200).json(error(err.message));
  }
});

module.exports = router;
