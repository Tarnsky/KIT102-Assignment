use tkrimmer;

drop table if exists CLIENT;
drop table if exists STAFF;
drop table if exists QUALIFICATION;
drop table if exists MANAGER;
drop table if exists DIAGNOSIS;
drop table if exists SERVICES;
drop table if exists FUNDINGBODY;
drop table if exists MOBILITYTEST;
drop table if exists MOBILITYTESTFACILITY;
drop table if exists MEDICALPRACTITONER;
drop table if exists TESTRESULT;

create table CLIENT ( 				-- Client information Table
	ClientID smallint(6) NOT NULL AUTO_INCREMENT,
	Name varchar(40) NOT NULL,
	Address varchar(255) NOT NULL,
	TestID smallint(6),	
	StaffID smallint(6) NOT NULL,	
	primary key (ClientID)
	)
	ENGINE=InnoDB; 

create table STAFF ( 				-- Staff information Table
	StaffID smallint(6) NOT NULL AUTO_INCREMENT,
	Name varchar(40) NOT NULL,
	Age smallint(3) NOT NULL,
	SexualOrientation varchar(10) NOT NULL,
	QualificationName varchar(60) NOT NULL,
	ServiceCode smallint(6),
	primary key (StaffID)
	)
	ENGINE=InnoDB; 

create table QUALIFICATION ( 			-- Qualification information Table
	QualificationName varchar(60) NOT NULL UNIQUE,
	Details varchar(255) NOT NULL,
	StaffID smallint(6),
	primary key (QualificationName),
	foreign key (StaffID) references STAFF (StaffID)
	)
	ENGINE=InnoDB; 

create table MANAGER ( 				-- Staff Manager information Table
	ManagerID smallint(6) NOT NULL AUTO_INCREMENT,
	Name varchar(20) NOT NULL,
	Details varchar(255) NOT NULL,
	StaffID smallint(6),
	primary key (ManagerID),
	foreign key (StaffID) references STAFF (StaffID)
	)
	ENGINE=InnoDB; 

create table DIAGNOSIS ( 			-- Diagnosis information Table
	DiagnosisCode smallint(6) NOT NULL AUTO_INCREMENT,
	Details varchar(255) NOT NULL,
	MedicalPractitionerID smallint(6) NOT NULL,
	primary key (DiagnosisCode)
	)
	ENGINE=InnoDB; 

create table SERVICES ( 			-- Services information Table
	ServiceCode smallint(6) NOT NULL AUTO_INCREMENT,
	Description varchar(255) NOT NULL,
	DiagnosisCode smallint(6),
	StaffID smallint(6) NOT NULL,
	FunderID smallint(6) NOT NULL,
	primary key (ServiceCode),
	foreign key (DiagnosisCode) references DIAGNOSIS (DiagnosisCode),
	foreign key (StaffID) references STAFF (StaffID)
	)
	ENGINE=InnoDB;
 

create table FUNDINGBODY ( 			-- Funding body information Table
	FunderID smallint(6) NOT NULL AUTO_INCREMENT,
	Details varchar(255) NOT NULL,
	ServiceCode smallint(6),
	primary key (FunderID),
	foreign key (ServiceCode) references SERVICES (ServiceCode)
	)
	ENGINE=InnoDB; 

create table MOBILITYTEST ( 			-- Mobility Test information Table
	TestID smallint(6) NOT NULL AUTO_INCREMENT,
	Details varchar(255) NOT NULL,
	FacilityCode smallint(6) NOT NULL,
	primary key (TestID)
	)
	ENGINE=InnoDB;

 create table MOBILITYTESTFACILITY ( 		-- Test Facility information Table
	FacilityCode smallint(6) NOT NULL AUTO_INCREMENT,
	Details varchar(255) NOT NULL,
	primary key (FacilityCode)
	)
	ENGINE=InnoDB; 

 create table MEDICALPRACTITONER (		-- Medical practitioner information Table
	MedicalPractitionerID smallint(6) NOT NULL UNIQUE,
	Name varchar(20) NOT NULL,
	primary key (MedicalPractitionerID)
	)
	ENGINE=InnoDB; 

 create table TESTRESULTS (			-- Client Test result information Table
	ResultID smallint(6) NOT NULL AUTO_INCREMENT,
	Details varchar(255) NOT NULL,
	FacilityCode smallint(6) NOT NULL,
	primary key (ResultID),
	foreign key (FacilityCode) references MOBILITYTESTFACILITY (FacilityCode)
	)
	ENGINE=InnoDB; 

