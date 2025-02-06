// // SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract MyStudent {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the admin");
        _;
    }

    enum Gender {
        Male,
        Female
    }

    struct Student {
        string name;
        uint8 age;
        string class;
        Gender gender;
        bool exists;
    }

    mapping(uint256 => Student) private students;
    uint256 private studentId = 0;

    event CreateStudent(
        uint256 indexed studentId,
        string name,
        string class,
        uint8 age
    );

    function setStudent(
        string memory _name,
        uint8 _age,
        string memory _class,
        Gender _gender
    ) external onlyOwner {
        students[studentId] = Student({
            name: _name,
            age: _age,
            class: _class,
            gender: _gender,
            exists: true
        });

        emit CreateStudent(studentId, _name, _class, _age);
        studentId++;
    }

    function getStudents(uint256 _studentId)
        public
        view
        returns (Student memory)
    {
        require(students[_studentId].exists, "Student does not exist");
        return students[_studentId];
    }

    function getAllStudents() public view returns (Student[] memory) {
        Student[] memory studentsList = new Student[](studentId);

        for (uint256 i = 0; i < studentId; i++) {
            studentsList[i] = students[i];
        }
        return studentsList;
    }

    function checkStudent(uint256 _studentId) public view returns (bool) {
        return students[_studentId].exists;
    }

    function deleteStudent(uint256 _studentId) external onlyOwner {
        require(students[_studentId].exists, "Student does not exist");
        delete students[_studentId];
    }

    function assignUniform(uint256 _studentId)
        external
        view
        onlyOwner
        returns (string memory)
    {
        require(students[_studentId].exists, "Student does not exist");

        if (students[_studentId].gender == Gender.Male) {
            return "Blue Shirt & Black Trouser";
        } else {
            return "White Blouse & Blue Skirt";
        }
    }
}
