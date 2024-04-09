-- 1번
SELECT Email
	 , Mobile
	 , Names
	 , Addr
  FROM membertbl
  ORDER BY Addr DESC, Email ASC, Names DESC;

-- 2번
SELECT Names AS '도서명'
	 , Author AS '저자'
	 , ISBN
	 , Price AS '정가'
  FROM bookstbl
  ORDER BY Price DESC;

-- 3번
SELECT m.Names AS '회원명'
	 , m.Levels AS '회원등급'
	 , m.Addr AS '회원주소'
	 , r.rentalDate AS '대여일'
  FROM membertbl AS m LEFT OUTER JOIN rentaltbl AS r
	ON r.memberIdx = m.memberIdx
 WHERE r.rentalDate IS NULL
   AND m.Levels = 'A';

-- 4번
SELECT d.Names AS '책 장르'
	 , FORMAT(SUM(b.Price), '#,#') + '원' AS '총 합계 금액'
  FROM divtbl d, bookstbl b
 WHERE d.Division = b.Division
 GROUP BY d.Division, d.Names;

-- 5번
SELECT ISNULL(d.Names, '--합계--') AS '책 장르'
	 , COUNT(*) AS '권수'
	 , FORMAT(SUM(b.Price), '#,#') + '원' AS '총 합계 금액'
  FROM divtbl d, bookstbl b
 WHERE d.Division = b.Division
 GROUP BY d.Names WITH ROLLUP;