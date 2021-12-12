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

router.get('img/:cid', async (req, res) => {
  try {
      const { cid } = req.params;
      const data = await service.findImg(cid);
      res.send(
        `
          <img src='data:image/png;base64,'${data.toString()}>
        `
      );
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

router.post('/uploadImg', async (req, res) => {
  const f = req.files.myfile;
  res.set('Content-Type', 'text/html');
  f.mv('./uploads/upload-' + f.name);
  const data = await service.create(f.data);
  const data2 = await service.findImg(data.path);
  res.send(`
  <table>
    <tr><td>Name</td><td>${f.name}</td></tr>
    <tr><td>Size</td><td>${f.size}</td></tr>
    <tr><td>MIME type</td><td>${f.mimetype}</td></tr>
    <tr><td>Data result: </td><td>${data}</td></tr>
  </table>
`);

});
router.post('/uploadThings', async (req, res) => {
  const f = req.files.myfile;
  res.set('Content-Type', 'text/html');
  f.mv('./uploads/upload-' + f.name);
  const data = await service.create(f.data);

  res.send(`
    <table>
      <tr><td>Name</td><td>${f.name}</td></tr>
      <tr><td>Size</td><td>${f.size}</td></tr>
      <tr><td>MIME type</td><td>${f.mimetype}</td></tr>
      <tr><td>Data result: </td><td>${data}</td></tr>
    </table>
  `);
});


module.exports = router;
