const express = require('express');

const ipfsRouter = require('./ipfs.router');

function routerApi(app) {
  const router = express.Router();
  app.use('/api/v1', router);
  router.use('/ipfs', ipfsRouter);
}

module.exports = routerApi;
