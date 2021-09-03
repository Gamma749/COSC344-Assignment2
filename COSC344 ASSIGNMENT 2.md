# COSC344 Assignment 1 Report

Leader: Hayden McAlister

Members: Masaaki Fukushima, Jack Heikell, Nat Moore

## Entity-Relationship Model
- ### Student
| Attribute   | Simplicity  | Num-Values  | Data Type   |
| ----------- | ----------- | ----------- | ----------- |
| Student_ID | Simple, Not NULL | Single-valued | Int (key Attribute) |
| Name | Simple, Not NULL | Single-valued | String |
| Phone | Simple | Single-valued | String |
| Address | Composite<br>(Street_Number: int[1,10000],<br>Street_Name: Str, Suburb: Str) | Multi-valued | String |
| Course | Simple | Multi-valued | String | TODO: By reference?
| Enrollment_Date | Simple, Not NULL | Single-valued | Date |
| Graduate_Date | Simple | Single-valued | Date |
| Graduated_bool | Derived<br>(From existence of Graduate_Date) | Single-valued | Boolean |

- ### Staff
| Attribute   | Simplicity  | Num-Values  | Data Type   |
| ----------- | ----------- | ----------- | ----------- |
| Staff_ID | Simple, Not NULL | Single-valued | Int (Key Attribute) |
| Name | Simple, Not NULL | Single-valued | String |
| Phone | Simple | Single-valued | String |
| Address | Composite<br>(Street_Number: int[1,10000],<br>Street_Name: Str, Suburb: Str) | Multi-valued | String |
| Salary | Simple, Not NULL | Single-valued | Float |
| IRD_Num | Simple, not NULL | Single-valued | Int |

- ### Department
| Attribute   | Simplicity  | Num-Values  | Data Type   |
| ----------- | ----------- | ----------- | ----------- |
| Name | Simple | Single-valued | String (Key Attribute)|
| Campus | Simple | Derived<br>(From Campus Reference) | String |
| Number_of_Employees | Composite<br>(Number_of_academic_staff: int,<br> Number_of_nonacademic_staff: int) | Single-valued | int |
| Number_of_Students | Derived<br>(from Student references) | Single-valued | int |
| Address | Derived<br>(from Building references) | Multi-valued | String |

- ### Course
| Attribute   | Simplicity  | Num-Values  | Data Type   |
| ----------- | ----------- | ----------- | ----------- |
| Name | Simple | Single-valued | String (Key Attribute) |
| Years_required | Simple | Single-valued | int |
| Undergraduate | Simple | Single-valued | boolean |
| Postgraduate | Simple | Single-valued | boolean |
| Number_of_Students | Derived<br>(from Student references) | Single-valued | int |

- ### Paper
| Attribute   | Simplicity  | Num-Values  | Data Type   |
| ----------- | ----------- | ----------- | ----------- |
| Paper_Code | Simple | Single-valued | String (Key Attribute) |
| Semester | Simple | Multi-valued | String (Enumerated) |
| Points | Simple | Single-valued | Int |  

- ### Campus
| Attribute   | Simplicity  | Num-Values  | Data Type   |
| ----------- | ----------- | ----------- | ----------- |
| Name | Single-valued | Single-valued | String (Key Attribute) |
| Main_Office_Address | Single-valued | Single-valued | String |
| Phone | Simple | Single-valued | String (Candidate Key) |
| Email | Simple | Single-valued | String (Candidate Key) |

- ### Building
| Attribute   | Simplicity  | Num-Values  | Data Type   |
| ----------- | ----------- | ----------- | ----------- |
| Address | Composite<br>(Street_Number: int[1,10000],<br>Street_Name: Str, Suburb: Str) | Single-valued | String (Key Attribute) |
| Postcode | Simple | Single-valued | Int (Four Digit) |
| Name | Simple | Single-valued | String |

- ### Room
| Attribute   | Simplicity  | Num-Values  | Data Type   |
| ----------- | ----------- | ----------- | ----------- |
| Room Number | Simple | Single-valued | Int, [1,10000] (Partial Key)|
| Seating | Simple | Single-valued | Int [1,10000] |
| Accessibility | Simple | Single-valued | Boolean |
| Projector | Simple | Single-valued | Boolean |

