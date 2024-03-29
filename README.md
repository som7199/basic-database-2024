# basic-database-2024
IoT 개발자 과정 SQL Server 학습 리포지토리

## 1일차
- MS SQL Server 설치 : https://www.microsoft.com/ko-kr/sql-server/sql-server-downloads 최신버전
    - DBMS 엔진 - 개발자 버전
        - 미디어 다운로드, ISO 패키지 선택해서 다운로드!
        - ISO 다운로드 후 설치 추천
        - SQL Server에 대한 Azure 확장 비활성화 후 진행

        ![기능선택](https://raw.githubusercontent.com/som7199/basic-database-2024/main/images/db001.png)

        - 데이터베이스 엔진 구성부터 중요
            - Windows 인증 모드로 하면 외부에서 접근 불가
            - 혼합모드(sa)에 대한 암호를 지정 / mssql_p@ss(8자 이상 / 대소문자구분 / 특수문자1자이상 포함)
            - 데이터루트 디렉토리는 변경 => C:\Datas
    - [개발 툴 설치](https://learn.microsoft.com/ko-kr/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16)
        - SSMS(SQL Server Management Studio) : DB에 접근, 여러 개발 작업할 툴
        - SSMS 설치 : https://learn.microsoft.com/ko-kr/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16 한국어 버전 설치
    
- 데이터베이스 개념
    - 통합된 데이터: 데이터를 통합하는 개념. 각자 사용하던 데이터의 중복을 최소화하여 중복으로 인한 데이터 불일치 제거
    - 저장된 데이터: 문서로 보관된 데이터가 아니라 컴퓨터 저장장치에 저장된 데이터
    - 운영 데이터: 조직의 목적을 위해 사용되는 데이터. 즉, 업무를 위한 검색을 목적으로 저장됨
    - 공용 데이터: 한 사람 또는 한 업무를 위해 사용되는 데이터가 아니라 공동으로 사용되는 데이터를 의미

- 데이터베이스 기초
    - 데이터를 보관, 관리, 서비스하는 시스템
    - Data, Information, Knowledge 개념
    - DBMS > Database > Data(Model)

- 데이터 모델(Data Model) 
    - 계층 데이터 모델(hierarchical data model)
    - 네트워크 데이터 모델(network data model)관계 데이터 모델(relation data model)객체 데이터 모델(object data model)객체-관계 데이터 모델(object-relational data model)

- 데이터베이스 시스템의 구성
        - DBMS: 사용자와 데이터베이스를 연결시켜주는 소프트웨어
        - 데이터베이스: 데이터를 모아둔 토대
        - 데이터 모델: 데이터가 저장되는 기법에 관한 내용

- DB언어
    - SQL(Structured Query Language) : 구조화된 질의 언어
        - DDL (Data Definition Language) - 데이터베이스, 테이블, 인덱스 생성
            - CREATE : 데이터베이스 및 객체 생성
            - DROP : 데이터베이스 및 객체 삭제
            - ALTER : 기존에 존재하는 데이터베이스 객체를 변경

        - DML (Data Manipulation Language) - 검색(SELECT), 삽입(INSERT), 수정(UPDATE), 삭제(DELETE) 등 기능(중요!)
            - INSERT (삽입) : 데이터베이스 객체에 데이터 입력
            - DELETE (삭제) : 데이터베이스 객체에 데이터 삭제
            - UPDATE (수정) : 기존에 존재하는 데이터베이스 객체안의 데이터 수정
            - SELECT (검색) : 데이터베이스 객체로부터 데이터 검색
                - SELECT문은 특별히 질의어(query)라고 함
        
        - DCL (Data Control Language) - 권한, 트랜스액션 부여/제거 기능
            - GRANT : 데이터베이스 객체에 권한 부여
            - REVOKE : 이미 부여된 데이터베이스 객체의 권한 취소

        - TCL (Transaction Control Language) - 트랜스액션(트랜잭션) 제어하는 기능, 원래는 DCL의 일부, 기능이 특이해서 TCL로 분리!
            - COMMIT : 변경된 데이터를 테이블에 영구적으로 반영, 즉, 모든 작업을 정상적으로 처리하겠다고 확정하는 명령어
            - ROLLBACK : 트랜잭션(INSERT, UPDATE, DELETE) 작업 내용을 취소, 이전 COMMIT 한 곳 까지만 복구

- 데이터베이스의 개념적 구조
    - 외부 스키마 = 일반 사용자나 응용 프로그래머가 접근하는 계층
        - 전체 데이터메이스 중에서 하나의 논리적인 부분을 의미
    - 개념 스키마 = 전체 데이터베이스의 정의를 의미
    - 내부 스키마 = 물리적 저장 장치에 데이터베이스가 실제로 저장되는 방법의 표현

- SQL 기본 학습
    - SSMS 실행

    ![SSMS로그인](https://raw.githubusercontent.com/som7199/basic-database-2024/main/images/db002.png)

    - 특이사항 - SSMS 쿼리창에서 소스코드 작성 시 빨간색 오류 밑줄이 가끔 표현(전부 오류는 아님)

- DML 학습
    - SQL 명령어 키워드 : SELECT, INSERT, UPDATE, DELETE
    - IT개발 표현 언어 : Request, Create, Update, Delete(CRUD로 부름, CRU개발 뜻은 INSERT, UPDATE, SELECT를 할 수 있는 기능을 개발하라)
    - SELECT
        ```sql
        SELECT [ALL | DISTINCT] 속성이름(들)
          FROM 테이블이름(들)
        [WHERE 검색조건(들)]
        [GROUP BY 속성이름(들)]
        [HAVING 검색조건(들)]
        [ORDER BY 속성이름(들) [ASC|DESC]]
        ```
    - SELECT문 학습
        - 기본, 조건검색 학습 중

## 2일차
- Database 학습
    - DB 개발 시 사용할 수 있는 툴
        - SSMS(기본)
        - Visual Studio - 아무런 설치 없이 개발 가능
        - Visual Studio Code - SQL Server(mssql) 플러그인 설치하고 개발
    - ServerName(HostName) - [내 컴퓨터 이름|내 네트워크 주소|127.0.0.1(LoopBack IP)|localhost(LoopBack URL)] 중 선호하는 것 아무거나 쓰면 됨!
    - 관계 데이터 모델
        - 릴레이션 - 행과 열로 구성된 테이블(관계 데이터 모델에서만)
            - 행(튜플), 열(속성), 스키마, 인스턴스 용어
        - 매핑되는 이름 테이블 (실제 DB에선 릴레이션이 아닌 테이블이라고 부름)
            - 행(레코드), 열(컬럼, 필드), 내포(필드명), 외연(데이터)
        - 차수(degree) - 속성의 개수
        - 카디날리티(cardinality) - 튜플의 수

        - 릴레이션 특징
            1. 속성은 단일값을 가짐(책 이름이 여러 개 들어가면 안 됨)
            2. 속성은 다른 이름으로 구성(책 이름이라는 속성이 두 번 있으면 안 됨)
            3. 속성의 값은 정의된 도메인값만 가짐(대학교 학년에 5학년이 있으면 안 됨)
            4. 속성의 순서는 상관없음
            5. 릴레이션 내 중복된 튜플 허용 안 함(같은 책 정보를 두 번 넣을 수 없음)
            6. 튜플 순서는 상관없음
        
        - 관계 데이터 모델은 아래의 요소로 구성됨
            - 릴레이션(Relation)
            - 제약조건(Constraints)
            - 관계대수(Relational algebra)

- DML 학습
    - SELECT문
        - 복합조건, 정렬
        - 집계함수와 Group By
            - SUM(총합), AVG(평균), COUNT(개수), MIN(최소), MAX(최대)
            - 집계함수 외 일반 컬럼은 GROUP BY 절에 속한 컬럼만 SELECT문에 사용 가능
            - HAVING은 집계함수의 필터로 GROUP BY 뒤에 작성, WHERE절과 필터링이 다르다.
        
        - 두 개 이상의 테이블 질의(Query)
            - 관계형 DB에서 가장 중요한 기법 중 하나 : JOIN!
            - INNER JOIN(내부 조인) [참조](https://sql-joins.leopard.in.ua/)
            - LEFT|RIGHT OUTER JOIN(외부 조인) - 어느 테이블이 기준인지에 따라서 결과가 상이함

        ![외부조인](https://raw.githubusercontent.com/som7199/basic-database-2024/main/images/db004.png)