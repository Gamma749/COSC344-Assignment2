DROP TABLE postcode cascade constraints;
CREATE TABLE postcode(
    street_name VARCHAR2(50),
    suburb VARCHAR2(50),
    postcode NUMBER,
    CONSTRAINT postcode_pkey PRIMARY KEY(street_name, suburb)
);

INSERT INTO postcode VALUES ('Great King Street', 'Dunedin North', 9016);
INSERT INTO postcode VALUES ('Union Street', 'Dunedin North', 9016);
INSERT INTO postcode VALUES ('Albany Street', 'Dunedin North', 9016);
INSERT INTO postcode VALUES ('Riccarton Avenue', 'Christchurch Central', 8011);
INSERT INTO postcode VALUES ('Mein Street', 'Wellington', 6242);


DROP TABLE building cascade constraints;
CREATE TABLE building(
    street_number NUMBER,
    street_name VARCHAR2(50),
    suburb VARCHAR2(50),
    building_name VARCHAR2(50),
    campus_name VARCHAR2(50),
    CONSTRAINT building_pkey PRIMARY KEY(street_number, street_name, suburb),
    CONSTRAINT building_postcode_fkey FOREIGN KEY(street_name, suburb) REFERENCES postcode(street_name, suburb) 
);

INSERT INTO building VALUES(111, 'Union Street', 'Dunedin North', 'Owheo', 'Dunedin');
INSERT INTO building VALUES(95, 'Albany Street', 'Dunedin North', 'Burns', 'Dunedin');
INSERT INTO building VALUES(65, 'Albany Street', 'Dunedin North', 'Central Library', 'Dunedin');
INSERT INTO building VALUES(464, 'Great King Street', 'Dunedin North', 'Botany', 'Dunedin');
INSERT INTO building VALUES(2, 'Riccarton Avenue', 'Christchurch Central', 'Christchurch Hospital', 'Christchurch');
INSERT INTO building VALUES(23, 'Mein Street', 'Wellington', 'Wellington Hospital', 'Wellington');



DROP TABLE room cascade constraints;
CREATE TABLE room(
    street_number NUMBER,
    street_name VARCHAR2(50),
    suburb VARCHAR2(50),
    room_number NUMBER,
    seating NUMBER NOT NULL,
    accessibility NUMBER(1) NOT NULL,
    projector NUMBER(1) NOT NULL,
    CONSTRAINT room_pkey PRIMARY KEY(street_number, street_name, suburb, room_number),
    CONSTRAINT room_building_fkey FOREIGN KEY (street_number, street_name, suburb) REFERENCES building(street_number, street_name, suburb)
);

INSERT INTO room VALUES(111, 'Union Street', 'Dunedin North', 1, 24, 1, 0);
INSERT INTO room VALUES(111, 'Union Street', 'Dunedin North', 2, 30, 1, 1);
INSERT INTO room VALUES(111, 'Union Street', 'Dunedin North', 3, 14, 0, 1);
INSERT INTO room VALUES(111, 'Union Street', 'Dunedin North', 4, 2, 0, 0);
INSERT INTO room VALUES(111, 'Union Street', 'Dunedin North', 5, 3, 0, 0);
INSERT INTO room VALUES(95, 'Albany Street', 'Dunedin North', 1, 65, 1, 1);
INSERT INTO room VALUES(95, 'Albany Street', 'Dunedin North', 2, 80, 1, 1);
INSERT INTO room VALUES(464, 'Great King Street', 'Dunedin North', 1, 40, 0, 0);
INSERT INTO room VALUES(2, 'Riccarton Avenue', 'Christchurch Central', 1, 20, 1, 1);
INSERT INTO room VALUES(23, 'Mein Street', 'Wellington', 1, 25, 1, 1);



DROP TABLE department cascade constraints;
CREATE TABLE department(
    dname VARCHAR2(25) PRIMARY KEY,
    number_of_academic_staff INT NOT NULL,
    number_of_nonacademic_staff INT
);

