CREATE TABLE USER (

userID VARCHAR(20),

userPassword VARCHAR(20),

userName VARCHAR(20),

userGender VARCHAR(20),

userEmail VARCHAR(50),

PRIMARY KEY (userID) 

) DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

select * from user;