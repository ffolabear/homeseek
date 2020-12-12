<h2>요약</h2>

  * COURSE : 웹기반 빅데이터 전문 개발자 양성과정 (1) - KH정보교육원 (강남지원)
  * SUBJECT : 파이널 프로젝트
  * TITLE : Homeseek 
  * SUMMARY : 공인중계사 없이 개인과 개인간의 부동산 거래 플랫폼
  * PERIOD : 2020.10.19 ~ 2020.11.17

<br><br>

<h2>프로젝트 멤버</h2>
  
  * [황인규](https://github.com/hig228)
  * [강여림](https://github.com/yr9708)
  * [김지후](https://github.com/KimJiHu0)
  * [김태현](https://github.com/ffolabear)
  * [이병욱](https://github.com/rpget2020)
  
<br><br>

<h2>개발 동기</h2>

 * 부동산 거래는 주거문제를 해결하기 위한 필수적인 일이지만 안전성, 투명성, 신속성이 떨어지는 것이 문제
 * 이러한 문제점을 공인중개사가 개입해서 어느정도 해결할 수 있지만 불필요한 수수료가 발생

<br><br>

<h2>구현 기능</h2> 

 * 매물 전체조회 
    - ElasticSearch 를 통해서 빠른 검색 및 키워드를 통한 검색기능 

 * 게시판 
    - 헤더 매뉴를 눌렀을때 로그인이 되어있지 않은 상태라면 로그인 페이지로 이동
    - 관리자계정으로 로그인시 사이트 관리 게시판을 조회 및 관리 할 수 있음
    - 글쓰기부분에서 summernote API를 사용해서 다양한 기능 추가
    - Ajax를 활용한 파일 업로드 및 미리보기
    - 컨트롤러에서 파일이름명을 변환하고 Servlet realpath에 저장

 * 도로명주소 
    - 사용자의 매물을 등록할때 필요한 주소를 받기위해서 추가
    - 도로명 주소 API, Kakao Map API 사용

 * 결제
   - 사용자가 보기에서 원하는 만큼 금액을 선택해서 후원
   - Bootpay API를 를 통한 결제 기능 구현
 
<br><br>

<h2>개발 환경</h2> 

 * 사용 언어 : Java, JavaScript, HTML, CSS
 * 사용 프레임워크 : Spring Framework
 * 사용 라이브러리 :  jQuery, Summernote, Socket.IO
 * 사용 API : SNS 로그인(NAVER, kakao, Google), 카카오지도, 도로명주소, 부트페이
 * 사용 DB : Oracle Database 11g
 * 사용 서버 : Apache Tomcat 9.0, Amazon Web Server
 * 사용 도구 : Eclipse IDE
 * 형상 관리 : Github

<br><br>














