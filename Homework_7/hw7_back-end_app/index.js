const express = require('express');
const fileUpload = require('express-fileupload');

const routerApi = require('./routes');

const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());
app.use(fileUpload());

app.get('/', (req, res) => {
  res.send('Hello from the other side');
});

app.post('/api/single-file', (req, res) => {
  const f = req.files.myfile;
  res.set('Content-Type', 'text/html');
  f.mv('./uploads/upload-' + f.name);
  res.send(`
    <table>
      <tr><td>Name</td><td>${f.name}</td></tr>
      <tr><td>Size</td><td>${f.size}</td></tr>
      <tr><td>MIME type</td><td>${f.mimetype}</td></tr>
    </table>
  `);
});

app.post('/api/multi-file', (req, res) => {
  const f = req.files.myfile;
  res.set('Content-Type', 'text/html');
  let response = `<table>`;
  for(const f of req.files.myfiles) {
    f.mv('./uploads/upload-' + f.name);
    response += `

        <tr>
          <td>Name: ${f.name}</td>
          <td>Size: ${f.size}</td>
          <td>MIME type: ${f.mimetype}</td>
        </tr>

    `;
  }
  response += `</table>`;
  res.send(response);
});

routerApi(app);

app.listen(port, () => {
  console.log('Mi port:' + port);
})