INSERT INTO department VALUES ('Computer Science', 20, 1);
INSERT INTO department VALUES ('Health Science', 100, 200);
INSERT INTO department VALUES ('English', 11, 1);
INSERT INTO department VALUES ('Zoology', 31, 4);
INSERT INTO department VALUES ('Botany', 12, 5);
INSERT INTO department VALUES ('Theology', 11, 1);



DROP TABLE campus cascade constraints;
CREATE TABLE campus (
	name				VARCHAR2(80)		NOT NULL	PRIMARY KEY,
	street_number       NUMBER,      
    street_name         VARCHAR2(50),  
    suburb              VARCHAR2(50),
	phone				VARCHAR2(20),
	email				VARCHAR2(40),
	dean_id				NUMBER(8,0)
);

INSERT INTO campus VALUES ('Dunedin', 362, 'Leith Street', 'Dunedin Central', '0800 80 80 98', 'university@otago.ac.nz', 12345);
INSERT INTO campus VALUES ('Christchurch', 2, 'Riccarton Avenue', 'Christchurch Central', '64 3 364 0530', 'christchurch@otago.ac.nz', 23456);
INSERT INTO campus VALUES ('Wellington', 23, 'Mein Street', 'Wellington', '64 4 385 5541', 'wellington@otago.ac.nz', 34567);

ALTER TABLE building ADD CONSTRAINT building_campus_fkey
FOREIGN KEY (campus_name) REFERENCES campus(name);



DROP TABLE course cascade constraints;
CREATE TABLE course(
    course_name VARCHAR2(25) PRIMARY KEY,
    years_required INT NOT NULL,
    postgraduate_bool NUMBER(1) NOT NULL,
    coordinator_id NUMBER(8,0)
);

INSERT INTO course VALUES('Bachelor of Arts', 3, 0, 12345);
INSERT INTO course VALUES('Bachelor of Science', 3, 0, 23456);
INSERT INTO course VALUES('Diploma in Language', 3, 0, 34567);
INSERT INTO course VALUES('Doctor of Philosophy', 3, 1, 45678);
INSERT INTO course VALUES('Master of Finance', 1, 1, 56789);



DROP TABLE student cascade constraints;
CREATE TABLE student(
	student_id NUMBER(8,0) NOT NULL PRIMARY KEY,
	name VARCHAR2(50) NOT NULL, 
	phone VARCHAR2(50) NOT NULL,
	street_number NUMBER NOT NULL, 
	street_name VARCHAR2(50) NOT NULL,
	enrollment DATE NOT NULL,
	graduation DATE, 
	campus VARCHAR2(80) REFERENCES campus(name)
);

INSERT INTO student VALUES(11111111, 'Debra Green', '479-926-5770', 2, 'High Street', TO_DATE('2018-7-27', 'YYYY-MM-DD'), NULL, 'Dunedin');
INSERT INTO student VALUES(22222222, 'Freya Johnson', '724-431-8639', 54, 'South Road', TO_DATE('2020-8-19', 'YYYY-MM-DD'), NULL, 'Dunedin');
INSERT INTO student VALUES(33333333, 'Mark Fairburn', '636-730-6066', 128, 'Binary Drive', TO_DATE('2019-4-22', 'YYYY-MM-DD'), NULL, 'Dunedin');
INSERT INTO student VALUES(44444444, 'Morton Love', '731-632-7212', 8, 'Byte Way', TO_DATE('2014-7-16', 'YYYY-MM-DD'), TO_DATE('2018-10-10', 'YYYY-MM-DD'), 'Christchurch');
INSERT INTO student VALUES(55555555, 'Zane Eustis', '815-863-2288', 255, 'HexFF Street', TO_DATE('2019-2-22', 'YYYY-MM-DD'), NULL, 'Christchurch');
INSERT INTO student VALUES(66666666, 'Riley Rogers', '928-330-5166', 256, 'Overflow Drive', TO_DATE('2020-5-21', 'YYYY-MM-DD'), NULL, 'Wellington');