# Mapping to Relational Model
---
## Step 1: Mapping Regular Entity Types

##### Name
| | | |

##### Building
- Decompose composite attribute and add all simple attributes, add weak key to primary key

| <u>Street_Number</u> | <u>Street_Name</u> | <u>Suburb</u> | Postcode | Name |
| ----------- | ----------- | ----------- | ----------- | ----------- |

##### Department

| <u>Name</u> | Number_Of_Academic_Staff | Number_Of_Nonacademic_Staff |
| ----------- | ------------------------ | --------------------------- |

##### Course 

| <u>Name</u> | Years_Required | Undergraduate | Postgraduate |
| ----------- | -------------- | ------------- | ------------ |

##### Paper
| <u>Paper_code</u> | Semester (Multi-value) | Points |
| ----------------- | ---------------------- |------- |

##### Campus
| <u>Name</u> | Main_Office_Address | Phone | Email |
| ----------- | ------------------- | ----- | ----- |

---
## Step 2: Mapping Weak Entity Types

##### Room
- Add as primary key reference the primary key of building

| <u>Street_Number</u><br>(REFERENCES Building) | <u>Street_Name</u><br>(REFERENCES Building)  | <u>Suburb</u><br>(REFERENCES Building)  | <u>Room Number</u>| Seating | Accessibility | Projector |
| ----------- | ----------- | ----------- | ----------- | ----------- |----------- | ----------- |

---
## Step 3: Mapping of binary 1:1 Relationships

##### DEAN_OF (Campus 1:1 Staff)
| <u>Name</u> | Main_Office_Address | Phone | Email | Dean (Staff ID Reference) (NEW) |
| ----------- | ------------------- | ----- | ----- | ------------------------------- |
- Added Staff ID to campus, as campus has total participation

---
## Step 4: Mapping of Binary 1:N Relationships

##### Offers (Department 1:N Paper)
- Add as foreign key to Paper the primary key of Department

##### Paper
| <u>Paper_Code</u> | Semester | Points | Department_Name<br>(REFERENCES Department) |
| ----------------- | -------- | ------ | ------------------------------------------ | 


##### LOCATED_ON (Building N:1 Campus)
- Add as foreign key to Building the primary key of Campus

##### Building
| <u>Street_Number</u> | <u>Street_Name</u> | <u>Suburb</u> | Postcode | Building_Name | Campus_Name<br>(REFERENCES Campus) |
| ----------- | ----------- | ----------- | ----------- | ----------- |----------- |

##### LOCATED_IN (Room N:1 Building)
- Add as foreign key to Room the primary key of Campus
- Already done in step 2 (weak entity mapping)

##### STUDENT AT (Student N:1 Campus)
- Add foreign key of campus to each student

---
## Step 4.5: Mapping of Binary 2:N Relationships

##### Enrolled_In (Student 2:N Course)
- Add as a foreign key to Student the primary key of the first Course
- Add as a foreign key to Student the primary key of the second Course

