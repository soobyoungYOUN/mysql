-- p4
use kopoctc; #kopoctc 데이터 베이스 선택
drop table if exists c3_examtable;  #kopoctc 데이터베이스에 c3_examtable가 존재하면 삭제
									#똑같은 테이블 이름을 사용할 수 없기 때문에 이를 습관화 하자
create table c3_examtable( #c3_examtable 테이블 생성
	name varchar(20), #테이블의 행과, 각 행이 입력받을 데이터 형식을 설정
    id int not null primary key,
    kor int, eng int, mat int); #테이블은 총 5열로 구성
desc c3_examtable; #테이블에 대한 설명을 출력

-- p5
delete from c3_examtable where id > 0;  #c3_examtable의 id 값이 0보다 큰 행은 모두 제거
										#데이터 중복 방지
#c3_examtable 테이블에 데이터 값을 입력 / [이름, 학번, 국어, 영어, 수학] 순서로 입력
insert into c3_examtable value ("나연", 209901, rand() *100, rand() *100, rand() *100);  
insert into c3_examtable value ("정연", 209902, rand() *100, rand() *100, rand() *100);
insert into c3_examtable value ("모모", 209903, rand() *100, rand() *100, rand() *100);
insert into c3_examtable value ("사나", 209904, rand() *100, rand() *100, rand() *100);
insert into c3_examtable value ("지효", 209905, rand() *100, rand() *100, rand() *100);
insert into c3_examtable value ("미나", 209906, rand() *100, rand() *100, rand() *100);
insert into c3_examtable value ("다현", 209907, rand() *100, rand() *100, rand() *100);
insert into c3_examtable value ("채영", 209908, rand() *100, rand() *100, rand() *100);
insert into c3_examtable value ("쯔위", 209909, rand() *100, rand() *100, rand() *100);
insert into c3_examtable value ("송가인", 209910, rand() *100, rand() *100, rand() *100);
insert into c3_examtable value ("나연", 209911, rand() *100, rand() *100, rand() *100);
insert into c3_examtable value ("정연", 209912, rand() *100, rand() *100, rand() *100);
insert into c3_examtable value ("모모", 209913, rand() *100, rand() *100, rand() *100);
insert into c3_examtable value ("사나", 209914, rand() *100, rand() *100, rand() *100);
insert into c3_examtable value ("지효", 209915, rand() *100, rand() *100, rand() *100);
insert into c3_examtable value ("미나", 209916, rand() *100, rand() *100, rand() *100);
insert into c3_examtable value ("다현", 209917, rand() *100, rand() *100, rand() *100);
insert into c3_examtable value ("채영", 209918, rand() *100, rand() *100, rand() *100);
insert into c3_examtable value ("쯔위", 209919, rand() *100, rand() *100, rand() *100);
insert into c3_examtable value ("송가인", 209920, rand() *100, rand() *100, rand() *100);

select * from c3_examtable;				#c3_examtable 테이블의 모든 값을 출력
select * from c3_examtable order by kor;#c3_examtable 테이블의 모든 값을 출력 + 국어점수 오름차순 정렬
select * from c3_examtable order by eng;#c3_examtable 테이블의 모든 값을 출력 + 영어점수 오름차순 정렬
select * from c3_examtable order by kor, eng;#테이블의 모든 값을 출력하고 국어점수 오름차순 정렬
											 #국어점수가 앞에 있어서 영어점수 기준의 정렬은 무시됨
select * from c3_examtable order by kor asc; #국어 기준 오름차순 정렬, orderby의 기본은 오름차순 정렬
select * from c3_examtable order by kor desc;#데이터를 출력할 때, 내림차순 정렬할 때 사용함

select * from c3_examtable order by name desc;#한글 기준 역순 정렬 출력

select * from c3_examtable order by mat desc;#수학점수 역순 정렬 출력

# 테이블의 모든 값, 총점, 평균을 구하는 명령
select *, kor + eng + mat as 총점, (kor + eng + mat) /3 as 평균 from c3_examtable;

