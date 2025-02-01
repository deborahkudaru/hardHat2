// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Structs {
    address owner;

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
    // relative data
    // mapping (uint => string) names;
    mapping(uint256 => Student) students;

    // events
    event CreateStudent(
        string indexed name,
        string indexed class,
        uint8 indexed age
    );

    struct Student {
        string name; // fields, these are fields,each of these are fields
        uint8 age;
        string class;
        Gender gender;
    }

    uint256 studentId = 0;

    function setStudent(
        string memory _name,
        uint8 _age,
        string memory _class,
        Gender _gender
    ) external {
        Student memory student = Student({
            name: _name,
            age: _age,
            class: _class,
            gender: _gender
        });

        students[studentId] = student;
        studentId++;

        emit CreateStudent(_name, _class, _age);
    }

    function getStudents(
        uint8 _studentId
    ) public view returns (Student memory student_) {
        return student_ = students[_studentId];
    }

    function getAllStudents() public view returns (Student[] memory students_) {
        students_ = new Student[](studentId);

        for (uint8 i = 1; i < studentId; i++) {
            students_[i - 1] = students[i];
        }
        students_;
    }
}
