
CREATE TABLE MEMBERS (
    USERID     VARCHAR(12)  PRIMARY KEY,
    PASSWD     VARCHAR(12)    NOT NULL,
    USERNAME   VARCHAR(30)   NOT NULL,
    EMAIL   VARCHAR(320)    NOT NULL,
    RDATE      DATE    DEFAULT SYSDATE
);
alter user jsp default tablespace users quota unlimited on users;

INSERT INTO members ( userid, passwd, username, email )
 VALUES ( 'admin', '1234', '관리자', 'admin@myshop.com' );
INSERT INTO members ( userid, passwd, username, email )
 VALUES ( 'sky',   '1234', '스카이', 'sky@myshop.com' );
INSERT INTO members ( userid, passwd, username, email )
 VALUES ( 'winter', '1234', '겨울', 'winter@myshop.com' );
INSERT INTO members ( userid, passwd, username, email )
 VALUES ( 'spring', '1234', '봄', 'spring@myshop.com' );

commit; 

select * from members;

select * from members
where userid='admin' or passwd='1234';