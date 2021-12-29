const Bank = artifacts.require("bank_account");

module.exports = function (deployer) {
  deployer.deploy(Bank, 5000000000000000);
};
