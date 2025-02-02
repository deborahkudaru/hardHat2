import { ethers } from "hardhat";

async function main() {
    const [deployer] = await ethers.getSigners();
    console.log("Deploying contract with account:", deployer.address);

    const MyStudent = await ethers.getContractFactory("MyStudent");
    const myStudent = await MyStudent.deploy();

    await myStudent.waitForDeployment();
    const contractAddress = await myStudent.getAddress();
    
    console.log("Contract deployed at:", contractAddress);

    const tx = await myStudent.setStudent("Alice", 18, "12th Grade", 1);
    await tx.wait();
    console.log("Added a student.");

    const student = await myStudent.getStudents(0);
    console.log("Student Details:", student);

    const exists = await myStudent.checkStudent(0);
    console.log("Does student exist?", exists);

    const uniform = await myStudent.assignUniform(0);
    console.log("Uniform assigned:", uniform);
}

main().catch((error) => {
    console.error(error);
    process.exit(1);
});
