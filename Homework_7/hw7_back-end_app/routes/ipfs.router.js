const express = require('express');
const IPFSService = require('./../services/ipfs.service');

const router = express.Router();
const service = new IPFSService();

router.get('/:cid', async (req, res) => {
  try {
      const { cid } = req.params;
      const data = await service.findOne(cid);
      res.json({
        data
      });
  } catch (error) {
    console.log('error: '+error);
  }
});

router.post('/', async (req, res) => {
  const body = req.body;
  const data = await service.create(body.message);
  res.status(201).json({
    data
  });
});

module.exports = router;
