USE mern;

CREATE TABLE tblDepartment (
    intDepartmentId SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    strName VARCHAR(50) NOT NULL,
    PRIMARY KEY (intDepartmentId)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Departments';

CREATE TABLE tblUser (
    intUserId INT UNSIGNED NOT NULL AUTO_INCREMENT,
    strName VARCHAR(50) NOT NULL,
    strLastName VARCHAR(50) DEFAULT NULL,
    intDepartmentId SMALLINT UNSIGNED NOT NULL,
    email VARCHAR(255) DEFAULT NULL,
    intSalary INT UNSIGNED NOT NULL,
    dtmDateOfBirth DATE NOT NULL,
    enmGender ENUM('m', 'f') NOT NULL,
    PRIMARY KEY (intUserId),
    CONSTRAINT FK_tblUser_intDepartmentId FOREIGN KEY (intDepartmentId) REFERENCES tblDepartment (intDepartmentId)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Users';

# Insert test data
INSERT INTO tblDepartment (strName) VALUES
    ('Marketing'),
    ('HR'),
    ('Finance'),
    ('Production');

SET @MARKETING = (SELECT intDepartmentId FROM tblDepartment WHERE strName = 'Marketing');
SET @HR = (SELECT intDepartmentId FROM tblDepartment WHERE strName = 'HR');
SET @FINANCE = (SELECT intDepartmentId FROM tblDepartment WHERE strName = 'Finance');
SET @PRODUCTION = (SELECT intDepartmentId FROM tblDepartment WHERE strName = 'Production');

DELETE FROM tblUser WHERE intUserId IS NOT NULL;
INSERT INTO tblUser
    (strName, strLastName, intDepartmentId, intSalary, dtmDateOfBirth, enmGender)
VALUES
    ('Alex', 'Smith', @MARKETING, 200000, '1990-02-24', 'm'),
    ('Dan', 'Browm', @MARKETING, 150000, '2005-06-02', 'm'),
    ('Alex', null, @HR, 100000, '1998-01-01', 'f'),
    ('Mary', 'Pimp', @HR, 120000, '2000-08-21', 'f'),
    ('Alex', 'Good', @FINANCE, 300000, '1980-02-26', 'm'),
    ('Bob', 'Marley', @PRODUCTION, 80000, '1997-04-23', 'm'),
    ('Grag', 'Booth', @PRODUCTION, 200000, '1990-02-24', 'm'),
    ('Alex', null, @PRODUCTION, 200000, '1991-04-24', 'f'),
    ('Fin', 'Thru', @PRODUCTION, 200000, '1994-02-24', 'f'),
    ('Olga', null, @PRODUCTION, 200000, '2003-06-28', 'f'),
    ('Noy', null, @PRODUCTION, 200000, '1999-02-04', 'm'),
    ('Alexandra', null, @PRODUCTION, 200000, '2002-04-14', 'f'),
    ('Daniel', null, @PRODUCTION, 200000, '1990-05-05', 'm'),
    ('Yanka', null, @PRODUCTION, 200000, '2004-09-13', 'f'),
    ('Grzegorz', null, @PRODUCTION, 200000, '1999-12-03', 'm')
;

# SELECT emamples
# 1
SELECT * FROM tblUser u ORDER BY u.strName ASC;

# 2
SELECT
    *
FROM tblUser u
WHERE u.strLastName IS NOT NULL;

# 3
SELECT
    *
FROM tblUser u
WHERE u.strName like '%a%';

# 4
SELECT
    COUNT(*)
FROM tblUser u
WHERE u.strLastName IS NOT NULL;

# 5
SELECT
    d.strName,
    COUNT(*)
FROM tblUser u
    INNER JOIN tblDepartment d ON u.intDepartmentId = d.intDepartmentId
GROUP BY u.intDepartmentId;

# 6
SELECT
    d.strName,
    COUNT(*) AS cnt
FROM tblUser u
         INNER JOIN tblDepartment d ON u.intDepartmentId = d.intDepartmentId
GROUP BY u.intDepartmentId
HAVING cnt > 1;

# 7, 8
SELECT
    d.strName,
    AVG(u.intSalary),
    MAX(u.intSalary)
FROM tblDepartment d
    INNER JOIN tblUser u on d.intDepartmentId = u.intDepartmentId
GROUP BY d.intDepartmentId;

# 9
SELECT DISTINCT u.strName FROM tblUser u;
# Men first
SELECT DISTINCT
    u.strName,
    u.enmGender
FROM tblUser u
ORDER BY
    CASE u.enmGender
        WHEN 'm' THEN 1
        WHEN 'f' THEN 2
    END
;

# 10
SELECT
    u.enmGender,
    COUNT(*) AS cnt
FROM tblUser u
WHERE
    TIMESTAMPDIFF(YEAR, u.dtmDateOfBirth, CURDATE()) < 25
GROUP BY u.enmGender
