DROP TABLE postcode;
CREATE TABLE postcode(
    street_name VARCHAR2(50);
    suburb VARCHAR2(50);
    postcode INT;

    CONSTRAINT pkey PRIMARY KEY(street_name, suburb);
);

INSERT INTO postcode VALUES ("Great King Street", "Dunedin North", 9016);
INSERT INTO postcode VALUES ("Union Street", "Dunedin North", 9016);
INSERT INTO postcode VALUES ("Albany Street", "Dunedin North", 9016);
INSERT INTO postcode VALUES ("Riccarton Avenue", "Christchurch Central", 8011);
INSERT INTO postcode VALUES ("Mein Street", "Wellington", 6242);

DROP TABLE building;
CREATE TABLE building(
    street_number INT;
    street_name VARCHAR2(50);
    suburb VARCHAR2(50);
    building_name VARCHAR2(50):
    campus_name VARCHAR2(50)
        FOREIGN KEY(campus_name) REFERENCES campus(name);

    CONSTRAINT pkey PRIMARY KEY(street_number, street_name, suburb);
    CONSTRAINT postcode_reference FOREIGN KEY(street_name, suburb) REFERENCES postcode(street_name, suburb);    
);

INSERT INTO building VALUES(111, "Union Street", "Dunedin North", "Owheo", "Dunedin");
INSERT INTO building VALUES(95, "Albany Street", "Dunedin North", "Burns", "Dunedin");
INSERT INTO building VALUES(65, "Albany Street", "Dunedin North", "Central Library", "Dunedin");
INSERT INTO building VALUES(464, "Great King Street", "Dunedin North", "Botany", "Dunedin");
INSERT INTO building VALUES(2, "Riccarton Avenue", "Christchurch Central", "Christchurch Hospital", "Christchurch");
INSERT INTO building VALUES(23, "Mein Street", "Wellington", "Wellington Hospital", "Christchurch");

DROP TABLE room;
CREATE TABLE room(
    street_number INT;
    street_name VARCHAR2(50);
    suburb VARCHAR2(50);
    room_number INT;
    seating INT NOT NULL;
    accessibility NUMBER(1) NOT NULL;
    projector NUMBER(1) NOT NULL;

    CONSTRAINT pkey PRIMARY KEY(street_number, street_name, suburb, room_number);
    CONSTRAINT building_reference FOREIGN KEY (street_number, street_name, suburb) REFERENCES building(street_number, street_name, suburb);
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

DROP TABLE dept_based_in_building;
CREATE TABLE dept_based_in_building(
    department_name VARCHAR2(50);
    street_number INT;
    street_name VARCHAR2(50);
    suburb VARCHAR2(50);

    CONSTRAINT pkey PRIMARY KEY(department_name, street_number, street_name, suburb);
    CONSTRAINT building_reference FOREIGN KEY (street_number, street_name, suburb) REFERENCES building(street_number, street_name, suburb);
    CONSTRAINT department_reference FOREIGN KEY (department_name) REFERENCES department(department_name);
);

INSERT INTO dept_based_in_building VALUES ("Computer Science", 111, "Union Street", "Dunedin North");
INSERT INTO dept_based_in_building VALUES ("Health Science", 2, "Riccarton Avenue", "Christchurch Central");
INSERT INTO dept_based_in_building VALUES ("Health Science", 23, "Mein Street", "Wellington");


DROP TABLE paper_lectured_in_room;
CREATE TABLE paper_lectured_in_room(
    paper_code VARCHAR2(7);
    street_number INT;
    street_name VARCHAR2(50);
    suburb VARCHAR2(50);
    room_number INT;

    CONSTRAINT pkey PRIMARY KEY(paper_code, street_number, street_name, suburb, room_number);
    CONSTRAINT room_reference FOREIGN KEY (street_number, street_name, suburb, room_number) REFERENCES building(street_number, street_name, suburb, room_number);
    CONSTRAINT paper_reference FOREIGN KEY (paper_code) REFERENCES paper(paper_code);
);

INSERT INTO paper_lectured_in_room VALUES ("COSC344", 111, "Union Street", "Dunedin North", 2);
INSERT INTO paper_lectured_in_room VALUES ("COSC244", 95, "Albany Street", "Dunedin North", 1);
INSERT INTO paper_lectured_in_room VALUES ("MICN 401", 2, "Riccarton Avenue", "Christchurch Central", 1);
INSERT INTO paper_lectured_in_room VALUES ("MICN 501", 23, "Mein Street", "Wellington", 1);




/* Paper and Campus */
DROP TABLE paper;
DROP TABLE paper_semesters;
DROP TABLE campus;

DROP TABLE teaches;
DROP TABLE offered_at;
DROP TABLE takes;

CREATE TABLE paper (
	paper_code	CHAR(7)		NOT NULL	PRIMARY KEY,
	credits		INT			NOT NULL);
	
CREATE TABLE paper_semesters (
	paper_code	CHAR(7)		NOT NULL	PRIMARY KEY,
	semester	CHAR(2)					PRIMARY KEY,
	CONSTRAINT chk_semester CHECK (	semester='s1' OR
									semester='s2' OR
									semester='ss' OR
									semester='fy'));

CREATE TABLE campus (
	name				VARCHAR(80)		NOT NULL	PRIMARY KEY,
	main_office_addr	VARCHAR(255)	NOT NULL,
	phone				VARCHAR(20),
	email				VARCHAR(40),
	dean_id				CHAR(8)			REFERENCES staff(staff_ID)
	/*Replace with actual format*/);
	
CREATE TABLE teaches (
	teaching_id		CHAR(8)		NOT NULL	REFERENCES staff(staff_ID),		
	paper_code		CHAR(7)		NOT NULL	REFERENCES paper(paper_code),
	semester		CHAR(2)		NOT NULL	REFERENCES paper_semesters(semester),
	CONSTRAINT chk_semester CHECK (	semester='s1' OR
									semester='s2' OR
									semester='ss' OR
									semester='fy'),
	PRIMARY KEY(teaching_id, paper_code, semester));

CREATE TABLE offered_at (
	paper_code		CHAR(8)			NOT NULL	REFERENCES paper(paper_code),
	campus_name		VARCHAR(80)		NOT NULL	REFERENCES campus(name),
	PRIMARY KEY(paper_code, campus_name));
	
CREATE TABLE takes (
	student_id		CHAR(8)			NOT NULL	REFERENCES student(student_id),
	/* replace with proper format later */
	paper_code 		CHAR(7)			NOT NULL	REFERENCES paper(paper_code),
	year_taken			DATE			NOT NULL,	/* Is this a waste of space? Date is huge but only year is used*/
	semester		CHAR(2)			NOT NULL	REFERENCES paper_semesters(semester),
	marks			INT,
	CONSTRAINT chk_semester CHECK (	semester='s1' OR
									semester='s2' OR
									semester='ss' OR
									semester='fy'),
	PRIMARY KEY(student_id, paper_code, year_taken, semester));
	
/* Also, please add campus name to the student table. */
