DROP TABLE postcode cascade constraints;
CREATE TABLE postcode(
    street_name VARCHAR2(50),
    suburb VARCHAR2(50),
    postcode NUMBER,

    CONSTRAINT pkey PRIMARY KEY(street_name, suburb)
);

INSERT INTO postcode VALUES ("Great King Street", "Dunedin North", 9016);
INSERT INTO postcode VALUES ("Union Street", "Dunedin North", 9016);
INSERT INTO postcode VALUES ("Albany Street", "Dunedin North", 9016);
INSERT INTO postcode VALUES ("Riccarton Avenue", "Christchurch Central", 8011);
INSERT INTO postcode VALUES ("Mein Street", "Wellington", 6242);

DROP TABLE building cascade constraints;
CREATE TABLE building(
    street_number NUMBER,
    street_name VARCHAR2(50),
    suburb VARCHAR2(50),
    building_name VARCHAR2(50):
    campus_name VARCHAR2(50)
        FOREIGN KEY(campus_name) REFERENCES campus(name),

    CONSTRAINT pkey PRIMARY KEY(street_number, street_name, suburb),
    CONSTRAINT postcode_reference FOREIGN KEY(street_name, suburb) REFERENCES postcode(street_name, suburb) 
);

INSERT INTO building VALUES(111, "Union Street", "Dunedin North", "Owheo", "Dunedin");
INSERT INTO building VALUES(95, "Albany Street", "Dunedin North", "Burns", "Dunedin");
INSERT INTO building VALUES(65, "Albany Street", "Dunedin North", "Central Library", "Dunedin");
INSERT INTO building VALUES(464, "Great King Street", "Dunedin North", "Botany", "Dunedin");
INSERT INTO building VALUES(2, "Riccarton Avenue", "Christchurch Central", "Christchurch Hospital", "Christchurch");
INSERT INTO building VALUES(23, "Mein Street", "Wellington", "Wellington Hospital", "Christchurch");

DROP TABLE room cascade constraints;
CREATE TABLE room(
    street_number NUMBER,
    street_name VARCHAR2(50),
    suburb VARCHAR2(50),
    room_number NUMBER,
    seating NUMBER NOT NULL,
    accessibility NUMBER(1) NOT NULL,
    projector NUMBER(1) NOT NULL,

    CONSTRAINT pkey PRIMARY KEY(street_number, street_name, suburb, room_number),
    CONSTRAINT building_reference FOREIGN KEY (street_number, street_name, suburb) REFERENCES building(street_number, street_name, suburb)
);

INSERT INTO room VALUES(111, "Union Street", "Dunedin North", 1, 24, 1, 0);
INSERT INTO room VALUES(111, "Union Street", "Dunedin North", 2, 30, 1, 1);
INSERT INTO room VALUES(111, "Union Street", "Dunedin North", 3, 14, 0, 1);
INSERT INTO room VALUES(111, "Union Street", "Dunedin North", 4, 2, 0, 0);
INSERT INTO room VALUES(111, "Union Street", "Dunedin North", 5, 3, 0, 0);
INSERT INTO room VALUES(95, "Albany Street", "Dunedin North", 1, 65, 1, 1);
INSERT INTO room VALUES(95, "Albany Street", "Dunedin North", 2, 80, 1, 1);
INSERT INTO room VALUES(464, "Great King Street", "Dunedin North", 1, 40, 0, 0);
INSERT INTO room VALUES(2, "Riccarton Avenue", "Christchurch Central", 1, 20, 1, 1);
INSERT INTO room VALUES(23, "Mein Street", "Wellington", 1, 25, 1, 1);

DROP TABLE dept_based_in_building cascade constraints;
CREATE TABLE dept_based_in_building(
    department_name VARCHAR2(50),
    street_number NUMBER,
    street_name VARCHAR2(50),
    suburb VARCHAR2(50),

    CONSTRAINT pkey PRIMARY KEY(department_name, street_number, street_name, suburb),
    CONSTRAINT building_reference FOREIGN KEY (street_number, street_name, suburb) REFERENCES building(street_number, street_name, suburb),
    CONSTRAINT department_reference FOREIGN KEY (department_name) REFERENCES department(department_name)
);

