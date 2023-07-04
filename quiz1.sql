
-- 1�� ����
create table quiz(
    id NUMBER,
    num varchar2(20)
);

insert into quiz values(1, '1.11');
insert into quiz values(2, '2.22');
insert into quiz values(3, '3.333');
insert into quiz values(4, '4.4444');
insert into quiz values(5, '5.55555');
insert into quiz values(6, '6.6666');
insert into quiz values(7, '7.777');
insert into quiz values(8, '8.8');
insert into quiz values(9, '9.999');
insert into quiz values(10, '21.34');

-- quiz ���̺��� Ȧ���� 
select * from quiz where mod(id,2) = 1;

-- quiz ���̺��� ¦���� ���� 2�� ������ �Ҽ��� 2�ڸ����� ǥ���ϱ� ( �������� �Ҽ��� �ݿø����� ����)
select id, round(num/2, 2) from quiz where mod(id,2) = 0;


-- 2�� ����
create table testCompany(
  name varchar2(20),
  ���� varchar2(20),
  class varchar2(20)
);

insert into testCompany values('hong gil dong_M','3600','Manager');
insert into testCompany values('kim gea ddong_M','2555','ManaGer');
insert into testCompany values('Go gil dong_M','2800','ManaGER');
insert into testCompany values('hong gil dong_E','3111','EmpLoyee');
insert into testCompany values('kim gea ddong_E','2600','EmpLoYee');
insert into testCompany values('Go gil dong_E','2950','employee');


-- ������ manager�� ��� �˻�
select * from testCompany where lower(class)='manager';

-- ������ employee�̰� ������ 2800�̻��� ��� �˻�
select * from testCompany where lower(class)='employee' and "����" >= 2800;

-- ��� ����� �̸��� ù ���ڴ� �빮�ڷ� ����ϰ� �Ѵ� �޿� ���(�Ҽ��� ���ϴ� ����)
select initcap(name), trunc("����"/12, 0) from testCompany;



-- 3�� ���� (testclass)
-- �� Ŭ������ ���� ���
select class,count(*) from testclass group by class;

-- �� Ŭ������ ��� ���ϰ� �� ������������ �����Ͽ� ���
select class,avg(score) from testclass group by class order by avg(score) desc;

-- �� Ŭ�������� ���� ū ���� ���� ���� �� ���
select class, max(score), min(score) from testclass group by class;




-- id�� ȫ�浿�� ����� ���������� ���
-- id, class, lesson, score�� ���
-- 1. on ������ ������ join�� �����̸� where���� ����� �� �ִ�                                                                    
select N.*,L.lesson,L.score from testname N inner join testlesson L on N.id =L.id
                                                                    where N.id='ȫ�浿';
                                                                    
-- 2. and ���
select N.*,L.lesson,L.score from testname N inner join testlesson L on N.id =L.id
                                                                    and N.id='ȫ�浿';


-- �� �̸�, Ŭ������ �հ�� ��� ���
select N.id,N.class, sum(L.score),avg(L.score) 
        from testName N inner join testlesson L on N.id =L.id 
                group by N.id, N.class 
                        order by class asc;




-- member ����
CREATE TABLE member
(
    m_id      VARCHAR2(20)    NOT NULL, 
    m_pwd     VARCHAR2(20)    NULL, 
    m_name    VARCHAR2(20)    NULL, 
    m_addr    VARCHAR2(20)    NULL, 
     PRIMARY KEY (m_id)
);

-- goods ����
CREATE TABLE goods
(
    g_num          INT             NOT NULL, 
    g_id           VARCHAR2(20)    NULL, 
    g_name         VARCHAR2(20)    NULL, 
    g_price        INT             NULL, 
    g_count        INT             NULL, 
    g_price_sum    INT             NULL, 
    g_date         DATE            NULL, 
     PRIMARY KEY (g_num)
);

-- goods ������ ����
CREATE SEQUENCE goods_SEQ
START WITH 1
INCREMENT BY 1;

-- goods �ܷ�Ű ����
ALTER TABLE goods
    ADD CONSTRAINT g_id_m_id FOREIGN KEY (g_id)
        REFERENCES member (m_id) ;


insert into member(m_id, m_pwd, m_name, m_addr)
    values ('aaa', 'aaa', 'ȫ�浿', '���¥��');
    
insert into member(m_id, m_pwd, m_name, m_addr)
    values ('bbb', 'bbb', '�谳��', '���˺�');
    
insert into member(m_id, m_pwd, m_name, m_addr)
    values ('ccc', 'ccc', '��浿', '������');
    
insert into member(m_id, m_pwd, m_name, m_addr)
    values ('ddd', 'ddd', '�踻��', '�н���');

insert into goods values(goods_seq.nextval, 'aaa', '�ȭ', 75000, 2, 150000, sysdate);
insert into goods values(goods_seq.nextval, 'aaa', 'Ƽ����', 15000, 5, 75000, sysdate);
insert into goods values(goods_seq.nextval, 'bbb', '����', 450000, 1, 450000, sysdate);
insert into goods values(goods_seq.nextval, 'bbb', 'å', 35000, 2, 70000, sysdate);

select * from member;
select * from goods;

-- inner join ����غ��� ��ü ���
select M.*, G.* from member M inner join goods G on m.m_id = G.g_id;


-- innner join ����ؼ� id�� �̸��� ����, �ѱݾ�
select M.m_id, M.m_name,G.g_name,G.g_price_sum 
    from member M inner join goods G on M.m_id = G.g_id;
    
    
-- sum �Լ� �̿��ؼ� ���̵� �� �ݾ� ���ϱ�
select M.m_id, M.m_name, M.m_addr, sum(G.g_price_sum)
    from member M inner join goods G on M.m_id = G.g_id
        group by M.m_id, M.m_name, M.m_addr;