#from : 해당 테이블의 데이터를 가지고 온다
#select * : 테이블의 모든 값을 출력한다
#select *, 식1, 식2 : 테이블의 모든 값 및 식1의 값, 식2의 값을 출력한다
select *, kor + eng + mat, (kor + eng + mat) /3 from c3_examtable;

#총점을 기준으로 테이블의 값, 총점, 평균을 정렬 출력
#order by는 마지막, 총점의 오름차순 정렬
select *, kor + eng + mat, (kor + eng + mat) /3 from c3_examtable order by kor + eng + mat;

#총점을 기준으로 테이블의 값, 총점, 평균을 정렬 출력
#order by는 마지막, 총점의 오름차순 정렬
#as로 별칭 주기, total, average
#desc 내림차순 정렬
select *, kor + eng + mat as total, (kor + eng + mat) /3 as average
	from c3_examtable order by total desc;

#총점을 기준으로 테이블의 값, 총점, 평균을 정렬 출력
#order by는 마지막, 총점의 오름차순 정렬
#as로 별칭 주기, total, average
#desc 내림차순 정렬
select name as 이름, id as 학번, kor as 국어, eng as 영어, mat as 수학, 
	kor + eng + mat as 총점, (kor + eng + mat) /3 as 평균
	from c3_examtable order by 총점 desc;
    
select * from c3_examtable group by name; #에러 발생, 같은 이름에 다른 점수로 인해 그룹형성 불가
#이름을 기준으로 그룹 형성
#count(name) 동일한 이름값이 몇 개인지 확인 가능, group by name 이 없다면 이용 불가
select name, count(name) from c3_examtable group by name;

#국어점수를 그룹화 하므로 같은 국어 점수가 몇 개인지 확인
#에러발생, 테이블의 모든 값을 출력한다는 명령과 국어점수의 그룹화가 충돌하여 명령 실행불가
select * from c3_examtable group by kor;

#국어점수를 그룹화 하므로 같은 국어 점수가 몇 개인지 확인
#국어점수의 값을 그룹으로 형성하고, 그룹화된 국어점수와 그 개수를 출력
select kor, count(kor) from c3_examtable group by kor;

#영어점수를 그룹화 하고 국어 점수가 몇 개인지 확인
#영어점수의 값을 그룹으로 형성하고, 국어점수와 그 개수를 출력
#당연히 에러발생
select kor, count(kor) from c3_examtable group by eng;

#영어점수를 그룹화 하므로 같은 영어 점수가 몇 개인지 확인
#영어점수의 값을 그룹으로 형성하고, 그룹화된 영어점수와 그 개수를 출력
select eng, count(eng) from c3_examtable group by eng;

#국어점수를 그룹화 하므로 같은 국어 점수가 몇 개인지 확인
#국어점수의 값을 그룹으로 형성하고, 그룹화된 국어점수와 그 개수를 출력
#영어점수를 그룹화 하므로 같은 영어 점수가 몇 개인지 확인
#영어점수의 값을 그룹으로 형성하고, 그룹화된 영어점수와 그 개수를 출력
#두개의 열이 그룹화 되었으므로 두 그룹의 분포를 출력가능하게 됨
select kor, count(kor), eng, count(eng) from c3_examtable group by kor, eng;

#학번이 다른 팽수 데이터를 두번입력, 국어, 영어는 고정, 수학은 무작위 생성
insert into c3_examtable value ("팽수", 209921, 100, 90, rand() * 100);
insert into c3_examtable value ("팽수", 209922, 100, 90, rand() * 100);

#국어, 영어로 그룹화 하여 국어와 영어의 점수 분포 확인
select kor, count(kor), eng, count(eng) from c3_examtable group by kor, eng;

#이름, 국어, 영어 데이터 그룹화, 값의 분포 출력
#그룹화 된 세 가지의 값이 모두 동일해야 하나의 분포로 인정된다.
select name, count(name), kor, count(kor), eng, count(eng) 
	from c3_examtable group by name, kor, eng;


