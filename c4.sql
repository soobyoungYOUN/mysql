use kopoctc; # 해당 데이터 베이스를 이용하겠다
desc twiceHubo; # twiceHubo 테이블에 대한 설명을 출력
desc twiceTupyo; # twiceTupyo 테이블에 대한 설명을 출력

delete from twiceHubo where kiho > 0; #twiceHubo테이블에 kiho 컬럼의 값이 0보다 큰 값들을 모두 제거
insert into twiceHubo values (1, "나연", "정의사회 구현"); #테이블에 데이터 입력, 인덱스, 이름 ,공약
insert into twiceHubo values (2, "정연", "모두 1억 줌");
insert into twiceHubo values (3, "모모", "금토일금토일일");
insert into twiceHubo values (4, "사나", "살맛나는 세상, 비계맛도 조금");
insert into twiceHubo values (5, "지효", "먹다 지쳐 잠드는 세상");
insert into twiceHubo values (6, "미나", "나 뽑으면 너하고 싶은 거 다해");
insert into twiceHubo values (7, "다현", "장바구니 다 사줄게");
insert into twiceHubo values (8, "채영", "노는게 젤 좋음");
insert into twiceHubo values (9, "쯔위", "커플지옥 싱글천국");

####################################################8
#twiceHubo테이블의 kiho 컬럼을 기호로 바꿔출력, name컬럼을 성명, gongyak컬럼을 공약으로 변경하여 출력
#기호의 내림차순으로 정렬하여 출력
select kiho as 기호, name as 성명, gongyak as 공약 from twiceHubo order by kiho desc;

delete from twiceTupyo where kiho > 0;  #twiceTupyo 테이블의 kiho컬럼 값이 0을 초과하면 제거
Drop procedure if exists insert_twiceTupyo; #insert_twiceTupyo 프로시저가 존재하면 제거
Delimiter $$
create procedure insert_twiceTupyo( _limit integer) #프로시저를 생성, 정수를 인수로 받음
begin 									#프로시저의 시작
declare _cnt integer;					#프로시저 내부의 정수형 변수 선언 
set _cnt = 0;							#변수의 값을 0으로 초기화
	_loop: loop							#반복분 실행
		set _cnt = _cnt + 1;			#반복문을 실행할 때마다 _cnt의 값 1씩 누적
        insert into twiceTupyo value (rand()*8 + 1, rand()*8 + 1); #twiceTupyo 테이블에 랜덤 값 입력
        if _cnt = _limit then			#_cnt의 값이 입력받은 인수의 값에 도달 하면(조건문)
			leave _loop;				#반복문을 벗어남
		end if;							#조건문의 종료
	end loop _loop;						#반복문의 종료
end $$									#프로시저 종료

call insert_twiceTupyo(1000);			#프로시저 실행, 1000을 인수로 입력 => 1000개의 랜덤 값 입력

#후보테이블의 데이터 출력, kiho => 기호, name => 성명, gongyak => 공약
select kiho as 기호, name as 성명, gongyak 공약 from twiceHubo; 
#투표테이블의 데이터 출력, kiho => 투표한기호, age => 투표자연령대
select kiho as 투표한기호, age as 투표자연령대 from twiceTupyo;

select kiho, count(*) from twiceTupyo group by kiho;

#join 문장 활용
#b는 twiceHubo, a는 twiceTupyo테이블
#b.name 은 twiceHubo의 name 컬럼 값
#a.kiho 는 twiceTupyo의 kiho 컬럼 값
#후보자의 이름, 공약, 지지도를 출력
select b.name, b.gongyak, count(a.kiho) 
	from twiceTupyo as a, twiceHubo as b
	where a.kiho = b.kiho
    group by a.kiho ;

-- p5 join
#select 안에 select 문장
select
	#twiceHubo의 kiho와 twiceTupyo의 kiho가 같은 데이터 중에서 이름만 출력
	(select name from twiceHubo where kiho = a.kiho), 
    #twiceHubo의 kiho와 twiceTupyo의 kiho가 같은 데이터 중에서 공약만 출력
	(select gongyak from twiceHubo where kiho = a.kiho),
    #twiceTupyo의 kiho데이터를 group by 하므로써 지지도 출력
    count(a.kiho)
    from twiceTupyo as a
    group by a.kiho;

-- p13 호감도 투표2
drop table if exists twiceTupyo2; #테이블이 있다면 지워라
create table twiceTupyo2( #테이블 생성
	kiho1 int,
    kiho2 int,
    kiho3 int,
    age int
    );
desc twiceTupyo2; #테이블에 대한 간단한 설명