DROP TABLE enrolled_in cascade constraints;
CREATE TABLE enrolled_in(
    student_id NUMBER(8,0),
    course_name VARCHAR2(25),
    CONSTRAINT enrolled_in_pkey PRIMARY KEY (student_id, course_name),
    CONSTRAINT enrolled_in_student_fkey FOREIGN KEY(student_id) REFERENCES student(student_id),
    CONSTRAINT enrolled_in_course_fkey FOREIGN KEY(course_name) REFERENCES course(course_name)
);

INSERT INTO enrolled_in VALUES(11111111, 'Bachelor of Arts');
INSERT INTO enrolled_in VALUES(22222222, 'Bachelor of Science');
INSERT INTO enrolled_in VALUES(33333333, 'Bachelor of Science');
INSERT INTO enrolled_in VALUES(44444444, 'Master of Finance');
INSERT INTO enrolled_in VALUES(55555555, 'Diploma in Language');
INSERT INTO enrolled_in VALUES(66666666, 'Doctor of Philosophy');



DROP TABLE staff cascade constraints;
CREATE TABLE staff(
    staff_id NUMBER(8,0) NOT NULL PRIMARY KEY,
	name VARCHAR(50) NOT NULL, 
	phone VARCHAR(50) NOT NULL,
	street_number NUMBER NOT NULL,
    street_name VARCHAR2(50) NOT NULL,
	salary NUMBER NOT NULL, 
	IRD_Num NUMBER NOT NULL, 
	campus VARCHAR2(50) NOT NULL REFERENCES campus(name),
	department VARCHAR2(50) NOT NULL REFERENCES department(dname)
);

INSERT INTO staff VALUES(12345,'Dallas Elmer','027123456789','1','Example Avenue',80000,12345678,'Dunedin','English');
INSERT INTO staff VALUES(23456,'Lesia Colbert','027987654321','2','Example Avenue',85000,12345678,'Dunedin','Zoology');
INSERT INTO staff VALUES(34567,'Daniella Barnes','027000000001','3','Example Avenue',92000,12345678,'Christchurch','Zoology');
INSERT INTO staff VALUES(45678,'Lora Sargent','02123456789','1','Demonstration Street',50000,12345678,'Christchurch','Computer Science');
INSERT INTO staff VALUES(56789,'Lita Williams','02234567891','100','Test Road',15000,12345678,'Wellington','Computer Science');

ALTER TABLE campus ADD CONSTRAINT campus_dean_fkey
FOREIGN KEY (dean_id) REFERENCES staff(staff_id);

ALTER TABLE course ADD CONSTRAINT course_coordinator_fkey
FOREIGN KEY (coordinator_id)  REFERENCES staff(staff_id);



DROP TABLE staff_supervises_student cascade constraints;
CREATE TABLE staff_supervises_student(
	staff_id NUMBER(8,0) NOT NULL,
	student_id NUMBER(8,0) NOT NULL,
	CONSTRAINT supervises_pkey PRIMARY KEY(staff_id, student_id),
    CONSTRAINT supervises_staff_fkey FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    CONSTRAINT supervises_student_fkey FOREIGN KEY (student_id) REFERENCES student(student_id)
);

INSERT INTO staff_supervises_student VALUES(12345, 22222222);
INSERT INTO staff_supervises_student VALUES(23456, 55555555);
INSERT INTO staff_supervises_student VALUES(34567, 66666666);



DROP TABLE dept_based_in_building cascade constraints;
CREATE TABLE dept_based_in_building(
    department_name VARCHAR2(50),
    street_number NUMBER,
    street_name VARCHAR2(50),
    suburb VARCHAR2(50),
    CONSTRAINT pkey PRIMARY KEY(department_name, street_number, street_name, suburb),
    CONSTRAINT based_in_building_reference FOREIGN KEY (street_number, street_name, suburb) REFERENCES building(street_number, street_name, suburb),
    CONSTRAINT based_in_department_reference FOREIGN KEY (department_name) REFERENCES department(dname)
);

