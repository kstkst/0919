CREATE TABLE BBS (

    bbsID INT,

    bbsTitle VARCHAR(50),

    userID VARCHAR(20),

    bbsDate DATETIME,

    bbsContent VARCHAR(2048),

    bbsAvailable INT,

	category varchar(10),

	groupId int,
     
    PRIMARY KEY (bbsID)

    ) DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

select * from bbs;