Drop procedure if exists insert_twiceTupyo2; #프로시저 제거
Delimiter $$
create procedure insert_twiceTupyo2(_limit integer) #프로시저 생성, 정수 인수 받음
begin
declare _cnt integer; #프로시저 내부변수 선언
set _cnt = 0; #변수의 값 초기화
	_loop: loop #반복문 실행
		set _cnt = _cnt + 1; #변수 값 1씩 증가
        insert into twiceTupyo2 value (
			rand()*8 + 1, rand()*8 + 1, rand()*8 + 1, rand()*8 + 1); #랜덤 값입력
        if _cnt = _limit then #입력받은 인수의 값과 내부변수의 값이 동일하면 반복문 벗어남
			leave _loop;
		end if; #조건문 종료
	end loop _loop; #반복문 종료
end $$ #프로시저 종료


call insert_twiceTupyo2(1000); #1000 개의 데이터 입력 프로시정 실행
select * from twiceTupyo2; #결과 확인

#################################################################
--  p14 호감도 투표2
select a.age, h1.name as 투표1, h2.name as 투표2, h3.name as 투표3
	from twiceTupyo2 as a, twiceHubo as h1, twiceHubo as h2, twiceHubo as h3
	where a.kiho1 = h1.kiho and a.kiho2= h2.kiho and a.kiho3 = h3.kiho ;

select (select name from twiceHubo where a.kiho1 = kiho) as "투표1",
	(select name from twiceHubo where a.kiho2 = kiho) as "투표2",
    (select name from twiceHubo where a.kiho3 = kiho) as "투표3" from twiceTupyo2 as a;
#################################################################
   
-- p15
select #twiceTupyo2테이블에서 kiho1,2,3 컬럼에 해당 데이터수를 출력
#select 안에 세부 select로 원하는 값만을 추출 가능
(select count(*) from twiceTupyo2 where kiho1 = 1 or kiho2 = 1 or kiho3 = 1) as "나연",
(select count(*) from twiceTupyo2 where kiho1 = 2 or kiho2 = 2 or kiho3 = 2) as "정연",
(select count(*) from twiceTupyo2 where kiho1 = 3 or kiho2 = 3 or kiho3 = 3) as "모모",
(select count(*) from twiceTupyo2 where kiho1 = 4 or kiho2 = 4 or kiho3 = 4) as "사나",
(select count(*) from twiceTupyo2 where kiho1 = 5 or kiho2 = 5 or kiho3 = 5) as "지효",
(select count(*) from twiceTupyo2 where kiho1 = 6 or kiho2 = 6 or kiho3 = 6) as "미나",
(select count(*) from twiceTupyo2 where kiho1 = 7 or kiho2 = 7 or kiho3 = 7) as "다현",
(select count(*) from twiceTupyo2 where kiho1 = 8 or kiho2 = 8 or kiho3 = 8) as "채영",
(select count(*) from twiceTupyo2 where kiho1 = 9 or kiho2 = 9 or kiho3 = 9) as "쯔위";

-- p16 호감도 투표 4
select #twiceTupyo2테이블에서 kiho1,2,3 컬럼에 해당 데이터수를 출력
#select 안에 세부 select로 원하는 값만을 추출 가능
(select count(*) from twiceTupyo2 where kiho1 = 1 or kiho2 = 1 or kiho3 = 1) as "나연",
(select count(*) from twiceTupyo2 where kiho1 = 2 or kiho2 = 2 or kiho3 = 2) as "정연",
(select count(*) from twiceTupyo2 where kiho1 = 3 or kiho2 = 3 or kiho3 = 3) as "모모",
(select count(*) from twiceTupyo2 where kiho1 = 4 or kiho2 = 4 or kiho3 = 4) as "사나",
(select count(*) from twiceTupyo2 where kiho1 = 5 or kiho2 = 5 or kiho3 = 5) as "지효",
(select count(*) from twiceTupyo2 where kiho1 = 6 or kiho2 = 6 or kiho3 = 6) as "미나",
(select count(*) from twiceTupyo2 where kiho1 = 7 or kiho2 = 7 or kiho3 = 7) as "다현",
(select count(*) from twiceTupyo2 where kiho1 = 8 or kiho2 = 8 or kiho3 = 8) as "채영",
(select count(*) from twiceTupyo2 where kiho1 = 9 or kiho2 = 9 or kiho3 = 9) as "쯔위",
#전체 투표 데이터 3000에서 2중복, 3중복을 뺀 합계
(select count(kiho1) + count(kiho2) + count(kiho3) - 
	(select count(*) from twiceTupyo2 where kiho1 = kiho2 or kiho2 = kiho3 or kiho1 = kiho3)  
	from twiceTupyo2) as 총합,