INSERT INTO dept_based_in_building VALUES ("Computer Science", 111, "Union Street", "Dunedin North");
INSERT INTO dept_based_in_building VALUES ("Health Science", 2, "Riccarton Avenue", "Christchurch Central");
INSERT INTO dept_based_in_building VALUES ("Health Science", 23, "Mein Street", "Wellington");


DROP TABLE paper_lectured_in_room cascade constraints;
CREATE TABLE paper_lectured_in_room(
    paper_code VARCHAR2(7),
    street_number NUMBER,
    street_name VARCHAR2(50),
    suburb VARCHAR2(50),
    room_number NUMBER,

    CONSTRAINT pkey PRIMARY KEY(paper_code, street_number, street_name, suburb, room_number),
    CONSTRAINT room_reference FOREIGN KEY (street_number, street_name, suburb, room_number) REFERENCES building(street_number, street_name, suburb, room_number),
    CONSTRAINT paper_reference FOREIGN KEY (paper_code) REFERENCES paper(paper_code)
);

INSERT INTO paper_lectured_in_room VALUES ("COSC344", 111, "Union Street", "Dunedin North", 2);
INSERT INTO paper_lectured_in_room VALUES ("COSC244", 95, "Albany Street", "Dunedin North", 1);
INSERT INTO paper_lectured_in_room VALUES ("MICN 401", 2, "Riccarton Avenue", "Christchurch Central", 1);
INSERT INTO paper_lectured_in_room VALUES ("MICN 501", 23, "Mein Street", "Wellington", 1);


DROP TABLE department cascade constraints;
CREATE TABLE department(
    dname VARCHAR2(25) PRIMARY KEY,
    number_of_academic_staff INT NOT NULL,
    number_of_nonacademic_staff INT
);

INSERT INTO department VALUES ('Computer Science', 20, 1);
INSERT INTO department VALUES ('English', 11, 1);
INSERT INTO department VALUES ('Zoology', 31, 4);
INSERT INTO department VALUES ('Botany', 12, 5);
INSERT INTO department VALUES ('Theology', 11, 1);

DROP TABLE course cascade constraints;
CREATE TABLE course(
    cname VARCHAR2(25) PRIMARY KEY,
    years_required INT NOT NULL,
    clevel VARCHAR2(25) NOT NULL
 );

INSERT INTO course VALUES('Bachelor of Arts', 3, 'Undergraduate');
INSERT INTO course VALUES('Bachelor of Science', 3, 'Undergraduate');
INSERT INTO course VALUES('Diploma in Language', 3, 'Undergraduate');
INSERT INTO course VALUES('Doctor of Philosophy', 3, 'Postgraduate');
INSERT INTO course VALUES('Master of Finance', 1, 'Postgraduate');

DROP TABLE staff cascade constraints;
CREATE TABLE staff(
    staff_id INT PRIMARY KEY
);

INSERT INTO staff VALUES(12345);
INSERT INTO staff VALUES(23456);
INSERT INTO staff VALUES(34567);
INSERT INTO staff VALUES(45678);
INSERT INTO staff VALUES(56789);


DROP TABLE staff_member_works_for_department cascade constraints;
CREATE TABLE staff_member_works_for_department(
    staff_member_id INT,
    department_name VARCHAR(25),
    PRIMARY KEY(staff_member_id, department_name),
    FOREIGN KEY(staff_member_id) REFERENCES staff(staff_id),
    FOREIGN KEY(department_name) REFERENCES department(dname)
);

INSERT INTO staff_member_works_for_department VALUES(12345, 'Computer Science');
INSERT INTO staff_member_works_for_department VALUES(23456, 'English');
INSERT INTO staff_member_works_for_department VALUES(34567, 'Theology');
INSERT INTO staff_member_works_for_department VALUES(45678, 'Zoology');
INSERT INTO staff_member_works_for_department VALUES(56789, 'Botany');

DROP TABLE paper cascade constraints;
CREATE TABLE paper(
    paper_code INT PRIMARY KEY
);

INSERT INTO paper VALUES(1);
INSERT INTO paper VALUES(2);
INSERT INTO paper VALUES(3);
INSERT INTO paper VALUES(4);
INSERT INTO paper VALUES(5);

DROP TABLE paper_counts_toward_course;