#테이블의 모든 값, 이름, 국어, 영어 데이터 그룹화, 값의 분포 출력
#그룹화 된 세 가지의 값이 모두 동일해야 하나의 분포로 인정된다.
#모든 값출력 vs group by의 충돌로 에러 발생
select *, name, count(name), kor, count(kor), eng, count(eng) 
	from c3_examtable group by name, kor, eng;

#영어점수 그룹을 출력 + 동일한 값이 2이상인 값만 골라서 출력하도록 하는 having    
select eng, count(eng) from c3_examtable group by eng having count(eng) > 1;

use kopoctc; #kopoctc 데이터 베이스 선택
drop table if exists c3_popularityVote; #kopoctc 데이터베이스에 popularityVote 테이블이 존재하면 삭제
create table c3_popularityVote( #popularityVote 테이블 생성
	name int, #테이블의 구성, 이름(정수형에서 문자형으로 바꿀예정), 나이
    ages int);

#해당 명과 동일한 프로시저가 존재하면 기존의 프로시저를 제거
drop procedure if exists proc_voting;
DELIMITER $$ #프로시저 선언
CREATE PROCEDURE proc_voting() #프로시저를 생성
BEGIN #시작
	DECLARE i INT DEFAULT 1; #변수 i 선언, 정수형, 기본 = 1
    WHILE (i <= 100) DO #i가 100미만인 동안 명령 실행
		INSERT INTO c3_popularityVote VALUE (RAND() * 8 + 1, RAND() * 8 + 1); 
        #랜덤 발생 정수를 두개를 popularityVote 테이블의 값으로 입력
		SET i = i + 1; #i값 누적
	END WHILE; #반복문 종료
END$$
DELIMITER ;; #프로시저 종료

CALL proc_voting(); #프로시저 실행
select * from c3_popularityVote;

#숫자로 입력된 값을 문자데이터로 변환하는 과정
#alter table 테이블명 : 해당 테이블을 수정한다
#modify name varchar(20) : 테이블의 name 컬럼의 데이터 형식을 변환
#update 테이블명 set 컬럼명 = '바꿀 값' where 컬럼명 = '컬럼 값';
alter table c3_popularityVote modify name varchar(20);
set sql_safe_updates = 0;
update c3_popularityVote set name = '나연' where name = '1';
update c3_popularityVote set name = '정연' where name = '2';
update c3_popularityVote set name = '모모' where name = '3';
update c3_popularityVote set name = '사나' where name = '4';
update c3_popularityVote set name = '지효' where name = '5';
update c3_popularityVote set name = '미나' where name = '6';
update c3_popularityVote set name = '다현' where name = '7';
update c3_popularityVote set name = '채영' where name = '8';
update c3_popularityVote set name = '쯔위' where name = '9';


#멤버별 득표수 및 득표율 출력
#이름, 득표수, 득표율을 출력, 멤버별 이름을 집계해야 하므로 group by name을 사용
#group by name을 했기 때문에 count(name)으로 이름별 집계 가능
#count(name)/ (select count(*) from c3_popularityVote) * 100 득표수를 전체 투표수로 나누어 백분율 표시
select name as 이름, count(name) as 득표수, 
	count(name)/ (select count(*) from c3_popularityVote) * 100 as 득표율 from c3_popularityVote group by name;


#나연의 득표수
#ages 값에 10씩 곱하여 연령대를 조정, 연령대펼 투표수를 출력(group by ages 로 실행)
#(select count(*) from c3_popularityVote where name = '나연') : 나연이 받은 표의 합계를 구함
#from c3_popularityVote where name = '나연' : 나연에 대한 정보만을 구함
select ages * 10 as 연령대, count(ages) as 투표수, 
	count(ages)/(select count(*) from c3_popularityVote where name = '나연') * 100 as 득표율 
	from c3_popularityVote where name = '나연' group by ages;