#2중복데이터만 출력, 세 투표지 모두 중복되는 값을 빼준 순수한 2중복 투표지    
(select count(*) - 
	(select count(*) from twiceTupyo2 where kiho1 = kiho2 and kiho2 = kiho3 and kiho1 = kiho3)  
	from twiceTupyo2 where kiho1 = kiho2 or kiho2 = kiho3 or kiho1 = kiho3) as "2중복",
#3중복 데이터만 출력    
(select count(*)  from twiceTupyo2 where kiho1 = kiho2 and kiho2 = kiho3 and kiho1 = kiho3)  as "3중복";

-- p17
use kopoctc; #kopoctc 데이터베이스에 접근
drop table if exists examtablec4p17; #기존 examtablec4p17 테이블이 있다면 제거
create table examtablec4p17( #테이블 생성
	name varchar(20), #테이블 구성요소 설정
    id int not null primary key, #id를 고유값으로 설정
    kor int, eng int, mat int);
desc examtablec4p17; #테이블에 대한 간단한 설명

delete from examtablec4p17 where id > 0; #테이블에 값이 존재하면 지우기
#테이블에 값을 입력할 프로시저만들기 전 중복 프로시저 제거
drop procedure if exists insert_examtablec4p17; 
delimiter $$
create procedure insert_examtablec4p17(_limit integer) #정수 인수의 프로시저 생성
begin
declare _name varchar(20); #내부 변수 생성
declare _id integer; #내부 변수 생성
declare _cnt integer; #내부 변수 생성
set _cnt = 0; #내부 변수 _cnt 값 초기화
	_loop: loop #반복문 시작
		set _cnt = _cnt + 1; #_cnt 1씩 누적
        #concant으로 홍길 + 숫자를 합한 문자를 이름으로 입력
		set _name = concat("홍길", cast(_cnt as char(4))) ; 
		set _id = 209900 + _cnt; #학번은 증가된 값을 추가하여 부여
		
        #생성된 내부변수들의 값을 examtablec4p17 테이블에 입력
		insert into examtablec4p17 value (_name, _id, rand() * 100, rand() * 100, rand() * 100);
		
		if _cnt = _limit then #인수 값에 _cnt 값이 도달하면 반복문 벗어남
			leave _loop;
		end if; #조건문 종료
	end loop _loop; #반복 종료
end $$ #프로시저 종려
call insert_examtablec4p17(1000); #프로시저 실행
select * from examtablec4p17; #테이블 확인

#view 형식의 examview를 제거(존재한다면)
drop view if exists examview; 
#view 형식의 examview를 생성
#이름, 학번, 국,영,수,총점,평균,등수를 인수로 받음
create view examview(name, id, kor, eng, mat, tot, ave, ran) 
as select *, #examtablec4p17테이블의 이름, 학번, 국어, 영어, 수학 컬럼의 모든 값
	b.kor + b.eng + b.mat, # 총점
    (b.kor + b.eng + b.mat) / 3, # 평균
    (select count(*) + 1 from examtablec4p17 as a #테이블 조인을 등수를 입력하는 방식		
		where (a.kor + a.eng + a.mat) > (b.kor + b.eng + b.mat)) # 등수
	from examtablec4p17 as b; #examview의 생성 완료
    
select * from examview; #examview의 모든 값을 출력
select name, ran from examview; #examview의 이름과 등수를 출력

select * from examview where ran > 5; #5등 보다 낮은 등수의 데이터만을 출력 가능
insert into examview values ("나연", 309933,100,100,100,300,100,1);

-- p20
drop table if exists examtableEXc4p17; #examtableEXc4p17 기존의 테이블 제거
create table examtableEXc4p17( #테이블 생성
	name varchar(20), #테이블의 구성 요소
    id int not null primary key, #id가 primary key가 되어 중복을 방지
    kor int, eng int, mat int, sum int, ave double, ranking int);
    #이름, 학번, 국,영,수,총점, 평균, 등수를 컬럼으로 받음
desc examtableEXc4p17; #테이블 설명

insert into examtableEXc4p17 #examtableEXc4p17 테이블에 데이터 입력
	#examtablec4p17 테이블의 모든 값에 총점, 평균, 등수 계산 값을 추가하여 examtableEXc4p17 테이블의 값으로 입력
	select *, b.kor + b.eng + b.mat, (b.kor + b.eng + b.mat) /3, 
    (select count(*) + 1 from examtablec4p17 as a where (a.kor + a.eng + a.mat) > (b.kor + b.eng + b.mat))
    from examtablec4p17 as b;

select * from examtableEXc4p17 order by ranking desc; #테이블 결과 확인, 등수의 내림차순 정렬

