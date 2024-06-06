CREATE DATABASE FinalProject;

USE FinalProject
CREATE TABLE tbl_regions (id INT, name VARCHAR(25));
CREATE TABLE tbl_job_histories (
	employee INT,
	start_date DATE, 
	end_date DATE, 
	status VARCHAR(10) NOT NULL, 
	job VARCHAR (10) NOT NULL,
	department INT NOT NULL
);
CREATE TABLE tbl_departments (
	id INT,
	name VARCHAR(30) NOT NULL,
	location INT NOT NULL
);
CREATE TABLE tbl_employees (
	id INT,
	first_name VARCHAR(25) NOT NULL,
	last_name VARCHAR(25),
	gender VARCHAR (10) NOT NULL,
	email VARCHAR (25) NOT NULL,
	phone VARCHAR(20),
	hire_date DATE NOT NULL,
	salary INT,
	manager INT,
	job VARCHAR (10)NOT NULL,
	department INT NOT NULL
);
CREATE TABLE tbl_jobs (
	id VARCHAR (10),
	title VARCHAR (35) NOT NULL,
	min_salary INT,
	max_salary INT
);
CREATE TABLE tbl_permissions (
	id INT,
	name VARCHAR(100) NOT NULL
);
CREATE TABLE tbl_accounts (
	id INT,
	username VARCHAR(25),
	password VARCHAR (255) NOT NULL,
	otp INT NOT NULL,
	is_expired BIT NOT NULL,
	is_used DATETIME NOT NULL
);
CREATE TABLE tbl_locations (
	id INT,
	street_address VARCHAR(40),
	postal_code VARCHAR(12),
	city VARCHAR (30)NOT NULL,
	state_province VARCHAR(25),
	country CHAR (3)
);
CREATE TABLE tbl_countries (
	id CHAR (3),
	name VARCHAR(40) NOT NULL,
	region INT NOT NULL
);
CREATE TABLE tbl_account_roles (
	id INT,
	account INT NOT NULL,
	role INT NOT NULL
);
CREATE TABLE tbl_roles (
	id INT,
	name VARCHAR(500) NOT NULL
);
CREATE TABLE tbl_role_permissions (
	id INT,
	role INT NOT NULL,
	permission INT NOT NULL
);

ALTER TABLE tbl_regions ALTER COLUMN id INT NOT NULL;
ALTER TABLE tbl_regions ADD CONSTRAINT PK_tbl_regions PRIMARY KEY (id);
ALTER TABLE tbl_countries ADD CONSTRAINT FK_tbl_regions FOREIGN KEY (region) REFERENCES tbl_regions (id);

ALTER TABLE tbl_countries ALTER COLUMN id CHAR (3) NOT NULL;
ALTER TABLE tbl_countries ADD CONSTRAINT PK_tbl_countries PRIMARY KEY (id);
ALTER TABLE tbl_locations ALTER COLUMN country CHAR (3) NOT NULL;
ALTER TABLE tbl_locations ADD CONSTRAINT FK_tbl_countries FOREIGN KEY (country) REFERENCES tbl_countries (id);

ALTER TABLE tbl_countries DROP PK_tbl_countries;

ALTER TABLE tbl_locations ALTER COLUMN id INT NOT NULL;
ALTER TABLE tbl_locations ADD CONSTRAINT PK_tbl_locations PRIMARY KEY (id);
ALTER TABLE tbl_departments ADD CONSTRAINT FK_tbl_locations FOREIGN KEY (location) REFERENCES tbl_locations (id);

ALTER TABLE tbl_departments ALTER COLUMN id INT NOT NULL;
ALTER TABLE tbl_departments ADD CONSTRAINT PK_tbl_departments PRIMARY KEY (id);
ALTER TABLE tbl_job_histories ADD CONSTRAINT FK_tbl_departments FOREIGN KEY (department) REFERENCES tbl_departments (id);
ALTER TABLE tbl_employees ADD CONSTRAINT FK_tbl_departments_employees FOREIGN KEY (department) REFERENCES tbl_departments (id);

ALTER TABLE tbl_roles ALTER COLUMN id INT NOT NULL;
ALTER TABLE tbl_roles ADD CONSTRAINT PK_tbl_roles PRIMARY KEY (id);
ALTER TABLE tbl_account_roles ADD CONSTRAINT FK_tbl_roles FOREIGN KEY (role) REFERENCES tbl_roles (id);
ALTER TABLE tbl_role_permissions ADD CONSTRAINT FK_tbl_roles_role_permissons FOREIGN KEY (role) REFERENCES tbl_roles (id);

ALTER TABLE tbl_employees ALTER COLUMN id INT NOT NULL;
ALTER TABLE tbl_employees ADD CONSTRAINT PK_tbl_employees PRIMARY KEY (id);
ALTER TABLE tbl_job_histories ADD CONSTRAINT FK_tbl_employees FOREIGN KEY (employee) REFERENCES tbl_employees (id);
ALTER TABLE tbl_accounts ADD CONSTRAINT FK_tbl_employees_accounts FOREIGN KEY (id) REFERENCES tbl_employees (id);
ALTER TABLE tbl_employees ADD CONSTRAINT FK_tbl_employees_manager FOREIGN KEY (manager) REFERENCES tbl_employees(id);

ALTER TABLE tbl_account_roles ALTER COLUMN id INT NOT NULL;
ALTER TABLE tbl_account_roles ADD CONSTRAINT PK_tbl_account_roles PRIMARY KEY (id);

ALTER TABLE tbl_job_histories ALTER COLUMN start_date DATE NOT NULL;
ALTER TABLE tbl_job_histories ADD CONSTRAINT PK_tbl_job_histories PRIMARY KEY (start_date);


ALTER TABLE tbl_jobs ALTER COLUMN id VARCHAR(10) NOT NULL;
ALTER TABLE tbl_jobs ADD CONSTRAINT PK_tbl_jobs PRIMARY KEY (id);
ALTER TABLE tbl_employees ADD CONSTRAINT FK_tbl_jobs FOREIGN KEY (job) REFERENCES tbl_jobs (id);
ALTER TABLE tbl_job_histories ADD CONSTRAINT FK_tbl_jobs_job_histories FOREIGN KEY (job) REFERENCES tbl_jobs (id);


ALTER TABLE tbl_permissions ALTER COLUMN id INT NOT NULL;
ALTER TABLE tbl_permissions ADD CONSTRAINT PK_tbl_permissions PRIMARY KEY (id);
ALTER TABLE tbl_role_permissions ADD CONSTRAINT FK_tbl_permissions FOREIGN KEY (permission) REFERENCES tbl_permissions (id);

ALTER TABLE tbl_role_permissions ALTER COLUMN id INT NOT NULL;
ALTER TABLE tbl_role_permissions ADD CONSTRAINT PK_tbl_role_permissions PRIMARY KEY (id);

ALTER TABLE tbl_accounts ALTER COLUMN id INT NOT NULL;
ALTER TABLE tbl_accounts ADD CONSTRAINT PK_tbl_accounts PRIMARY KEY (id);
ALTER TABLE tbl_account_roles ADD CONSTRAINT FK_tbl_accounts FOREIGN KEY (account) REFERENCES tbl_accounts (id);

ALTER TABLE tbl_employees ADD CONSTRAINT UQ_tbl_Employees_email UNIQUE (email);