#정연의 득표수
#ages 값에 10씩 곱하여 연령대를 조정, 연령대펼 투표수를 출력(group by ages 로 실행)
#(select count(*) from c3_popularityVote where name = '정연') : 정연이 받은 표의 합계를 구함
#from c3_popularityVote where name = '정연' : 정연에 대한 정보만을 구함
select ages * 10 as 연령대, count(ages) as 득표수, 
	count(ages)/(select count(*) from c3_popularityVote where name = '정연') * 100 as 득표율 
	from c3_popularityVote where name = '정연' group by ages;

#득표수의 내림차순 정렬하기
#각 입력된 이름의 수를 계산하고 이를 cnt로 지칭, 이름별/전체 투표수로 멤버별 득표율 계산(group by name 실행), cnt desc를 기준으로 내림차순 정렬
select name, count(name) as cnt, count(name)/(select count(*) from c3_popularityVote) * 100 as 
	rate from c3_popularityVote group by name order by cnt desc;
    
-- p11
DROP PROCEDURE IF EXISTS get_sum; #존재하는 프로시저를 제거 하는 습관
DELIMITER $$
CREATE PROCEDURE get_sum( #프로시저 만듦
	in _id integer, #정수를 받아와서 명령을 실행
    OUT _name varchar(20), #프로시저에서 반환할 값을 지정
    OUT _sum integer #프로시저에서 반환할 값을 지정
)
BEGIN
	DECLARE _kor integer; #내부에서 사용될 변수 선언, 국어 대체
    DECLARE _eng integer; #내부에서 사용될 변수 선언, 영어 대체
    DECLARE _mat integer; #내부에서 사용될 변수 선언, 수학 대체
    set _kor=0; #로직상 의미는 없지만 declare / set으로 정의하고 값을 넣는다.
    
    #프로시저의 인수 _id와 c3_examtable의 id 값이 같은 것만
    #c3_examtable 에서 이름, 국,영, 수 점수를 선택하여 
    #_name, _kor, _eng, _mat 변수에 각각 대입 
    select name, kor, eng, mat 
		into _name, _kor, _eng, _mat from c3_examtable where id=_id;
        
	set _sum = _kor + _eng + _mat; #국,영,수 총점을 _sum 변수에 입력
END $$
DELIMITER ;

call get_sum(209901, @name, @sum); #프로시저 호출 가져올 값은 @변수명 사용
select @name, @sum; #값확인 방법

DROP FUNCTION IF EXISTS f_get_sum; #이름이 같은 함수를 제거하여 새로 생성
DELIMITER $$
#정수를 입력받아 정수를 반환하도록 함수를 생성
CREATE FUNCTION f_get_sum(_id integer) RETURNS integer 
BEGIN
	DECLARE _sum integer; #반환할 정수 변수 선언
    #from c3_examtable where id = _id : c3_examtable의 id와 인수 _id와 같은 값만
    #국,영,수 합산 점수를 _sum변수에 대입하고 
    select kor + eng + mat into _sum from c3_examtable where id = _id;
RETURN _sum; #결과 반환
END $$
DELIMITER ;

select *, f_get_sum(id) from c3_examtable; #값 확인 방법

-- p14
#c3_examtableHONG 같은 이름의 테이블이 존재하면 삭제
drop table if exists c3_examtableHONG;
create table c3_examtableHONG( #테이블 생성, name, id, kor, eng, mat을 받음
	name varchar(20),
    id int not null primary key,
    kor int, eng int, mat int);