######################################실습하기
#테이블 생성, 과목, 정답20개
use kopoctc;		#kopoctc 데이터베이스 접근
drop table if exists Answer; #기존테이블 존재하면 제거
create table Answer( #테이블 생성
	subjectID int not null primary key, #과목 코드, pk 값으로 설정, 공란 불허
    #정답이 입력될 곳
    s1 int, s2 int, s3 int, s4 int, s5 int, s6 int, s7 int, s8 int, s9 int, s10 int,
    s11 int, s12 int, s13 int, s14 int, s15 int, s16 int, s17 int, s18 int, s19 int, s20 int);
    
drop table if exists Testing;
create table Testing(
	subjectID int not null,
    stu_name varchar(20),
    stu_id int not null,
    s1 int, s2 int, s3 int, s4 int, s5 int, s6 int, s7 int, s8 int, s9 int, s10 int,
    s11 int, s12 int, s13 int, s14 int, s15 int, s16 int, s17 int, s18 int, s19 int, s20 int,
    primary key(subjectID, stu_id)
    );
    
drop table if exists Scoring;
create table Scoring(
	subjectID int not null,
    stu_name varchar(20),
    stu_id int not null,
    s1 int, s2 int, s3 int, s4 int, s5 int, s6 int, s7 int, s8 int, s9 int, s10 int,
    s11 int, s12 int, s13 int, s14 int, s15 int, s16 int, s17 int, s18 int, s19 int, s20 int,
    score int,
    primary key(subjectID, stu_id)
    );
    
drop table if exists Reporttable;
create table Reporttable(
	stu_name varchar(20),
    stu_id int not null primary key,
    kor int, eng int, mat int
    );
    
desc Answer;
desc Testing;
desc Scoring;
desc Reporttable;



drop procedure if exists insert_solution; #insert_insert_solution 프로시저가 존재하면 제거
Delimiter $$
create procedure insert_solution( _subject integer) #프로시저를 생성, 정수를 인수로 받음
begin 									#프로시저의 시작
	insert into Answer value (_subject,
		rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1,
		rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1,
		rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1,
		rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1
		); #Answer 테이블에 랜덤 값 입력
end $$									#프로시저 종료

call insert_solution(1000); #1000 = 국어
call insert_solution(2000); #2000 = 영어
call insert_solution(3000); #3000 = 수학

select * from Answer;

desc examtableEXc4p17;

#학생의 답안을 데이터를 입력할 프로시저 생성
drop procedure if exists insert_stuAnswer; #insert_stuAnswer 프로시저가 존재하면 제거
Delimiter $$
create procedure insert_stuAnswer(_subject integer) #프로시저를 생성, 정수를 인수로 받음, 과목코드
begin 									#프로시저의 시작
	declare _id integer;
    set _id = 209901;	#학번을 입력하고 마지막 학번에 도달 하면 멈춤
	_loop: loop							#반복분 실행
		insert into Testing value (
			_subject, #과목코드를 인수로 입력받음
			(select name from examtablec4p17 where id = _id), #examtablec4p17테이블에서 id가 같은 이름을 받아서 입력
            (select id from examtablec4p17 where id = _id),#examtablec4p17테이블에서 id가 같은 학번을 받아서 입력
			rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, #학생의 답안 랜덤 생성
			rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1,
			rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1,
			rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1
			); #Testing 테이블에 랜덤 값 입력
		set _id = _id + 1;				#입력이 한번 실행됐을 때, 1추가, 학번
		if _id = 210901 then			#_id의 값이 초과된 학번 수에 도달하면 
			leave _loop;				#반복문을 벗어남
		end if;							#조건문의 종료
	end loop _loop;						#반복문의 종료
end $$									#프로시저 종료

call insert_stuAnswer(1000); #학생의 국어 답안
call insert_stuAnswer(2000); #학생의 영어 답안
call insert_stuAnswer(3000); #학생의 수학 답안

select * from Testing; #Testing 테이블의 내용 확인
select s1 from Testing where stu_id = 209901 and subjectID = 1000;


