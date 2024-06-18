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


--------- QUERY STORE PROCEDURE ---------

-- clarissa
-- SP EDIT LOCATION
CREATE PROCEDURE edit_location
    @id INT,
    @street_address VARCHAR(40),
    @postal_code VARCHAR(12),
    @city VARCHAR (30),
    @state_province VARCHAR(25),
    @country CHAR (3)
AS
BEGIN
    UPDATE tbl_location
    SET street_address = @street_address,
            postal_code = @postal_code,
            city = @city,
            state_province = @state_province,
            country = @country
    WHERE id = @id;
END;
EXEC sp_helptext edit_location;

-- SP EDIT REGION
CREATE PROCEDURE edit_region
    @id INT,
    @name VARCHAR (25)
AS
BEGIN
    UPDATE tbl_regions
    SET name = @name
    WHERE id = @id;
END;
EXEC sp_helptext edit_region;

-- SP EDIT COUNTRY
CREATE PROCEDURE edit_country
    @id CHAR (3),
    @name VARCHAR (40),
    @region INT
AS
BEGIN
    UPDATE tbl_region
    SET name = @name,
         region = @region
    WHERE id = @id;
END;
EXEC sp_helptext edit_country;

-- SP ADD ROLE
CREATE PROCEDURE add_role
    @id INT,
    @name VARCHAR(50)
AS
BEGIN
    INSERT INTO tbl_roles (id, name)
    VALUES (@id, @name);
END;
EXEC sp_helptext add_role;

-- SP ADD COUNTRY
CREATE PROCEDURE add_country
    @id CHAR (3),
    @name VARCHAR (40),
    @region INT
AS
BEGIN
    INSERT INTO tbl_countries (id, name, region)
    VALUES (@id, @name, @region);
END;
EXEC sp_helptext add_country;

-- SP ADD LOCATION
CREATE PROCEDURE add_location
    @id INT,
    @street_address VARCHAR(40),
    @postal_code VARCHAR (12),
    @city VARCHAR (30),
    @state_province VARCHAR (25),
    @country CHAR (3)
AS
BEGIN
    INSERT INTO tbl_locations (id, street_address, postal_code, city, state_province, country)
    VALUES (@id, @street_address, @postal_code, @city, @state_province, @country);
END;
EXEC sp_helptext add_location;

-- SP DELETE ROLE
CREATE PROCEDURE delete_role
    @id INT
AS
BEGIN
    DELETE FROM tbl_roles
    WHERE id = @id;
END;
EXEC sp_helptext delete_role;

-- SP DELETE EMPLOYEE
CREATE PROCEDURE delete_employee
    @id INT
AS
BEGIN
    DELETE FROM tbl_employees
    WHERE id = @id;
END;
EXEC sp_helptext delete_employee;






-- punya shinta
-- SD 001
-- user login
CREATE PROCEDURE dbo.user_login
    @username VARCHAR(25),
    @password VARCHAR(255)
AS
BEGIN
    DECLARE @password_hash_terdaftar VARCHAR(255);
    DECLARE @is_expired BIT;
    DECLARE @is_used DATETIME;

    -- Mengambil hash password yang terdaftar, status is_expired, dan status is_used untuk username yang diberikan
    SELECT @password_hash_terdaftar = password, 
           @is_expired = is_expired,
           @is_used = is_used
    FROM tbl_accounts
    WHERE username = @username;

    -- Memeriksa apakah akun sudah kadaluarsa
    IF @is_expired = 1
    BEGIN
        RAISERROR('Akun sudah kadaluarsa.', 16, 1);
        RETURN;
    END

    -- Memeriksa apakah akun sudah digunakan (sesuaikan logika ini sesuai kebutuhan Anda)
    IF @is_used IS NOT NULL
    BEGIN
        RAISERROR('Akun sudah digunakan.', 16, 1);
        RETURN;
    END

    -- Validasi password yang diberikan
    IF @password_hash_terdaftar IS NULL OR @password_hash_terdaftar != HASHBYTES('SHA2_256', @password)
    BEGIN
        RAISERROR('Username atau password salah.', 16, 1);
        RETURN;
    END

    -- Jika password cocok dan akun valid, lanjutkan dengan proses login
    -- Perbarui kolom is_used dengan tanggal dan waktu saat ini
    UPDATE tbl_accounts
    SET is_used = GETDATE()
    WHERE username = @username;

    -- Mengembalikan pesan sukses atau lakukan tindakan lain yang diperlukan
    SELECT 'Login berhasil' AS pesan;
END;


-- SD 002
-- SP forgot password
CREATE PROCEDURE dbo.forgot_password
    @username VARCHAR(50),
    @new_password VARCHAR(255)
AS
BEGIN
    DECLARE @hashed_password VARBINARY(256);

    -- Memeriksa apakah username ada
    IF NOT EXISTS (SELECT 1 FROM tbl_accounts WHERE username = @username)
    BEGIN
        RAISERROR('Username tidak ditemukan.', 16, 1);
        RETURN;
    END

    -- Meng-hash password baru
    SET @hashed_password = HASHBYTES('SHA2_256', @new_password);

    -- Memperbarui password pengguna di tabel akun
    UPDATE tbl_accounts
    SET password = @hashed_password
    WHERE username = @username;

    -- Kembalikan pesan sukses
    SELECT 'Password berhasil direset.' AS message;
END;
GO