DROP PROCEDURE IF EXISTS insert_c3_examtableHONG; #동일한 이름의 프로시저를 제거
DELIMITER $$
#프로시저 생성, 정수를 인수로 받음
CREATE PROCEDURE insert_c3_examtableHONG(_last integer) 
BEGIN	#프로시저 내부의 변수를 선언
DECLARE _name varchar(20);
DECLARE _id integer;
DECLARE _cnt integer;
SET _cnt = 0; #_cnt는 누적될 값으로 0으로 초기화 시킴
#c3_examtableHONG 테이블에 id > 0 인 값을 모두 제거
delete from c3_examtableHONG where id > 0; 
	_loop: LOOP #반복문 시작
		SET	_cnt = _cnt + 1; #cnt 누적
        #문자데이터와 숫자데이터의 문자화로 데이터 결합
        SET _name = concat("홍길", cast(_cnt as char(4))); 
        SET _id = 209900+_cnt; #학번의 증가
        
        #c3_examtableHONG 테이블에 
        #문자 + 숫자(문자형) 값을 _name에 대입
        #_id 에 209900 + _cnt 값 대입, 나머지는 랜덤 생성 점수
        INSERT INTO c3_examtableHONG value 
			(_name, _id, rand() * 100, rand() * 100, rand() * 100);
        
        #반복을 멈추는 조건문, 입력받은 인수에 _cnt 값이 도달 하면 정지
        if _cnt = _last THEN
			LEAVE _loop; #반복문을 벗어남
		END IF; #조건문을 끝냄
	END LOOP _loop; #반복문 정지 
END $$ #프로시저 종료

call insert_c3_examtableHONG(100); #프로시저 실행, 명령을 100회 반복

select * from c3_examtableHONG; #c3_examtableHONG 데이터 전부 출력
#셀렉트를 집합에서 30번째부터 59개를 출력하라
select *, kor + eng + mat as sum, (kor + eng + mat) / 3 as avg from c3_examtableHONG LIMIT 30, 59;

#c3_examtableHONG as b : c3_examtableHONG를 b라고 지칭
#b.kor + b.eng + b.mat as 합계 : b테이블의 kor, eng, mat 값의 합을 합계로 지칭
#(select count(*)+1 from c3_examtableHONG as a where (a.kor + a.eng + a.mat) > (b.kor + b.eng + b.mat)) as 등수
#=>동일한 테이블을 a라고 지칭하여, 똑같은 테이블을 열고 비교하여, 등수를 정하는 명령
#count(*)+1 : + 1을 한 이유는 큰 값들이 3개 있으면 해당 값은 4등이 되기 때문
select *,b.kor + b.eng + b.mat as 합계, (b.kor + b.eng + b.mat) /3 as 평균,
   (select count(*)+1 from c3_examtableHONG as a where (a.kor + a.eng + a.mat) > (b.kor + b.eng + b.mat)) as 등수
    from c3_examtableHONG as b;
 
-- 랭킹함수 생성 및 등수의 내림차순 정렬
DROP FUNCTION IF EXISTS f_get_ranking;
DELIMITER $$		#테이블로부터 국어, 영어, 수학 성적을 인수로 받아 등수를 정수형 데이터로 반환
CREATE FUNCTION f_get_ranking(kor integer, eng integer, mat integer) RETURNS integer
BEGIN
	DECLARE ranking integer; #함수 내부의 변수 선언
    #입력받은 인수의 합계보다 테이블의 값이 크다면 등수를 1더하여 출력, 등수의 시작은 1등이기 떄문에
	select count(*)+1 into ranking from c3_examtableHONG as a where (a.kor + a.eng + a.mat) > (kor + eng + mat);
RETURN ranking; #등수 반환
END $$
DELIMITER ;

select *, f_get_ranking(kor, eng, mat) as 랭킹 from c3_examtableHONG; #값 확인 방법
select *, f_get_ranking(kor, eng, mat) as 랭킹 from c3_examtableHONG order by 랭킹; #등수의 내림차순 정렬

-- p15
use kopoctc; #kopoctc 데이터 베이스 선택
drop table if exists c3_twiceVote; #kopoctc 데이터베이스에 C3_twiceVote가 존재하면 삭제
create table c3_twiceVote( #C3_twiceVote 테이블 생성
	name int, #테이블의 구성, 번호, 나이
    ages int);

CALL get1000people();