#학생의 점수 데이터를 입력
#하나의 행을 읽고 순서대로 대입
insert into Scoring (subjectID, stu_name, stu_id, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10,
											s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, score) 
	select b.subjectID, b.stu_name, b.stu_id, #Testing 테이블에서 과목코드, 이름, 학번 컬럼을 입력,
				(select count(*) from Answer as a where a.s1 = b.s1 and a.subjectID = b.subjectID),  #정답테이블과, 학생의 답안테이블이 일치할 때, Scoring 테이블의 컬럼에 1입력, 다르면 0입력
                (select count(*) from Answer as a where a.s2 = b.s2 and a.subjectID = b.subjectID), 
                (select count(*) from Answer as a where a.s3 = b.s3 and a.subjectID = b.subjectID), 
                (select count(*) from Answer as a where a.s4 = b.s4 and a.subjectID = b.subjectID), 
                (select count(*) from Answer as a where a.s5 = b.s5 and a.subjectID = b.subjectID), 
                (select count(*) from Answer as a where a.s6 = b.s6 and a.subjectID = b.subjectID), 
                (select count(*) from Answer as a where a.s7 = b.s7 and a.subjectID = b.subjectID), 
                (select count(*) from Answer as a where a.s8 = b.s8 and a.subjectID = b.subjectID), 
                (select count(*) from Answer as a where a.s9 = b.s9 and a.subjectID = b.subjectID), 
                (select count(*) from Answer as a where a.s10 = b.s10 and a.subjectID = b.subjectID), 
                (select count(*) from Answer as a where a.s11 = b.s11 and a.subjectID = b.subjectID), 
                (select count(*) from Answer as a where a.s12 = b.s12 and a.subjectID = b.subjectID), 
                (select count(*) from Answer as a where a.s13 = b.s13 and a.subjectID = b.subjectID), 
                (select count(*) from Answer as a where a.s14 = b.s14 and a.subjectID = b.subjectID), 
                (select count(*) from Answer as a where a.s15 = b.s15 and a.subjectID = b.subjectID), 
                (select count(*) from Answer as a where a.s16 = b.s16 and a.subjectID = b.subjectID), 
                (select count(*) from Answer as a where a.s17 = b.s17 and a.subjectID = b.subjectID), 
                (select count(*) from Answer as a where a.s18 = b.s18 and a.subjectID = b.subjectID), 
                (select count(*) from Answer as a where a.s19 = b.s19 and a.subjectID = b.subjectID), 
                (select count(*) from Answer as a where a.s20 = b.s20 and a.subjectID = b.subjectID),
                (	#Testing 테이블의 과목과 Answer 테이블에서의 과목이 같고 Testing 테이블의 답안과 Answer 테이블에서의 정답이 같은 데이터를 추려 데이터의 수를 계산
					(select count(*) from Answer as a where a.s1 = b.s1 and a.subjectID = b.subjectID) + #s1 ~ s20까지 까지의 합을 구하는 과정
					(select count(*) from Answer as a where a.s2 = b.s2 and a.subjectID = b.subjectID) + #정답의 수 * 5 = 점수
					(select count(*) from Answer as a where a.s3 = b.s3 and a.subjectID = b.subjectID) + 
					(select count(*) from Answer as a where a.s4 = b.s4 and a.subjectID = b.subjectID) + 
					(select count(*) from Answer as a where a.s5 = b.s5 and a.subjectID = b.subjectID) + 
					(select count(*) from Answer as a where a.s6 = b.s6 and a.subjectID = b.subjectID) + 
					(select count(*) from Answer as a where a.s7 = b.s7 and a.subjectID = b.subjectID) +
					(select count(*) from Answer as a where a.s8 = b.s8 and a.subjectID = b.subjectID) +
					(select count(*) from Answer as a where a.s9 = b.s9 and a.subjectID = b.subjectID) +
					(select count(*) from Answer as a where a.s10 = b.s10 and a.subjectID = b.subjectID) +
					(select count(*) from Answer as a where a.s11 = b.s11 and a.subjectID = b.subjectID) +
					(select count(*) from Answer as a where a.s12 = b.s12 and a.subjectID = b.subjectID) +
					(select count(*) from Answer as a where a.s13 = b.s13 and a.subjectID = b.subjectID) +
					(select count(*) from Answer as a where a.s14 = b.s14 and a.subjectID = b.subjectID) +
					(select count(*) from Answer as a where a.s15 = b.s15 and a.subjectID = b.subjectID) +
					(select count(*) from Answer as a where a.s16 = b.s16 and a.subjectID = b.subjectID) +
					(select count(*) from Answer as a where a.s17 = b.s17 and a.subjectID = b.subjectID) +
					(select count(*) from Answer as a where a.s18 = b.s18 and a.subjectID = b.subjectID) +
					(select count(*) from Answer as a where a.s19 = b.s19 and a.subjectID = b.subjectID) +
					(select count(*) from Answer as a where a.s20 = b.s20 and a.subjectID = b.subjectID)
                )*5
	from Testing as b;

#홍길1의 점수 및 답안을 확인
select * from Scoring where stu_name = '홍길1';
select * from Testing where stu_name = '홍길1';
select * from Answer;


