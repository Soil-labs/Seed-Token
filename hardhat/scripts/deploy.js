const { ethers } = require("hardhat");

async function main() {
  const seedContract = await ethers.getContractFactory("Seeds");

  const whitelistContract = "0x252009bd624ade09dcaa1aa17e71be44ce2044bc";
  const ownerAddress = "0x16fa7aeb965b7292e1b7b140d6bcd849511cc343";

  // here we deploy the contract
  const deployedSeedContract = await seedContract.deploy(
    whitelistContract,
    ownerAddress
  );
  // address of whitelist contract
  // address of Owner of the contract

  // Wait for it to finish deploying
  await deployedSeedContract.deployed();

  // print the address of the deployed contract
  console.log("Seed Contract Address:", deployedSeedContract.address);

  console.log("Sleeping.....");
  // Wait for etherscan to notice that the contract has been deployed
  await sleep(10000);

  // Verify the contract after deploying
  await hre.run("verify:verify", {
    address: deployedSeedContract.address,
    constructorArguments: [whitelistContract, ownerAddress],
  });
}

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

// Call the main function and catch if there is any error
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