-- SD 003
-- SP generate otp
CREATE PROCEDURE dbo.generate_otp
    @length INT = 6  -- Panjang default OTP adalah 6 digit
AS
BEGIN
    DECLARE @otp VARCHAR(10);
    
    -- Menghasilkan angka acak dengan panjang yang ditentukan
    SET @otp = (
        SELECT CAST(CAST(NEWID() AS VARBINARY) AS INT) % POWER(10, @length)
    );

    -- Mengembalikan OTP
    SELECT @otp AS otp;
END;
GO



-- SD 007
-- SP add job
CREATE PROCEDURE dbo.add_job
    @id VARCHAR(10),
    @title VARCHAR(35),
    @min_salary INT = NULL,
    @max_salary INT = NULL
AS
BEGIN
    -- Memastikan tidak ada job dengan ID yang sama
    IF EXISTS (SELECT 1 FROM tbl_jobs WHERE id = @id)
    BEGIN
        RAISERROR('Job dengan ID tersebut sudah ada.', 16, 1);
        RETURN;
    END

    -- Menambahkan data job ke dalam tabel tbl_jobs
    INSERT INTO tbl_jobs (id, title, min_salary, max_salary)
    VALUES (@id, @title, @min_salary, @max_salary);

    -- Mengembalikan pesan sukses
    SELECT 'Data job berhasil ditambahkan.' AS message;
END;
GO



-- SD 008
-- SP edit data job
CREATE PROCEDURE dbo.edit_job
    @id VARCHAR(10),
    @new_title VARCHAR(35),
    @new_min_salary INT = NULL,
    @new_max_salary INT = NULL
AS
BEGIN
    -- Memperbarui data job di dalam tabel tbl_jobs
    UPDATE tbl_jobs
    SET 
        title = @new_title, 
        min_salary = @new_min_salary,
        max_salary = @new_max_salary
    WHERE id = @id;

    -- Mengembalikan pesan sukses
    SELECT 'Data job berhasil diperbarui.' AS message;
END;


-- SD 009
-- SP delete job
CREATE PROCEDURE delete_job
    @id INT
AS
BEGIN
    DELETE FROM tbl_jobs
    WHERE id = @id;
END;


-- SD 011
-- SP edit data departemen
CREATE PROCEDURE dbo.edit_department
    @id INT,
    @new_name VARCHAR(30),
    @new_location INT
AS
BEGIN
    -- Memperbarui data departemen di dalam tabel tbl_departments
    UPDATE tbl_departments
    SET 
        name = @new_name,
        location = @new_location
    WHERE id = @id;

    -- Mengembalikan pesan sukses
    SELECT 'Data departemen berhasil diperbarui.' AS message;
END;
GO



-- SD 012
-- SP delete data department
CREATE PROCEDURE delete_department
    @id INT
AS
BEGIN
    DELETE FROM tbl_departments
    WHERE id = @id;
END;


-- SD 019
-- SP add region
CREATE PROCEDURE dbo.add_region
    @id INT,
    @name VARCHAR(25)
AS
BEGIN
    -- Menambahkan data region ke dalam tabel tbl_regions
    INSERT INTO tbl_regions (id, name)
    VALUES (@id, @name);

    -- Mengembalikan pesan sukses
    SELECT 'Data region berhasil ditambahkan.' AS message;
END;




-- SD 021
-- SP delete region
CREATE PROCEDURE delete_region
    @id INT
AS
BEGIN
    DELETE FROM tbl_regions
    WHERE id = @id;
END;



-- SD 023
-- SP edit role
CREATE PROCEDURE edit_role
    @id INT,
    @new_name VARCHAR(50)
AS
BEGIN
    UPDATE tbl_roles
    SET
		name = @new_name
    WHERE id = @id
END;
GO

-- SD 028
-- SP edit profil
CREATE PROCEDURE dbo.edit_ptofile
    @id INT,
    @new_name VARCHAR(500),
    @new_email VARCHAR(100)
AS
BEGIN
    -- Memperbarui data role di dalam tabel tbl_roles
    UPDATE tbl_users
    SET 
        name = @new_name,
        email = @new_email
    WHERE id = @id;

    -- Mengembalikan pesan sukses
    SELECT 'Data role berhasil diperbarui.' AS message;
END;
GO





-- SD 029
-- SP change pw
CREATE PROCEDURE dbo.change_password_profile
    @id INT,
    @current_password VARCHAR(255),
    @new_password VARCHAR(255)
AS
BEGIN
    DECLARE @current_password_hash VARCHAR(255);
    DECLARE @new_password_hash VARCHAR(255);

    -- Mengambil hash dari password saat ini
    SELECT @current_password_hash = password
    FROM tbl_users
    WHERE id = @id;

    -- Memeriksa kecocokan password saat ini
    IF @current_password_hash IS NULL OR HASHBYTES('SHA2_256', @current_password) <> CONVERT(VARBINARY(255), @current_password_hash)
    BEGIN
        RAISERROR('Password saat ini tidak sesuai.', 16, 1);
        RETURN;
    END

    -- Menghasilkan hash dari password baru
    SET @new_password_hash = CONVERT(VARCHAR(255), HASHBYTES('SHA2_256', @new_password));

    -- Memperbarui password baru dalam tabel tbl_users
    UPDATE tbl_users
    SET 
        password = @new_password_hash
    WHERE id = @id;

    -- Mengembalikan pesan sukses
    SELECT 'Password berhasil diubah.' AS message;
END;
GO