#리프토 테이블에 데이터 입력
use kopoctc;
insert into Reporttable (stu_name, stu_id, kor, eng, mat) #(괄호 안에 컬럼명을 입력하지 않아도 됨)
	select distinct b.stu_name, b.stu_id, #distinct 로 중복되는 이름과 학번을 건너뜀
    #Scoring a,b로 원하는 점수 입력, 과목번호가 동일하고 학번이 동일할 경우 해당 열의 score(b)를 kor, eng, mat으로 입력
    (select a.score from Scoring as a where a.stu_id = b.stu_id and a.subjectID = 1000) as kor,
    (select score from Scoring as a where a.stu_id = b.stu_id and a.subjectID = 2000) as eng,
    (select score from Scoring as a where a.stu_id = b.stu_id and a.subjectID = 3000) as mat
from Scoring as b;

#Reporttable 테이블의 모든 데이터 선택, 국영수 합계, 평균, 등수를 계산하여 출력
select *, kor+eng+mat as sum, (kor+eng+mat) / 3 as ave, 
	(select count(*) + 1 from Reporttable as b where (a.kor+a.eng+a.mat) < (b.kor+b.eng+b.mat)) 
    as ranking from Reporttable as a order by ranking;


#득점자 수와 비율에 대한 정보를 출력
#득점자수 
drop procedure if exists create_score_list;	#기존의 프로시저 삭제
DELIMITER $$
# 득점률 계산 프시저 생성
create procedure create_score_list()
begin
#변수 선언
declare _cnt_sub int;
#동일명의 테이블이 존재한다면 삭제
drop table if exists score_list;
#score_list table 생성(과목코드, 문제번호, 정답자 수, 정답률 항목을 구성)
create table score_list (
	subjectID int,
    q_number varchar(10),
    solution_num int,
    correct_rate double);
#과목번호를 바꿔줄 변수에 0 입력
set _cnt_sub=0;
	#루프선언
	_loop2: loop
	 set _cnt_sub=_cnt_sub+1000;	#과목번호변수에 1증가
		# score_list에 입력(insert select문), 과목번호를 기준으로 과목번호, 문제번호, 정답자수, 정답률 입력, scoring테이블에서 과목번호가 똑같고 문제를 맞춘(1)의 경우 1증가
		insert into score_list select subjectID, 's1', count(*), count(*)/10 from Scoring where subjectID = _cnt_sub and s1 = 1 group by subjectID;
		insert into score_list select subjectID, 's2', count(*), count(*)/10 from Scoring where subjectID = _cnt_sub and s2 = 1 group by subjectID;
		insert into score_list select subjectID, 's3', count(*), count(*)/10 from Scoring where subjectID = _cnt_sub and s3 = 1 group by subjectID;
		insert into score_list select subjectID, 's4', count(*), count(*)/10 from Scoring where subjectID = _cnt_sub and s4 = 1 group by subjectID;
        insert into score_list select subjectID, 's5', count(*), count(*)/10 from Scoring where subjectID = _cnt_sub and s5 = 1 group by subjectID;
		insert into score_list select subjectID, 's6', count(*), count(*)/10 from Scoring where subjectID = _cnt_sub and s6 = 1 group by subjectID;
        insert into score_list select subjectID, 's7', count(*), count(*)/10 from Scoring where subjectID = _cnt_sub and s7 = 1 group by subjectID;
		insert into score_list select subjectID, 's8', count(*), count(*)/10 from Scoring where subjectID = _cnt_sub and s8 = 1 group by subjectID;
        insert into score_list select subjectID, 's9', count(*), count(*)/10 from Scoring where subjectID = _cnt_sub and s9 = 1 group by subjectID;
		insert into score_list select subjectID, 's10', count(*), count(*)/10 from Scoring where subjectID = _cnt_sub and s10 = 1 group by subjectID;
        insert into score_list select subjectID, 's11', count(*), count(*)/10 from Scoring where subjectID = _cnt_sub and s11 = 1 group by subjectID;
		insert into score_list select subjectID, 's12', count(*), count(*)/10 from Scoring where subjectID = _cnt_sub and s12 = 1 group by subjectID;
        insert into score_list select subjectID, 's13', count(*), count(*)/10 from Scoring where subjectID = _cnt_sub and s13 = 1 group by subjectID;
		insert into score_list select subjectID, 's14', count(*), count(*)/10 from Scoring where subjectID = _cnt_sub and s14 = 1 group by subjectID;
        insert into score_list select subjectID, 's15', count(*), count(*)/10 from Scoring where subjectID = _cnt_sub and s15 = 1 group by subjectID;
		insert into score_list select subjectID, 's16', count(*), count(*)/10 from Scoring where subjectID = _cnt_sub and s16 = 1 group by subjectID;
        insert into score_list select subjectID, 's17', count(*), count(*)/10 from Scoring where subjectID = _cnt_sub and s17 = 1 group by subjectID;
		insert into score_list select subjectID, 's18', count(*), count(*)/10 from Scoring where subjectID = _cnt_sub and s18 = 1 group by subjectID;
        insert into score_list select subjectID, 's19', count(*), count(*)/10 from Scoring where subjectID = _cnt_sub and s19 = 1 group by subjectID;
		insert into score_list select subjectID, 's20', count(*), count(*)/10 from Scoring where subjectID = _cnt_sub and s20 = 1 group by subjectID;
        
        #과목 코드는 각각 1000, 2000, 3000 이므로 수학 점수에 대한 분석까지 마치면 종료
		if _cnt_sub = 3000 then
			leave _loop2;
		end if;
	end loop _loop2;
