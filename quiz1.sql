
-- 1번 문제
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

-- quiz 테이블에서 홀수값 
select * from quiz where mod(id,2) = 1;

-- quiz 테이블에서 짝수의 값을 2로 나눈후 소수점 2자리까지 표현하기 ( 버려지는 소수점 반올림으로 진행)
select id, round(num/2, 2) from quiz where mod(id,2) = 0;


-- 2번 문제
create table testCompany(
  name varchar2(20),
  연봉 varchar2(20),
  class varchar2(20)
);

insert into testCompany values('hong gil dong_M','3600','Manager');
insert into testCompany values('kim gea ddong_M','2555','ManaGer');
insert into testCompany values('Go gil dong_M','2800','ManaGER');
insert into testCompany values('hong gil dong_E','3111','EmpLoyee');
insert into testCompany values('kim gea ddong_E','2600','EmpLoYee');
insert into testCompany values('Go gil dong_E','2950','employee');


-- 직급이 manager인 사원 검색
select * from testCompany where lower(class)='manager';

-- 직급이 employee이고 연봉이 2800이상인 사람 검색
select * from testCompany where lower(class)='employee' and "연봉" >= 2800;

-- 모든 사원의 이름의 첫 글자는 대문자로 출력하고 한달 급여 출력(소수점 이하는 버림)
select initcap(name), trunc("연봉"/12, 0) from testCompany;



-- 3번 문제 (testclass)
-- 각 클래스별 개수 출력
select class,count(*) from testclass group by class;

-- 각 클래스별 평균 구하고 별 내림차순으로 정렬하여 출력
select class,avg(score) from testclass group by class order by avg(score) desc;

-- 각 클래스별로 가장 큰 값과 가장 작은 값 출력
select class, max(score), min(score) from testclass group by class;




-- id가 홍길동인 사람의 인적사항을 출력
-- id, class, lesson, score만 출력
-- 1. on 다음에 조건은 join의 조건이며 where절을 사용할 수 있다                                                                    
select N.*,L.lesson,L.score from testname N inner join testlesson L on N.id =L.id
                                                                    where N.id='홍길동';
                                                                    
-- 2. and 사용
select N.*,L.lesson,L.score from testname N inner join testlesson L on N.id =L.id
                                                                    and N.id='홍길동';


-- 각 이름, 클래스별 합계와 평균 출력
select N.id,N.class, sum(L.score),avg(L.score) 
        from testName N inner join testlesson L on N.id =L.id 
                group by N.id, N.class 
                        order by class asc;




-- member 생성
CREATE TABLE member
(
    m_id      VARCHAR2(20)    NOT NULL, 
    m_pwd     VARCHAR2(20)    NULL, 
    m_name    VARCHAR2(20)    NULL, 
    m_addr    VARCHAR2(20)    NULL, 
     PRIMARY KEY (m_id)
);

-- goods 생성
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

-- goods 시퀀스 생성
CREATE SEQUENCE goods_SEQ
START WITH 1
INCREMENT BY 1;

-- goods 외래키 설정
ALTER TABLE goods
    ADD CONSTRAINT g_id_m_id FOREIGN KEY (g_id)
        REFERENCES member (m_id) ;


insert into member(m_id, m_pwd, m_name, m_addr)
    values ('aaa', 'aaa', '홍길동', '산골짜기');
    
insert into member(m_id, m_pwd, m_name, m_addr)
    values ('bbb', 'bbb', '김개똥', '개똥별');
    
insert into member(m_id, m_pwd, m_name, m_addr)
    values ('ccc', 'ccc', '고길동', '마포구');
    
insert into member(m_id, m_pwd, m_name, m_addr)
    values ('ddd', 'ddd', '김말이', '분식집');

insert into goods values(goods_seq.nextval, 'aaa', '운동화', 75000, 2, 150000, sysdate);
insert into goods values(goods_seq.nextval, 'aaa', '티셔츠', 15000, 5, 75000, sysdate);
insert into goods values(goods_seq.nextval, 'bbb', '가방', 450000, 1, 450000, sysdate);
insert into goods values(goods_seq.nextval, 'bbb', '책', 35000, 2, 70000, sysdate);

select * from member;
select * from goods;

-- inner join 사용해보기 전체 출력
select M.*, G.* from member M inner join goods G on m.m_id = G.g_id;


-- innner join 사용해서 id별 이름과 물건, 총금액
select M.m_id, M.m_name,G.g_name,G.g_price_sum 
    from member M inner join goods G on M.m_id = G.g_id;
    
    
-- sum 함수 이용해서 아이디별 총 금액 구하기
select M.m_id, M.m_name, M.m_addr, sum(G.g_price_sum)
    from member M inner join goods G on M.m_id = G.g_id
        group by M.m_id, M.m_name, M.m_addr;







