-- 1번
SELECT Email
	 , Mobile
	 , Names
	 , Addr
  FROM membertbl;

-- 2번
SELECT Names AS '도서명'
	 , Author AS '저자'
	 , ISBN
	 , Price AS '정가'
  FROM bookstbl
  ORDER BY Price DESC;

-- 3번
SELECT *
  FROM membertbl
 WHERE memberIdx NOT IN(SELECT memberIdx
						 FROM rentaltbl);

SELECT *
  FROM rentaltbl
  ORDER BY memberIdx;

SELECT *
  FROM bookstbl;

SELECT m.Names AS '회원명'
	 , m.Levels AS '회원등급'
	 , m.Addr AS '회원주소'
	 , r.rentalDate AS '대여일'
	 , m.memberIdx
  FROM bookstbl b, membertbl m, rentaltbl r
 WHERE b.bookIdx = r.bookIdx
   AND r.memberIdx = m.memberIdx
   AND m.memberIdx NOT IN(SELECT m.memberIdx
							FROM bookstbl b, membertbl m, rentaltbl r
						   WHERE b.bookIdx = r.bookIdx
							 AND r.memberIdx = m.memberIdx);

-- 책 빌린 사람들
SELECT m.memberIdx
  FROM bookstbl b, membertbl m, rentaltbl r
 WHERE b.bookIdx = r.bookIdx
   AND r.memberIdx = m.memberIdx
   AND m.memberIdx NOT IN(SELECT m.memberIdx
							FROM bookstbl b, membertbl m, rentaltbl r
						   WHERE b.bookIdx = r.bookIdx
							 AND r.memberIdx = m.memberIdx);

SELECT *
  FROM bookstbl b, membertbl m, rentaltbl r
 WHERE b.bookIdx = r.bookIdx
   AND r.memberIdx = m.memberIdx;