#이후 입력받은 결과를 출력 (subjectID = 과목, q_number = 문제, solution_num = 득점자, correct_rate = 득점자 비율)
select subjectID as 과목, q_number as 문제, solution_num as 득점자, correct_rate as 득점률 from score_list ;
end $$
call create_score_list();	#프로시저 실행


#리조트
#reservation table
drop table reservation;	#기존의 reservation 테이블 삭제
#새 테이블 생성, 이름, 예약날짜, 방, 주소, 전화번호, 송금인, 메모, 송금날짜
create table reservation ( 
	name varchar(10),
    reserve_date date,
    room int,
    addr varchar(100),
    tel varchar(20),
    ipgum_name varchar(10),
    memo varchar(100),
    input_date date);
#reservation 테이블에 예약자, 예약날짜, 방번호, 주소, 전화번호, 송금인, 메모사항, 송금날짜(오늘을 기준으로) 데이터를 입력
insert into reservation values ("채영","2022-05-19",1,"서울","010-0101-0101","정연","따뜻한방 주세요",DATE_FORMAT(NOW(),'%Y-%m-%d'));
insert into reservation values ("모모","2022-05-20",1,"서울","010-0101-0101","모모","따뜻한방 주세요",DATE_FORMAT(NOW(),'%Y-%m-%d'));
insert into reservation values ("지효","2022-05-21",1,"서울","010-0101-0101","모모","따뜻한방 주세요",DATE_FORMAT(NOW(),'%Y-%m-%d'));
insert into reservation values ("정연","2022-05-22",1,"서울","010-0101-0101","채영","따뜻한방 주세요",DATE_FORMAT(NOW(),'%Y-%m-%d'));
insert into reservation values ("정연","2022-05-23",2,"서울","010-0101-0101","정연","따뜻한방 주세요",DATE_FORMAT(NOW(),'%Y-%m-%d'));
insert into reservation values ("모모","2022-05-24",1,"서울","010-0101-0101","모모","따뜻한방 주세요",DATE_FORMAT(NOW(),'%Y-%m-%d'));
insert into reservation values ("사나","2022-05-25",1,"서울","010-0101-0101","사나","따뜻한방 주세요",DATE_FORMAT(NOW(),'%Y-%m-%d'));
insert into reservation values ("모모","2022-05-26",1,"서울","010-0101-0101","지효","따뜻한방 주세요",DATE_FORMAT(NOW(),'%Y-%m-%d'));
insert into reservation values ("나연","2022-05-27",1,"서울","010-0101-0101","나연","따뜻한방 주세요",DATE_FORMAT(NOW(),'%Y-%m-%d'));
insert into reservation values ("나연","2022-05-28",1,"서울","010-0101-0101","나연","따뜻한방 주세요",DATE_FORMAT(NOW(),'%Y-%m-%d'));
insert into reservation values ("모모","2022-05-29",1,"서울","010-0101-0101","모모","따뜻한방 주세요",DATE_FORMAT(NOW(),'%Y-%m-%d'));
insert into reservation values ("사나","2022-05-30",1,"서울","010-0101-0101","사나","따뜻한방 주세요",DATE_FORMAT(NOW(),'%Y-%m-%d'));
insert into reservation values ("지효","2022-05-31",1,"서울","010-0101-0101","지효","따뜻한방 주세요",DATE_FORMAT(NOW(),'%Y-%m-%d'));
insert into reservation values ("나연","2022-06-01",1,"서울","010-0101-0101","나연","따뜻한방 주세요",DATE_FORMAT(NOW(),'%Y-%m-%d'));
insert into reservation values ("정연","2022-06-01",2,"서울","010-0101-0101","정연","따뜻한방 주세요",DATE_FORMAT(NOW(),'%Y-%m-%d'));
insert into reservation values ("모모","2022-06-01",3,"서울","010-0101-0101","모모","따뜻한방 주세요",DATE_FORMAT(NOW(),'%Y-%m-%d'));
insert into reservation values ("사나","2022-06-02",1,"서울","010-0101-0101","사나","따뜻한방 주세요",DATE_FORMAT(NOW(),'%Y-%m-%d'));
insert into reservation values ("나연","2022-06-03",1,"서울","010-0101-0101","나연","따뜻한방 주세요",DATE_FORMAT(NOW(),'%Y-%m-%d'));
insert into reservation values ("모모","2022-06-04",1,"서울","010-0101-0101","모모","따뜻한방 주세요",DATE_FORMAT(NOW(),'%Y-%m-%d'));
insert into reservation values ("사나","2022-06-05",1,"서울","010-0101-0101","사나","따뜻한방 주세요",DATE_FORMAT(NOW(),'%Y-%m-%d'));
insert into reservation values ("나연","2022-06-06",1,"서울","010-0101-0101","나연","따뜻한방 주세요",DATE_FORMAT(NOW(),'%Y-%m-%d'));
insert into reservation values ("모모","2022-05-07",2,"서울","010-0101-0101","모모","따뜻한방 주세요",DATE_FORMAT(NOW(),'%Y-%m-%d'));
insert into reservation values ("다현","2022-05-08",2,"서울","010-0101-0101","다현","따뜻한방 주세요",DATE_FORMAT(NOW(),'%Y-%m-%d'));
insert into reservation values ("지효","2022-06-09",2,"서울","010-0101-0101","지효","따뜻한방 주세요",DATE_FORMAT(NOW(),'%Y-%m-%d'));
insert into reservation values ("지효","2022-06-03",2,"서울","010-0101-0101","지효","따뜻한방 주세요",DATE_FORMAT(NOW(),'%Y-%m-%d'));
insert into reservation values ("지효","2022-06-03",3,"서울","010-0101-0101","지효","따뜻한방 주세요",DATE_FORMAT(NOW(),'%Y-%m-%d'));
insert into reservation values ("지효","2022-06-04",3,"서울","010-0101-0101","지효","따뜻한방 주세요",DATE_FORMAT(NOW(),'%Y-%m-%d'));