##### Student
| <u>Student_ID</u> | Name | Phone | Address | Enrollment_Date | Graduate_Date | Graduated_Bool | Course_One<br>(REFERENCES Course) | Course_Two<br>(REFERENCES Course |
| ----------------- | ---- | ----- | ------- | --------------- | ------------- | -------------- | ----------------------------------| ---------------------------------| 

---
## Step 5: Mapping of Binary M:N Relationships

##### Based In (Building M:N Department)
- Create new Relation with primary key of each related entity

##### Dept_Based_In_Building
| <u>Dept_Name</u><br>(REFERENCES Department) | <u>Street_Number</u><br>(REFERENCES Building) | <u>Street_Name</u><br>(REFERENCES Building)  | <u>Suburb</u><br>(REFERENCES Building)  |
| ----------- | ----------- | ----------- | ----------- |

##### Lectured_In (Room M:N Paper)
- Create new Relation with primary key of each related entity

##### Paper_Lectured_In_Room
| <u>Paper_Code</u><br>(REFERENCES Paper) | <u>Street_Number</u><br>(REFERENCES Building) | <u>Street_Name</u><br>(REFERENCES Building)  | <u>Suburb</u><br>(REFERENCES Building)  | <u> Room Number</u> |
| ----------- | ----------- | ----------- | ----------- |----------- |

##### Works_For(Staff M:N Department)
- Create new Relation with primary key of each related entity

##### Staff_Member_Works_For_Department
| <u>Staff_Member_Id</u><br>(REFERENCES Staff) | <u>Department_Name</u><br>(REFERENCES Department) |
| -------------------------------------------- | ------------------------------------------------- |

##### Counts_Toward(Paper M:N Course)
- Create new Relation with primary key of each related entity

##### Paper_Counts_Toward_Course
| <u>Paper_Code</u><br>(REFERENCES Paper) | <u>Course_Name</u><br>(REFERENCES Course) |
| --------------------------------------- | ----------------------------------------- |

##### Possible_Major_For(Department M:N Course)
- Create new Relation with primary key of each related entity 

##### Department_Offers_Major_For_Course
| <u>Department_Name</u><br>(REFERENCES Department) | <u>Course_Name</u><br>(REFERENCES Course) |
| ------------------------------------------------- | ----------------------------------------- |

##### Teaches (Staff N:M Paper)
| <u>Teaching staff (Staff ID)</u> | <u>Paper (Paper_code)</u> |
| -------------------------------- | ------------------------- |

##### Offered_At (Paper N:M Campus)
| <u>Paper (Paper_Code)</u> | <u>Campus Name</u> |
| ------------------------- | ------------------ |

##### Takes (Student N:M Paper)
| <u>Student_ID</u> | <u>Paper_code</u> |
| ----------------- | ----------------- |

---
## Step 6: Mapping of Multi-valued attributes

##### Paper_Semesters
| <u>Paper_code</u> | Semester |
| ----------------- | -------- |

##### Paper
| <u>Paper_code</u> | Points |
| ----------------- | ------ |

- [ Paper | Semesters | Points ] split into [ Paper | Semester ] and [ Paper | Points ] 

---
## Step 7: Mapping of N-ary Relationship types

---
# Mapped Relational Model 
<!-- TODO: Make this a diagram -->

### Building
| <u>Street_Number</u> | <u>Street_Name</u> | <u>Suburb</u> | Postcode | Building_Name | Campus_Name<br>(REFERENCES Campus) |
| ----------- | ----------- | ----------- | ----------- | ----------- |----------- |

### Room
| <u>Street_Number</u><br>(REFERENCES Building) | <u>Street_Name</u><br>(REFERENCES Building)  | <u>Suburb</u><br>(REFERENCES Building)  | <u>Room Number</u>| Seating | Accessibility | Projector |
| ----------- | ----------- | ----------- | ----------- | ----------- |----------- | ----------- |

### Department

| <u>Name</u> | Number_Of_Academic_Staff | Number_Of_Nonacademic_Staff |
| ----------- | ------------------------ | --------------------------- |

### Course 

| <u>Name</u> | Years_Required | Level |
| ----------- | -------------- | ------------- |

##### Paper
| <u>Paper_Code</u> | Semester | Points | Department_Name<br>(REFERENCES Department) |
| ----------------- | -------- | ------ | ------------------------------------------ |

##### Student
| <u>Student_ID</u> | Name | Phone | Address | Enrollment_Date | Graduate_Date | Graduated_Bool | Course_One<br>(REFERENCES Course) | Course_Two<br>(REFERENCES Course |
| ----------------- | ---- | ----- | ------- | --------------- | ------------- | -------------- | ----------------------------------| ---------------------------------| 

### Dept_Based_In_Building
| <u>Dept_Name</u><br>(REFERENCES Department) | <u>Street_Number</u><br>(REFERENCES Building) | <u>Street_Name</u><br>(REFERENCES Building)  | <u>Suburb</u><br>(REFERENCES Building)  |
| ----------- | ----------- | ----------- | ----------- |

### Paper_Lectured_In_Room
| <u>Paper_Code</u><br>(REFERENCES Paper) | <u>Street_Number</u><br>(REFERENCES Building) | <u>Street_Name</u><br>(REFERENCES Building)  | <u>Suburb</u><br>(REFERENCES Building)  | <u> Room Number</u> |
| ----------- | ----------- | ----------- | ----------- |----------- |

##### Department_Offers_Major_For_Course
| <u>Department_Name</u><br>(REFERENCES Department) | <u>Course_Name</u><br>(REFERENCES Course) |
| ------------------------------------------------- | ----------------------------------------- |

##### Paper_Counts_Toward_Course
| <u>Paper_Code</u><br>(REFERENCES Paper) | <u>Course_Name</u><br>(REFERENCES Course) |
| --------------------------------------- | ----------------------------------------- |

##### Staff_Member_Works_For_Department
| <u>Staff_Member_Id</u><br>(REFERENCES Staff) | <u>Department_Name</u><br>(REFERENCES Department) |
| -------------------------------------------- | ------------------------------------------------- |

# Normalization

## 1NF
Definition: All values are atomic
- This is true from the mapping process from ERD to Relational Model

---
## 2NF
Definition: 1NF and every non-key attribute is fully dependent on the primary key

##### Building
- Postcode is dependent only on street name and suburb, but not street number
- Remove postcode to its own entity, make a foreign key reference

- ##### Building
| <u>Street_Number</u> | <u>Street_Name</u><br>(REFERENCES postcode) | <u>Suburb</u><br>(REFERENCES postcode) | Building_Name | Campus_Name<br>(REFERENCES Campus) |
| ----------- | ----------- | ----------- | ----------- | ----------- |

- ##### Postcode
| <u>Street_Name</u> | <u>Suburb</u> | Postcode |
| ----------- | ----------- | ----------- |

---
## 3NF
Definition: 2NF and no non-prime attribute is transitively dependent on the primary key

---
## BCNF
Definition: 3NF and for every non-trivial functional dependency X->A, X is a superkey of R

---

# Normalized Relational Model 
<!-- TODO: Make this a diagram -->

### Building
| <u>Street_Number</u> | <u>Street_Name</u><br>(REFERENCES postcode) | <u>Suburb</u><br>(REFERENCES postcode) | Building_Name | Campus_Name<br>(REFERENCES Campus) |
| ----------- | ----------- | ----------- | ----------- | ----------- |

### Room
| <u>Street_Number</u><br>(REFERENCES Building) | <u>Street_Name</u><br>(REFERENCES Building)  | <u>Suburb</u><br>(REFERENCES Building)  | <u>Room Number</u>| Seating | Accessibility | Projector |
| ----------- | ----------- | ----------- | ----------- | ----------- |----------- | ----------- |

### Postcode
| <u>Street_Name</u> | <u>Suburb</u> | Postcode |
| ----------- | ----------- | ----------- |

### Department

| <u>Name</u> | Number_Of_Academic_Staff | Number_Of_Nonacademic_Staff |
| ----------- | ------------------------ | --------------------------- |

### Course 

| <u>Name</u> | Years_Required | Level |
| ----------- | -------------- | ------------- |

### Dept_Based_In_Building
| <u>Dept_Name</u><br>(REFERENCES Department) | <u>Street_Number</u><br>(REFERENCES Building) | <u>Street_Name</u><br>(REFERENCES Building)  | <u>Suburb</u><br>(REFERENCES Building)  |
| ----------- | ----------- | ----------- | ----------- |

### Paper_Lectured_In_Room
| <u>Paper_Code</u><br>(REFERENCES Paper) | <u>Street_Number</u><br>(REFERENCES Building) | <u>Street_Name</u><br>(REFERENCES Building)  | <u>Suburb</u><br>(REFERENCES Building)  | <u> Room Number</u> |
| ----------- | ----------- | ----------- | ----------- |----------- |

### Staff_Member_Works_For_Department
| <u>Staff_Member_Id</u><br>(REFERENCES Staff) | <u>Department_Name</u><br>(REFERENCES Department) |
| -------------------------------------------- | ------------------------------------------------- |

### Paper_Counts_Toward_Course
| <u>Paper_Code</u><br>(REFERENCES Paper) | <u>Course_Name</u><br>(REFERENCES Course) |
| --------------------------------------- | ----------------------------------------- |


### Department_Offers_Major_For_Course
| <u>Department_Name</u><br>(REFERENCES Department) | <u>Course_Name</u><br>(REFERENCES Course) |
| ------------------------------------------------- | ----------------------------------------- |