INSERT INTO dept_based_in_building VALUES ('Computer Science', 111, 'Union Street', 'Dunedin North');
INSERT INTO dept_based_in_building VALUES ('Health Science', 2, 'Riccarton Avenue', 'Christchurch Central');
INSERT INTO dept_based_in_building VALUES ('Health Science', 23, 'Mein Street', 'Wellington');



DROP TABLE department_offers_major_for_course cascade constraints;
CREATE TABLE department_offers_major_for_course(
    department_name VARCHAR(25),
    course_name VARCHAR(25),
    PRIMARY KEY(department_name, course_name),
    FOREIGN KEY(department_name) REFERENCES department(dname),
    FOREIGN KEY(course_name) REFERENCES course(course_name)
);

INSERT INTO department_offers_major_for_course VALUES('English', 'Bachelor of Arts');
INSERT INTO department_offers_major_for_course VALUES('Theology', 'Bachelor of Arts');
INSERT INTO department_offers_major_for_course VALUES('Computer Science', 'Bachelor of Science');
INSERT INTO department_offers_major_for_course VALUES('English', 'Diploma in Language');
INSERT INTO department_offers_major_for_course VALUES('Botany', 'Doctor of Philosophy');
INSERT INTO department_offers_major_for_course VALUES('Zoology', 'Doctor of Philosophy');



DROP TABLE paper cascade constraints;
CREATE TABLE paper(
    paper_code VARCHAR2(10) PRIMARY KEY,
    points INT
);

INSERT INTO paper VALUES('COSC344', 15);
INSERT INTO paper VALUES('COSC349', 15);
INSERT INTO paper VALUES('ENGL127', 15);
INSERT INTO paper VALUES('MEDC500', 60);
INSERT INTO paper VALUES('MATH304', 15);



DROP TABLE paper_semesters cascade constraints;
CREATE TABLE paper_semesters (
	paper_code	VARCHAR2(10),
	semester	CHAR(2),
    CONSTRAINT paper_sem_pkey PRIMARY KEY (paper_code, semester),
    CONSTRAINT paper_sem_paper_fkey FOREIGN KEY (paper_code) REFERENCES paper(paper_code),
	CONSTRAINT paper_sem_chk_semester CHECK (	semester='s1' OR
									semester='s2' OR
									semester='ss' OR
									semester='fy')
);

INSERT INTO paper_semesters VALUES('COSC344', 's2');
INSERT INTO paper_semesters VALUES('COSC349', 's2');
INSERT INTO paper_semesters VALUES('ENGL127', 's1');
INSERT INTO paper_semesters VALUES('ENGL127', 's2');
INSERT INTO paper_semesters VALUES('MEDC500', 'fy');
INSERT INTO paper_semesters VALUES('MATH304', 's1');



DROP TABLE paper_counts_toward_course;
CREATE TABLE paper_counts_toward_course(
    paper_code VARCHAR2(10),
    course_name VARCHAR(25),
    PRIMARY KEY(paper_code, course_name),
    FOREIGN KEY(paper_code) REFERENCES paper(paper_code),
    FOREIGN KEY(course_name) REFERENCES course(course_name)
);

INSERT INTO paper_counts_toward_course VALUES('COSC344', 'Bachelor of Arts');
INSERT INTO paper_counts_toward_course VALUES('COSC349', 'Bachelor of Science');
INSERT INTO paper_counts_toward_course VALUES('ENGL127', 'Diploma in Language');
INSERT INTO paper_counts_toward_course VALUES('MEDC500', 'Doctor of Philosophy');
INSERT INTO paper_counts_toward_course VALUES('MATH304', 'Master of Finance');



DROP TABLE offered_at cascade constraints;
CREATE TABLE offered_at (
	paper_code		VARCHAR2(10),
	campus_name		VARCHAR2(80),
	PRIMARY KEY(paper_code, campus_name),
    FOREIGN KEY(paper_code) REFERENCES paper(paper_code),
    FOREIGN KEY(campus_name) REFERENCES campus(name)
);

INSERT INTO offered_at VALUES('COSC344', 'Dunedin');
INSERT INTO offered_at VALUES('COSC349', 'Dunedin');
INSERT INTO offered_at VALUES('ENGL127', 'Christchurch');
INSERT INTO offered_at VALUES('MEDC500', 'Wellington');



