const { ethers } = require("hardhat");

async function main() {
  const whitelistContract = "0x252009bd624ade09dcaa1aa17e71be44ce2044bc";
  const ownerAddress = "0x16fa7aeb965b7292e1b7b140d6bcd849511cc343";
  // Verify the contract after deploying
  await hre.run("verify:verify", {
    address: "0xb631D9EF82AF1027785364333ea0B79e636f6758",
    constructorArguments: [whitelistContract, ownerAddress],
  });
}

// Call the main function and catch if there is any error
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
