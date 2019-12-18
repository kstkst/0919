
-- root 로 접속

-- wine 사용자계정 생성
create user 'wine'@'localhost' identified by '1234';

-- wine이 사용하는 DB(Schema) 생성
create database winedb;

-- wine에게 winedb 권한 부여
grant all privileges on winedb.* to 'wine'@'localhost' with grant option;

-- wine에게 파일 처리권한 부여
grant file on *.* to 'wine'@'localhost';

-- user 계정생성
CREATE TABLE USER (

userID VARCHAR(20),

userPassword VARCHAR(20),

userName VARCHAR(20),

userGender VARCHAR(20),

userEmail VARCHAR(50),

PRIMARY KEY (userID) 

) DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

select * from user;
drop table user;

-- 게시판 생성
CREATE TABLE BBS (

    bbsID INT,

    bbsTitle VARCHAR(50),

    userID VARCHAR(20),

    bbsDate DATETIME,

    bbsContent VARCHAR(2048),

    bbsAvailable int,

	category varchar(10),

	groupId int,
    
    hit int,
     
    PRIMARY KEY (bbsID)

    ) DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

select * from bbs;
drop table bbs;
SELECT hit FROM BBS WHERE bbsID = 1;

/*create table Board (
	id int not null auto_increment,
	user varchar(8) not null,
	title varchar(8) not null,
	date varchar(10),
	content varchar(500) not null,
	primary key (id)
) charset=utf8;

select * from Board;

SET SQL_SAFE_UPDATES = 0;
UPDATE BBS SET bbsAvailable = bbsAvailable + 1 where groupId = 2;
delete from BBS where groupId = 2;
UPDATE BBS SET hit = hit + 1 WHERE bbsID = 2;

insert into Board(user,title,date,content) values("김성택", "안녕하세요", "2018-12-01", "반갑습니다");
insert into Board(user,title,date,content) values("이성택", "안녕히가세요", "2018-12-01", "저도반갑습니다");
*/