DROP TABLE paper_lectured_in_room cascade constraints;
CREATE TABLE paper_lectured_in_room(
    paper_code VARCHAR2(10),
    street_number NUMBER,
    street_name VARCHAR2(50),
    suburb VARCHAR2(50),
    room_number NUMBER,
    CONSTRAINT paper_lectured_in_pkey PRIMARY KEY(paper_code, street_number, street_name, suburb, room_number),
    CONSTRAINT paper_lectured_in_room_reference FOREIGN KEY (street_number, street_name, suburb, room_number) REFERENCES room(street_number, street_name, suburb, room_number),
    CONSTRAINT paper_lectured_in_paper_reference FOREIGN KEY (paper_code) REFERENCES paper(paper_code)
);

INSERT INTO paper_lectured_in_room VALUES ('COSC344', 111, 'Union Street', 'Dunedin North', 2);
INSERT INTO paper_lectured_in_room VALUES ('COSC349', 95, 'Albany Street', 'Dunedin North', 1);
INSERT INTO paper_lectured_in_room VALUES ('ENGL127', 2, 'Riccarton Avenue', 'Christchurch Central', 1);
INSERT INTO paper_lectured_in_room VALUES ('MEDC500', 23, 'Mein Street', 'Wellington', 1);



DROP TABLE student_takes_paper cascade constraints;
CREATE TABLE student_takes_paper(
	student_id NUMBER(8,0),
    paper_code VARCHAR2(10),
	CONSTRAINT takes_pkey PRIMARY KEY(student_id, paper_code),
    CONSTRAINT takes_student_fkey FOREIGN KEY (student_id) REFERENCES student(student_id),
    CONSTRAINT takes_paper_fkey FOREIGN KEY (paper_code) REFERENCES paper(paper_code)
);

INSERT INTO student_takes_paper VALUES(11111111, 'COSC344');
INSERT INTO student_takes_paper VALUES(11111111, 'COSC349');
INSERT INTO student_takes_paper VALUES(22222222, 'COSC344');
INSERT INTO student_takes_paper VALUES(22222222, 'COSC349');
INSERT INTO student_takes_paper VALUES(33333333, 'ENGL127');
INSERT INTO student_takes_paper VALUES(44444444, 'MEDC500');



DROP TABLE teaches cascade constraints;
CREATE TABLE teaches(
	staff_id NUMBER(8,0),
    paper_code VARCHAR2(10),
	CONSTRAINT teaches_pkey PRIMARY KEY(staff_id, paper_code),
    CONSTRAINT teaches_staff_fkey FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    CONSTRAINT teaches_paper_fkey FOREIGN KEY (paper_code) REFERENCES paper(paper_code)
);

INSERT INTO teaches VALUES(12345, 'COSC344');
INSERT INTO teaches VALUES(23456, 'COSC349');
INSERT INTO teaches VALUES(45678, 'MEDC500');



DROP TABLE office_of cascade constraints;
CREATE TABLE office_of(
    staff_id NUMBER(8,0),
    street_number NUMBER,
    street_name VARCHAR2(50),
    suburb VARCHAR2(50),
    room_number NUMBER,
    CONSTRAINT office_pkey PRIMARY KEY(staff_id, street_number, street_name, suburb, room_number),
    CONSTRAINT office_staff_fkey FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    CONSTRAINT office_room_reference FOREIGN KEY (street_number, street_name, suburb, room_number) REFERENCES room(street_number, street_name, suburb, room_number)
);

INSERT INTO office_of VALUES(12345, 111, 'Union Street', 'Dunedin North', 2);
INSERT INTO office_of VALUES(23456, 95, 'Albany Street', 'Dunedin North', 1);
INSERT INTO office_of VALUES(34567, 2, 'Riccarton Avenue', 'Christchurch Central', 1);
INSERT INTO office_of VALUES(45678, 23, 'Mein Street', 'Wellington', 1);


COMMIT;