CREATE TABLE paper_counts_toward_course(
    p_code INT,
    c_name VARCHAR(25),
    PRIMARY KEY(p_code, c_name),
    FOREIGN KEY(p_code) REFERENCES paper(paper_code),
    FOREIGN KEY(c_name) REFERENCES course(cname)
);

INSERT INTO paper_counts_toward_course VALUES(1, 'Bachelor of Arts');
INSERT INTO paper_counts_toward_course VALUES(2, 'Bachelor of Science');
INSERT INTO paper_counts_toward_course VALUES(3, 'Diploma in Language');
INSERT INTO paper_counts_toward_course VALUES(4, 'Doctor of Philosophy');
INSERT INTO paper_counts_toward_course VALUES(5, 'Master of Finance');

/* Paper and Campus */
DROP TABLE paper;
DROP TABLE paper_semesters;
DROP TABLE campus;

DROP TABLE teaches;
DROP TABLE offered_at;
DROP TABLE takes;

CREATE TABLE paper (
	paper_code	CHAR(7)		NOT NULL	PRIMARY KEY,
	credits		INT			NOT NULL
);

INSERT INTO paper VALUES ('COSC344', 18);
INSERT INTO paper VALUES ('COSC244', 18);
INSERT INTO paper VALUES ('MICN401', 120);
INSERT INTO paper VALUES ('MICN501', 120);
	
CREATE TABLE paper_semesters (
	paper_code	CHAR(7)		NOT NULL	PRIMARY KEY,
	semester	CHAR(2)					PRIMARY KEY,
	CONSTRAINT chk_semester CHECK (	semester='s1' OR
									semester='s2' OR
									semester='ss' OR
									semester='fy')
);

INSERT INTO paper_semesters VALUES ('COSC344', 's2');
INSERT INTO paper_semesters VALUES ('COSC244', 's2');
INSERT INTO paper_semesters VALUES ('MICN401', 'fy');
INSERT INTO paper_semesters VALUES ('MICN501', 'fy');

CREATE TABLE campus (
	name				VARCHAR2(80)		NOT NULL	PRIMARY KEY,
	street_number       NUMBER,      
    street_name         VARCHAR2(50),  
    suburb              VARCHAR2(50),
	phone				VARCHAR2(20),
	email				VARCHAR2(40),
	dean_id				CHAR(8)			REFERENCES staff(staff_ID)
	/*Replace with actual format*/
);

INSERT INTO campus VALUES ('Dunedin', 362, 'Leith Street', 'Dunedin Central', '0800 80 80 98', 'university@otago.ac.nz', 'ABCDEFGH');

CREATE TABLE teaches (
	teaching_id		CHAR(8)		NOT NULL	REFERENCES staff(staff_ID),		
	paper_code		CHAR(7)		NOT NULL	REFERENCES paper(paper_code),
	PRIMARY KEY(teaching_id, paper_code));

CREATE TABLE offered_at (
	paper_code		CHAR(8)			NOT NULL	REFERENCES paper(paper_code),
	campus_name		VARCHAR(80)		NOT NULL	REFERENCES campus(name),
	PRIMARY KEY(paper_code, campus_name)
);
	
CREATE TABLE takes (
	student_id		CHAR(8)			NOT NULL	REFERENCES student(student_id),
	/* replace with proper format later */
	paper_code 		CHAR(7)			NOT NULL	REFERENCES paper(paper_code),
	PRIMARY KEY(student_id, paper_code)
);
	
/* Also, please add campus name to the student table. */
DROP TABLE department_offers_major_for_course;

CREATE TABLE department_offers_major_for_course(
    d_name VARCHAR(25),
    c_name VARCHAR(25),
    PRIMARY KEY(d_name, c_name),
    FOREIGN KEY(d_name) REFERENCES department(dname),
    FOREIGN KEY(c_name) REFERENCES course(cname)
);

INSERT INTO department_offers_major_for_course VALUES('English', 'Bachelor of Arts');
INSERT INTO department_offers_major_for_course VALUES('Theology', 'Bachelor of Arts');
INSERT INTO department_offers_major_for_course VALUES('Computer Science', 'Bachelor of Science');
INSERT INTO department_offers_major_for_course VALUES('English', 'Diploma in Language');
INSERT INTO department_offers_major_for_course VALUES('Botany', 'Doctor of Philosophy');
INSERT INTO department_offers_major_for_course VALUES('Zoology', 'Doctor of Philosophy');
