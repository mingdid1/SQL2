CREATE TABLE TEST_FUNC(
    ID NUMBER,
    NUM VARCHAR2(20)
);

INSERT INTO TEST_FUNC VALUES(1, '34.5678');
INSERT INTO TEST_FUNC VALUES(1, '34.5618');

SELECT * FROM TEST_FUNC WHERE ID=1;

-- ROUND : 소수점 수를 자르며 반올림된다
SELECT ROUND( NUM, 2) FROM TEST_FUNC WHERE ID=1;    -- 34.57, 34.56
SELECT ROUND( NUM/2, 2) FROM TEST_FUNC WHERE ID=1;  -- 17.28, 17.28

-- 소수점 버림
SELECT TRUNC( NUM, 2) FROM TEST_FUNC WHERE ID=2;

INSERT INTO TEST_FUNC VALUES(2, '55');  -- 숫자 연산만 가능

-- MOD 연산은 나머지를 구해준다
SELECT NUM FROM TEST_FUNC WHERE ID=2;
SELECT MOD(NUM, 2)FROM TEST_FUNC WHERE ID =2;


insert into test_func values (11, 'welcom To oracle');
select * from test_func where id=11;

-- 대문자 변환
select upper(num) from test_func where id=11;

--소문자 변환
select lower(num) from test_func where id=11;

-- 공백 다음 첫 문자는 대문자 변환
select initcap(num) from test_func where id=11;



create table testClass(
    class varchar2(10),
    score number
);

insert into testClass values('A반',11);
insert into testClass values('A반',12);
insert into testClass values('A반',13);
insert into testClass values('B반',21);
insert into testClass values('B반',22);
insert into testClass values('B반',23);
insert into testClass values('1',31);
insert into testClass values('1',32);
insert into testClass values('1',33);
insert into testClass values('',40);

select * from testClass;
select sum(score) from testclass;
select avg(score) from testclass;
select max(score), min(score) from testclass;
select count(class) from testclass; -- null 값은 개수로 포함되지 않음
select count(*) from testclass; -- 전체 개수를 얻어옴

-- 확인되는 컬럼과 group의 컬럼과 동일한 컬럼이 들어와야한다
select class, sum(score) from testclass group by class;

-- 그룹으로 묶어서 조건을 사용할 경우 having절을 이용한다
select class, sum(score) from testclass group by class
                                     having sum(score) > 20;






create table testName(id varchar2(20), class varchar2(20));
insert into testName values('홍길동','A반');
insert into testName values('김개똥','B반');
insert into testName values('고길동','C반');

create table testLesson(id varchar2(20), lesson varchar2(20), score number);
insert into testLesson values('홍길동','python',80);
insert into testLesson values('홍길동','java',90);
insert into testLesson values('홍길동','c언어',70);
insert into testLesson values('김개똥','server2012',70);
insert into testLesson values('김개똥','linux',90);
insert into testLesson values('고길동','jsp',100);

select * from testName;
select * from testLesson;
select * from testlesson, testname;

select * from testname N inner join testlesson L on N.id = L.id;
select N.*, L.score from testname N inner join testlesson L on N.id = L.id;





-- foreign key (외래키) : 무결성 제약조건 성립
CREATE TABLE membership
(
    m_id      VARCHAR2(20)    NOT NULL, 
    m_pwd     VARCHAR2(20)    not NULL, 
    m_name    VARCHAR2(20)    NULL, 
    m_addr    VARCHAR2(20)    NULL, 
     PRIMARY KEY (m_id)
);

CREATE TABLE board
(
    b_num        NUMBER          NOT NULL, 
    b_id         VARCHAR2(20)    NULL, 
    b_title      VARCHAR2(20)    NULL, 
    b_content    VARCHAR2(20)    NULL, 
    b_date       DATE            NULL, 
     PRIMARY KEY (b_num)
);

-- 외래키 설정
ALTER TABLE board
    ADD CONSTRAINT FK_b_id_m_id FOREIGN KEY (b_id)
        REFERENCES membership (m_id) ;

-- 시퀀스 설정
CREATE SEQUENCE board_SEQ
START WITH 1
INCREMENT BY 1; -- board_SEQ++


select * from membership;
select * from board;

insert into board(b_num,b_id) values(1, 'aaa'); -- membership m_id없으므로 만들어지지않음

drop table membership;  -- 부모테이블을 삭제하기전 자식테이블을 삭제해야지 삭제 가능
drop table membership cascade constraints; -- 부모테이블 강제 삭제

insert into membership(m_id, m_pwd, m_name, m_addr)
                values('aaa', 'aaa', '홍길동', '산골짜기');
                
-- 시퀀스 사용시 b_num 값
insert into board(b_num, b_id, b_title, b_content, b_date)
        values(board_SEQ.nextval, 'aaa', '제목', '내용', sysdate);

-- 시퀀스 사용 안할 때 b_num 값
insert into board(b_num, b_id, b_title, b_content, b_date)
        values((select max(b_num) from board) + 1, 'aaa', '제목', '내용', sysdate);
        
        
        
        
select * from all_sequences; -- 모든 계정의 시퀀스
select * from all_sequences where sequence_owner='JAVA';
select * from user_sequences; -- 로그인한 계정의 시퀀스
        
select * from all_constraints;
select * from all_constraints where owner='JAVA';
select * from user_constraints;

select * from membership;
select * from board;

delete from membership where m_id='aaa'; -- 제약조건 때문에 삭제 불가능
alter table board drop constraint FK_B_ID_M_ID; -- 제약조건 삭제

alter table board
    add constraint fk_b_id_m_id foreign key (b_id)
        references membership (m_id) on delete cascade;

select * from membership;
select * from board;
DELETE FROM MEMBERSHIP WHERE M_ID='aaa';

SELECT * FROM USER_SEQUENCES;
drop sequence BOARD_SEQ;
        
        