ALTER TABLE CLIENT
ADD FOREIGN KEY (TestID) REFERENCES MOBILITYTEST (TestID);

ALTER TABLE CLIENT
ADD FOREIGN KEY (TestID) REFERENCES MOBILITYTEST (TestID);

ALTER TABLE STAFF
ADD FOREIGN KEY (QualificationName) REFERENCES QUALIFICATION (QualificationName);

ALTER TABLE STAFF
ADD FOREIGN KEY (ServiceCode) REFERENCES SERVICES (ServiceCode);

ALTER TABLE DIAGNOSIS
ADD FOREIGN KEY (MedicalPractitionerID) REFERENCES MEDICALPRACTITONER (MedicalPractitionerID);

ALTER TABLE SERVICES
ADD FOREIGN KEY (FunderID) REFERENCES FUNDINGBODY (FunderID);

ALTER TABLE MOBILITYTEST
ADD FOREIGN KEY (FacilityCode) REFERENCES MOBILITYTESTFACILITY (FacilityCode);

INSERT INTO CLIENT (Name,Address,TestID)
VALUES ('John','1 Bosful Street, Bashow, 5687', NULL);
INSERT INTO CLIENT (Name,Address,TestID)
VALUES ('Jess', '2 Bosful Street, Bashow, 5687', NULL);

INSERT INTO QUALIFICATION VALUES ('Gardener', 'Provides landscaping', NULL);
INSERT INTO QUALIFICATION VALUES ('Cleaner', 'Cleans house', NULL);

insert into FUNDINGBODY (Details,ServiceCode)
values ('Big money co', NULL);
insert into FUNDINGBODY (Details,ServiceCode)
values ('Approve tick co', NULL);

insert into MOBILITYTESTFACILITY (Details)
values ('Test Details');
insert into MOBILITYTESTFACILITY (Details)
values ('Test Details');

insert into MOBILITYTEST (Details,FacilityCode)
values ('test knee mobility',1);
insert into MOBILITYTEST (Details,FacilityCode)
values ('test arm mobility',2);

insert into TESTRESULTS (Details,FacilityCode)
values ('high knee mobility', 1);
insert into TESTRESULTS (Details,FacilityCode)
values ('low arm mobility', 2);

insert into MEDICALPRACTITONER values (675, 'Dr.Ross');
insert into MEDICALPRACTITONER values (345, 'Dr.Steph');

insert into DIAGNOSIS (Details,MedicalPractitionerID)
values ('sick',675);
insert into DIAGNOSIS (Details,MedicalPractitionerID)
values ('Needs tests', 345);

insert into MANAGER (Name,Details)
values ('Bob', 'Billys Manager');
insert into MANAGER (Name,Details)
values ('Billy', 'Bobs Manager');

insert into STAFF (Name,Age,SexualOrientation,QualificationName,ServiceCode)
values ('Bob', 26, 'Male', 'Cleaner', NULL);
insert into STAFF (Name,Age,SexualOrientation,QualificationName,ServiceCode)
values ('Billy', 32, 'Female', 'Gardener', NULL);

insert into SERVICES (Description,DiagnosisCode,StaffID,FunderID)
values ('Cleaner',NULL,1,1);
insert into SERVICES (Description,DiagnosisCode,StaffID,FunderID)
values ('Diagnosis',1,2,2);


