import { ethers } from "hardhat";

async function main() {
  const MyStudent = await ethers.getContractFactory("MyStudent");
  const contract = await MyStudent.deploy();

//   await contract.deployed();

//   console.log("MyStudent contract deployed to:", contract.address);
  

  console.log("Student created!");
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
