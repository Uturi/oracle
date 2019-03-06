--모든테이블 불러오기
select * from tab;
--휴지통비우기
purge recyclebin;


select * from emp_blank;

--비어있는 테이블에 다른테이블의 데이터를 조건에 맞는 일부만 넣고 싶을때.
--sub query를 이용한 insert, 같은 구조의 테이블에서 불러오는거라 * 사용 가능
insert into emp_blank
select *
from employees
where department_id = 80;

--100번 사원의 사번, 이름, 직책, 부서번호
--emp_blank 삽입
insert into emp_blank (employee_id, first_name, last_name, email, hire_date, job_id, department_id)
select employee_id, first_name, last_name, email, hire_date, job_id, department_id
from employees
where employee_id = 100;


----------------------------------------------
insert into member
values ('uturi', '이종영', '1234', 25, 'uturi', 'naver.com', sysdate);
insert into member (id, name, age, pass, emailid, emaildomain, joindate)
values ('hong', '홍길동', '25', 123, 'java2', 'naver.com', sysdate);

insert into member_detail (id, zipcode, address, address_detail, tel1, tel2, tel3)
values ('uturi', '12345', '서울시 관악구 광신길86', '신림2단지아파트', '010', '9914', '0953');

insert all
    into member (id, name, age, pass, emailid, emaildomain, joindate)
    values ('oracle', '오라클', '30', 'a12345678', 'oracle', 'oracle.com', sysdate)
    into member_detail (id, zipcode, address, address_detail, tel1, tel2, tel3)
    values ('oracle', '12345', '서울시 관악구 오라클길63', '오라클연구소', '010', '1234', '5678')
select *  from dual;
-----------------------------------------------

commit;

--update
--이렇게하면 모든 pass가 9876으로 바뀜
update member
set pass = 9876;

--잘못했을때 되돌릴수 있음 롤백
rollback;

--where를 사용 원하는 조건을 써서 원하는 내용만 바꾼다.
--id가 hong인사람의 비밀번호를 9876으로 바꾼다.
update member
set pass = 9876
where id = 'hong';

--'hong'의 비번을 1234로 나이 33으로 변경
update member
set pass = 1234, age = 33
where id = 'hong';
--update에도 서브쿼리 사용가능 다른테이블의 조건도 가능
--'hong'의 비번을 5678로 나이는 아이디가 oracle인 사람과 같게 변경
update member
set pass = 5678, age = (select age from member where id = 'oracle')
where id = 'hong';

update member
set id ='java2', name = '이종영'
where id = '이종영';

commit;

--delete
--삭제할때 순서가 있다. 부모부터 지울수 없음. 참조하고있는 자식부터 지워야함.
--테이블 전체 다지워버림. 조건필요
--delete 테이블이름 할때 from써도되고 안써도되고
--all은 insert만 있음 delete랑 update는 all없음
delete member_detail;
delete member;
--rollback은 커밋한 지점으로 감.
rollback;

--서브쿼리가능함, 업데이트랑 비슷
--아이디가 oracle인사람 삭제하기
--자식테이블 부터
delete member_detail
where id = 'oracle';
--부모테이블에도 삭제
delete member
where id = 'oracle';

select *
from member;
select *
from member_detail;

--merge
---------------------------------------------------세팅
create table product
(
    pid number,
    pname varchar2(10),
    cnt number,
    price number,
    constraint product_pid_pk primary key (pid)
);

insert into product (pid, pname, cnt, price)
values (100, '새우깡', 100, 1500);
insert into product (pid, pname, cnt, price)
values (200, '꼬북칩', 80, 2700);
insert into product (pid, pname, cnt, price)
values (300, '빼빼로', 120, 1000);

update product
set price = 1000
where pid = 300;
-----------------------------------------------세팅끝
--merge 사용법 및 예제

--merge into 테이블이름
--using (테이블이름, 서브쿼리, 뷰)알리아스
--on 조인 조건
--when matched then
--update set (on조건에 맞는게 있으면 수정할 조건)
--when not matched then
--insert (on조건에 맞는게 없을때 삽입할 조건)
--into 나 테이블이름은 따로 추가할 필요가없음, 맨위에서 머지할때 어떤 테이블인지 정했기때문에.
--select insert update를 한번에 다 할 수 있음. 그러나 자주 쓰이지는 않음.

--상품코드가 400인 자갈치(1200원) 150개입고
merge into product
using dual
on (pid = 400)
when matched then
update set cnt = cnt+150 
when not matched then
insert (pid, pname, cnt, price)
values (400, '자갈치', 150, 1200);

--상품코드가 100인 새우깡(1500원) 50개입고
merge into product
using dual
on (pid = 100)
when matched then
update set cnt = cnt+50 
when not matched then
insert (pid, pname, cnt, price)
values (100, '새우깡', 50, 1500);

--확인
select *
from product;

commit;

insert into product
values (101, '감자깡', 150, 1500);

insert into product
values (102, '고구마깡', 70, 1500);

insert into product
values (103, '오징어집', 250, 1500);

savepoint a;

insert into product
values (104, '고래밥', 25, 1500);

insert into product
values (105, '포카칩', 63, 1500);

savepoint b;

insert into product
values (106, '스윙칩', 84, 1500);

insert into product
values (107, '양파깡', 99, 1500);

rollback to a;
rollback to b;

select * from product;
rollback;


--------------------------------
--sequence
--시퀀스는 데이터가 아니라 오브젝트다. 전진은 있어도 후진은없다. 한번 진행된건 끝.
--롤백해봣자 소용없음.
create SEQUENCE product_pid_seq
start with 1 INCREMENT BY 1;

delete product;

commit;

insert into product (pid, pname, cnt, price)
values (PRODUCT_PID_SEQ.nextval, '이름', 10, 1000);

select * from product;
--sequence 확인하기, 확인하는것도 행동 하는것이기때문에 nextval값이 하나 올라가면서 진행이된다.
select PRODUCT_PID_SEQ.nextval
from dual;
--대신에 쓸만한거, 시퀀스 안쓰면 번호 넣을때 이렇게 해야됨 
select max(pid) + 1 from product;
--현재 시퀀스 값
select product_pid_seq.currval
from dual;








