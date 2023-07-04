CREATE TABLE TEST_FUNC(
    ID NUMBER,
    NUM VARCHAR2(20)
);

INSERT INTO TEST_FUNC VALUES(1, '34.5678');
INSERT INTO TEST_FUNC VALUES(1, '34.5618');

SELECT * FROM TEST_FUNC WHERE ID=1;

-- ROUND : �Ҽ��� ���� �ڸ��� �ݿø��ȴ�
SELECT ROUND( NUM, 2) FROM TEST_FUNC WHERE ID=1;    -- 34.57, 34.56
SELECT ROUND( NUM/2, 2) FROM TEST_FUNC WHERE ID=1;  -- 17.28, 17.28

-- �Ҽ��� ����
SELECT TRUNC( NUM, 2) FROM TEST_FUNC WHERE ID=2;

INSERT INTO TEST_FUNC VALUES(2, '55');  -- ���� ���길 ����

-- MOD ������ �������� �����ش�
SELECT NUM FROM TEST_FUNC WHERE ID=2;
SELECT MOD(NUM, 2)FROM TEST_FUNC WHERE ID =2;


insert into test_func values (11, 'welcom To oracle');
select * from test_func where id=11;

-- �빮�� ��ȯ
select upper(num) from test_func where id=11;

--�ҹ��� ��ȯ
select lower(num) from test_func where id=11;

-- ���� ���� ù ���ڴ� �빮�� ��ȯ
select initcap(num) from test_func where id=11;



create table testClass(
    class varchar2(10),
    score number
);

insert into testClass values('A��',11);
insert into testClass values('A��',12);
insert into testClass values('A��',13);
insert into testClass values('B��',21);
insert into testClass values('B��',22);
insert into testClass values('B��',23);
insert into testClass values('1',31);
insert into testClass values('1',32);
insert into testClass values('1',33);
insert into testClass values('',40);

select * from testClass;
select sum(score) from testclass;
select avg(score) from testclass;
select max(score), min(score) from testclass;
select count(class) from testclass; -- null ���� ������ ���Ե��� ����
select count(*) from testclass; -- ��ü ������ ����

-- Ȯ�εǴ� �÷��� group�� �÷��� ������ �÷��� ���;��Ѵ�
select class, sum(score) from testclass group by class;

-- �׷����� ��� ������ ����� ��� having���� �̿��Ѵ�
select class, sum(score) from testclass group by class
                                     having sum(score) > 20;






create table testName(id varchar2(20), class varchar2(20));
insert into testName values('ȫ�浿','A��');
insert into testName values('�谳��','B��');
insert into testName values('��浿','C��');

create table testLesson(id varchar2(20), lesson varchar2(20), score number);
insert into testLesson values('ȫ�浿','python',80);
insert into testLesson values('ȫ�浿','java',90);
insert into testLesson values('ȫ�浿','c���',70);
insert into testLesson values('�谳��','server2012',70);
insert into testLesson values('�谳��','linux',90);
insert into testLesson values('��浿','jsp',100);

select * from testName;
select * from testLesson;
select * from testlesson, testname;

select * from testname N inner join testlesson L on N.id = L.id;
select N.*, L.score from testname N inner join testlesson L on N.id = L.id;





-- foreign key (�ܷ�Ű) : ���Ἲ �������� ����
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

-- �ܷ�Ű ����
ALTER TABLE board
    ADD CONSTRAINT FK_b_id_m_id FOREIGN KEY (b_id)
        REFERENCES membership (m_id) ;

-- ������ ����
CREATE SEQUENCE board_SEQ
START WITH 1
INCREMENT BY 1; -- board_SEQ++


select * from membership;
select * from board;

insert into board(b_num,b_id) values(1, 'aaa'); -- membership m_id�����Ƿ� �������������

drop table membership;  -- �θ����̺��� �����ϱ��� �ڽ����̺��� �����ؾ��� ���� ����
drop table membership cascade constraints; -- �θ����̺� ���� ����

insert into membership(m_id, m_pwd, m_name, m_addr)
                values('aaa', 'aaa', 'ȫ�浿', '���¥��');
                
-- ������ ���� b_num ��
insert into board(b_num, b_id, b_title, b_content, b_date)
        values(board_SEQ.nextval, 'aaa', '����', '����', sysdate);

-- ������ ��� ���� �� b_num ��
insert into board(b_num, b_id, b_title, b_content, b_date)
        values((select max(b_num) from board) + 1, 'aaa', '����', '����', sysdate);
        
        
        
        
select * from all_sequences; -- ��� ������ ������
select * from all_sequences where sequence_owner='JAVA';
select * from user_sequences; -- �α����� ������ ������
        
select * from all_constraints;
select * from all_constraints where owner='JAVA';
select * from user_constraints;

select * from membership;
select * from board;

delete from membership where m_id='aaa'; -- �������� ������ ���� �Ұ���
alter table board drop constraint FK_B_ID_M_ID; -- �������� ����

alter table board
    add constraint fk_b_id_m_id foreign key (b_id)
        references membership (m_id) on delete cascade;

select * from membership;
select * from board;
DELETE FROM MEMBERSHIP WHERE M_ID='aaa';

SELECT * FROM USER_SEQUENCES;
drop sequence BOARD_SEQ;
        
        