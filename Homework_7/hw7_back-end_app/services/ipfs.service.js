const IPFS = require('ipfs');
const all = require('it-all');
const createRepo = require('ipfs-repo');

class IPFSService {

  constructor() {

  }

  async create(data) {
    const node = await IPFS.create();
    const cid = await node.add(data);
    node.stop();
    console.log(cid.path)

    return cid;
  }

  async findOne(cid) {
    const node = await IPFS.create();
    const data = Buffer.concat(await all(node.cat(cid)));
    console.log(data.toString());
    node.stop();
    return data.toString();
  }

}

module.exports = IPFSService;
