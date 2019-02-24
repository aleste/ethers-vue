var NotarizeArba = artifacts.require('./NotarizeArba.sol')

module.exports = function (deployer) {
  deployer.deploy(NotarizeArba)
}