alter table c3_twiceVote modify name varchar(20);
set sql_safe_updates = 0;
update c3_twiceVote set name = '나연' where name = '1';
update c3_twiceVote set name = '정연' where name = '2';
update c3_twiceVote set name = '모모' where name = '3';
update c3_twiceVote set name = '사나' where name = '4';
update c3_twiceVote set name = '지효' where name = '5';
update c3_twiceVote set name = '미나' where name = '6';
update c3_twiceVote set name = '다현' where name = '7';
update c3_twiceVote set name = '채영' where name = '8';
update c3_twiceVote set name = '쯔위' where name = '9';

select * from c3_twiceVote;

select name, count(name), count(name)/ (select count(*) from c3_twiceVote) * 100 as rate from c3_twiceVote group by name;
select name, count(name) as cnt, count(name)/(select count(*) from c3_twiceVote) * 100 as rate from c3_twiceVote group by name order by cnt desc;

DROP FUNCTION IF EXISTS f_get_favorRate;
DELIMITER $$
CREATE FUNCTION f_get_favorRate() returns decimal
BEGIN
	declare favorRate decimal;
    select name, count(name), count(name)/ (select count(*) from c3_twiceVote) * 100 as rate from c3_twiceVote group by name;
RETURN favorRate;
END $$
DELIMITER ;

select count(*) from c3_twiceVote;

use kopoctc; #kopoctc 데이터 베이스 선택
drop table if exists c3_twiceVote; #kopoctc 데이터베이스에 C3_twiceVote가 존재하면 삭제
create table c3_twiceVote( #C3_twiceVote 테이블 생성
	name int, #테이블의 구성, 번호, 나이
    ages int);

#1000명 생성 프로시저 실행
CALL get1000people();

#번호로 입력된 name 값을 이름으로 변경
alter table c3_twiceVote modify name varchar(20);
set sql_safe_updates = 0;
update c3_twiceVote set name = '나연' where name = '1';
update c3_twiceVote set name = '정연' where name = '2';
update c3_twiceVote set name = '모모' where name = '3';
update c3_twiceVote set name = '사나' where name = '4';
update c3_twiceVote set name = '지효' where name = '5';
update c3_twiceVote set name = '미나' where name = '6';
update c3_twiceVote set name = '다현' where name = '7';
update c3_twiceVote set name = '채영' where name = '8';
update c3_twiceVote set name = '쯔위' where name = '9';

select * from c3_twiceVote;

select name, count(name), count(name)/ (select count(*) from c3_twiceVote) * 100 as rate from c3_twiceVote group by name;
select name, count(name) as cnt, count(name)/(select count(*) from c3_twiceVote) * 100 as rate from c3_twiceVote group by name order by cnt desc;

select count(name) from c3_twiceVote;
select count(ages)/(select count(*) from c3_twiceVote where name = '나연') * 100 as 득표율 from c3_twiceVote where name = '나연' group by ages;
select ages * 10 as 연령대, count(ages) as 득표수, count(ages)/(select count(*) from c3_twiceVote where name = '나연') * 100 as 득표율 from c3_twiceVote where name = '나연' group by ages;
select ages * 10 as 연령대, count(ages) as 득표수, count(ages)/(select count(*) from c3_twiceVote where name = '나연') * 100 as 득표율 from c3_twiceVote where name = '나연' group by ages;

-- 선호도 조사 함수 original
DROP FUNCTION IF EXISTS f_get_favorRate;
DELIMITER $$
CREATE FUNCTION f_get_favorRate(_name varchar(20)) returns float
BEGIN
	declare favorRate float;
    select count(name) / (select count(*) from c3_twiceVote) * 100 into favorRate from c3_twiceVote where name = _name group by name;
RETURN favorRate;
END $$
DELIMITER ;

select name as 이름, count(name) as 득표수, f_get_favorRate(name) as rate from c3_twiceVote group by name;

-- ***************성적표 집계
drop table if exists c3_examtableHONG1000;
create table c3_examtableHONG1000(
	name varchar(10),
    id int,
    kor int,
    eng int,
    mat int);

call insert_c3_examtableHONG1000(1000);
    
CALL print_report(5, 25); #프로시저 실행