#1달간 예약보기 위한 프로시저
drop procedure if exists resvstat_calc;	#기존의 동일명 프로시저 삭제
delimiter $$
# 프로시저 선언
create procedure resvstat_calc()
begin
	#변수 선언, 날짜, 방 1 2 3 선언
	declare _date date;
    declare _cnt integer;
    declare _room1 varchar(20);
    declare _room2 varchar(20);
    declare _room3 varchar(20);
    # now()의 포멧변경(yy-mm-dd)
	set _date = date_format(now(),'%Y-%m-%d');
    set _cnt = -1; #오늘부터 카운딩할거라 -1
	####################################################################
    drop table if  exists reserv_stat;	#기존의 동일명 테이블 삭제
    # 결과 테이블 생성, 프라이머리키로 입실날짜 지정
    create table reserv_stat(
		reserve_date date not null,
        room1 varchar(20),
        room2 varchar(20),
        room3 varchar(20),
		primary key(reserve_date)
        );
	####################################################################
    #테이블을 돌면서 날짜가 똑같고 room 넘버가 동일하면 이름을 입력해라.
	_loop: LOOP	#루프선언
    set _cnt = _cnt+1;	#날짜 하루 증가
	#값입력, reserv_stat(reserve_date, room1, room2, room3) 값에 예약날짜, 예약가능 여부 및 신청인원 입력
         insert into reserv_stat (reserve_date, room1, room2, room3)
         #date_add를 활용하여 interval _cnt 만큼의 일자를 추가
         select distinct (date_add(_date, interval _cnt day)), #예약날짜 목록을 입력
			#reservation(a)의 name을 출력한다. 
            #reservation(a) 테이블에서 해당 날짜로 등록된 이름이 없으면, 예약가능 이란 문장을 입력
            (select ifnull((select a.name from reservation as a where a.reserve_date = (date_add(_date, interval _cnt day)) and a.room =1), '예약가능')),
            (select ifnull((select a.name from reservation as a where a.reserve_date = (date_add(_date, interval _cnt day)) and a.room =2), '예약가능')),
            (select ifnull((select a.name from reservation as a where a.reserve_date = (date_add(_date, interval _cnt day)) and a.room =3), '예약가능'))
         from reservation;
		#현재부터 31일 이후의 예약내역을 보여주고 정지하는 if문
		if _cnt = 31 then
            leave _loop;
         end if;
        end loop _loop;
	####################################################################
    select * from reserv_stat;	#해당 결과테이블 생성
end $$
delimiter ;
#함수실행
call resvstat_calc();