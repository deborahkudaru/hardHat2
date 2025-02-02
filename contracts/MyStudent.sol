// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract MyStudent {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the admin");
        _;
    }

    modifier exists() {
         _;
        require(students[studentId].exists, "Student does not exist");
       
    }

    enum Gender {
        Male,
        Female
    }

    mapping(uint256 => Student) students;

    event CreateStudent(
        string indexed name,
        string indexed class,
        uint8 indexed age
    );

    struct Student {
        string name;
        uint8 age;
        string class;
        Gender gender;
        bool exists;
    }

    uint256 studentId = 0;

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

        studentId++;

        emit CreateStudent(_name, _class, _age);
    }

    function getStudents(uint8 _studentId)
        public
        view
        returns (Student memory student_)
    {
        return student_ = students[_studentId];
    }

    function getAllStudents() public view returns (Student[] memory students_) {
        students_ = new Student[](studentId);

        for (uint8 i = 1; i < studentId; i++) {
            students_[i - 1] = students[i];
        }
        students_;
    }

    function checkStudent(uint8 _studentId) public view returns (bool) {
        return students[_studentId].exists;
    }

    function deleteStudent(uint8 _studentId) external onlyOwner {
        students[_studentId].exists = false;
    }

    function assignUniform(uint8 _studentId)
        external
        view
        onlyOwner
        // exists
        returns (string memory)
    {
        if (students[_studentId].gender == Gender.Male) {
            return "Blue Shirt & Black Pants";
        } else {
            return "White Blouse & Blue Skirt";
        }
    }
}
