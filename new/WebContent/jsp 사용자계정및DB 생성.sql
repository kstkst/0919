
-- root 로 접속

-- wine 사용자계정 생성
create user 'wine'@'localhost' identified by '1234';

-- wine이 사용하는 DB(Schema) 생성
create database winedb;

-- wine에게 winedb 권한 부여
grant all privileges on winedb.* to 'wine'@'localhost' with grant option;

-- wine에게 파일 처리권한 부여
grant file on *.* to 'wine'@'localhost';