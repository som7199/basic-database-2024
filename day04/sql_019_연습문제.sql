-- 3-1. 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객의 이름
SELECT DISTINCT custid
  FROM Orders
 WHERE bookid IN (
SELECT bookid
  FROM Book
 WHERE publisher IN (SELECT b.publisher
                       FROM Customer AS c, Orders AS o, Book AS b
                      WHERE c.custid = o.custid
                        AND b.bookid = o.bookid
                        AND c.[name] = '박지성'));

-- 3-2. 두 개 이상의 서로 다른 출판사에서 도서를 구매한 고객의 이름

-- 3-3. 전체 고객의 30% 이상이 구매한 도서
SELECT b.bookname, COUNT(b.bookname)
FROM ORDERS O, BOOK B
WHERE o.bookid = b.bookid
GROUP BY b.bookname
HAVING COUNT(b.bookname) >= (
                            SELECT (COUNT(*) * 0.3)
                            FROM customer
                            );

-- 이건 도서가 아니라 고객 아이디..
SELECT b.custid
    , CONVERT(float, b.custCount) / b.totalCount
  FROM (SELECT custid
          , COUNT(custid) AS custCount
          , (SELECT COUNT(custid) FROM Orders) AS totalCount
        FROM Orders
       GROUP BY custid) AS b
 WHERE CONVERT(float, b.custCount) / b.totalCount >= 0.3;


-- 4-1. 새로운 도서('스포츠 세계', '대한미디어', 10000원)가 마당서점에 입고되었다. 삽입이 안 될 때 필요한 데이터가 더 있는지 찾아보시오.
SELECT *
  FROM Book;

-- 열 'bookid'에 NULL 값을 삽입할 수 없습니다. 
-- 열에는 NULL을 사용할 수 없습니다. 
-- INSERT이(가) 실패했습니다.
/*
INSERT INTO Book(bookname, publisher, price)
    VALUES ('스포츠 세계', '대한미디어', 10000);
*/

INSERT INTO Book(bookid, bookname, publisher, price)
    VALUES (15, '스포츠 세계', '대한미디어', 10000);

SELECT *
  FROM Book;

-- 4-2. '삼성당'에서 출판한 도서를 삭제하시오.
SELECT *
  FROM Book;

DELETE FROM Book
 WHERE publisher = '삼성당'

SELECT *
  FROM Book;

-- 4-3. '이상미디어'에서 출판한 도서를 삭제하시오. 삭제가 안 되면 원인을 생각해보시오.
-- 참조 제약조건에 걸리기 때문에 삭제 불가.
-- 삭제하려면 
-- 데이터베이스 "Madang", 테이블 "dbo.Orders", column 'bookid'에서 충돌이 발생했습니다.
-- Orders 테이블에서 Book.bookid 속성을 외래키로 참조하고 있기 때문에
-- 제약이 해제되지 않으면 데이터 삭제가 중지된다.
DELETE FROM Book
 WHERE publisher = '이상미디어'

SELECT *
  FROM Book;

-- 4-4. 출판사 '대한미디어'를 '대한출판사'로 이름을 바꾸시오.
SELECT *
  FROM Book;

UPDATE Book
   SET publisher = '대한출판사'
 WHERE publisher = '대한미디어';

SELECT *
  FROM Book;

UPDATE Book
   SET publisher = '대한출판사'
 WHERE bookid IN (SELECT bookid
                    FROM Book
                   WHERE publisher = '대한미디어')