<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 부트스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
	<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<title>실종 게시판</title>
<style>
.header {
	margin-bottom: 20px;
}


/*실종 게시판 타이틀*/
.title {
	border-bottom: 1px solid lightgray;
	display: flex;
	color: rgb(207, 147, 111);
	padding-right: 0px;
	padding-left: 0px;
}

/* 버튼 */
.btn {
	color: #cf936f;
	border: 1px solid #cf936f;
	padding: 3px 8px;
   	font-size: small;
    border-radius: 8px;
}
		
.btn:hover {
	color: #cf936f;
	background-color: #fff0dd;
}

/* 검색 select */
.selectMissing {
	width: 80px;
    padding: 2px 10px;
    font-size: 14px;
    float: right;
    height: 28px;
    border-radius: 8px;
}
.searchDiv{
 margin-bottom : 10px;
 padding-right: 25px;
}
/* 검색 input 창 감싸는 div */
.shMissing {
	position: relative;
	width: 200px;
}
/* 검색 input */
#keywordMissing {
	width: 200px;
    border: 1px solid #ced4da;
    border-radius: 8px;
    height: 28px;
    padding: 1px 10px;
}
/* 돋보기 이미지 */
.lookup {
	position: absolute;
    width: 17px;
    top: 5px;
    right: -16px;
    margin-right: 15px;
    cursor: pointer;
}

.missingContent {
	margin-top: 30px;
}
/* 실종 동물이 없을경우 */
.nomissing {
	font-size: 100px;
}
/* 실종 카드 */
.card {
	margin-bottom: 30px;
	min-height: 400px;
}
.missingContent a {
	text-decoration: none;
	color: black;
}
.missingContent a:hover {
	text-decoration: none;
}

.card {
	 width: 18rem;
}

.card p {
	font-size: 0.8em;
}

.card .img {
	height: 50%;
	/*display: flex;*/
	justify-content: center;
	align-items: center;
}

.missingContent img {
	width: 100%;
	height: 100%;
}

.cardMissing {
	margin: 10px;
}

.card-body {
	width: 100%;
}

#cardTitleMd {
	font-weight: bold;
	height: 58px;
	width: 100%;
    align-items: center;
    margin: 15px 0px;
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 3;
}

#cardInfo p {
	margin-bottom: 1px;
}

#cardInfo {
	margin-top: 2px;
}
/*반응형 실종 목록 */
.resMissing {
	padding: 10px;
	border-bottom: 1px solid #ced4da;
}
.resMissing p {
	margin: 0px;
}

.imgSm {
    align-items: center;
}

.imgSm img {
	width: 130px;
	height: 130px;
}

#cardTitleSm {
	font-size: large;
	font-weight: bold;
    align-items: center;
    height: 50px;
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 2;
    margin: 15px 0px;
}

#cardInfoSm {
	font-size: 14px;
}

.cardInfoSmContainer {
	display: flex;
    align-items: center;
}

/* 페이징 */
.page {
	display: flex;
	justify-content: center;
	gap: 10px;
}

.page a {
	display: block;
	margin: 0 3px;
	font-size: 14px;
	color: #cf936f;
	text-decoration: none !important;
}

.page a:hover {
	color: #cf936f;
}

.margin{
    margin: 0 12vw 0 12vw;
}

</style>
</head>
<body>
	<!-- header -->
	<jsp:include page="/WEB-INF/views/frame/header.jsp"></jsp:include>
	<div class="content margin">
		<div class="row body justify-content-center">
			<div class="row title mt-5">
				<div class="col-5 d-none d-md-flex" style="align-items: flex-end; padding: 0px;">
					<h5><strong>실종 게시판</strong></h5>
				</div>
				<div class="col d-md-none text-center mb-5">
					<h5><strong>실종 게시판</strong></h5>
				</div>
				<div class="col-12 col-md-7 searchDiv">
				<form id="searchForm">
					<div class="row d-flex justify-content-end">
						<div class="col p-0">
						<select name="category" class="form-select selectMissing">
							<option value="title" selected>제목</option>
							<option value="content">내용</option>
							<option value="writerNickname">작성자</option>
							<option value="area">지역</option>
						</select>
						</div>
						<div class="shMissing">
							<input type="text" name="keywordMissing" id="keywordMissing" placeholder="검색어 입력">
							<img class="lookup" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
						</div>	
					</div>
					<div class="col d-flex d-md-none justify-content-end mt-3">
						<button type="button" class="btn writeBtn">글쓰기</button>
					</div>
					</form>
				</div>
			</div>
			<div class="row missingContent row-cols-xl-4 row-cols-lg-3 row-cols-md-2 g-3">
				<c:if test="${map.list.size() == 0}">
					<div class="col nomissing d-flex justify-content-center">
						<p><strong>실종 동물이 없습니다.</strong></p>
					</div>
				</c:if>
				<c:if test="${map.list.size() > 0}">
					<c:forEach items="${map.list}" var="dto">
						<div class="col-3 d-none d-md-flex justify-content-center" style="height: 26em;">
							<div class="card">
								<div class="img">
									<a href="/miss/toDetail?seq_board=${dto.seq_board}">
										<c:if test="${empty dto.files_sys}">
											<img src="/resources/images/No_image.png">
										</c:if>
										<c:if test="${not empty dto.files_sys}">
											<img src="/mbFile/${dto.files_sys}">
										</c:if>
									</a>
								</div>
								<div class="card-body">
									<a href="/miss/toDetail?seq_board=${dto.seq_board}">
										<h6 class="card-title" id="cardTitleMd">${dto.board_title}</h6>
										<div id="cardInfo">
											<p>실종 지역&nbsp;:&nbsp;&nbsp;<strong>${dto.miss_area}</strong></p>
											<p>동물 종류&nbsp;:&nbsp;&nbsp;<strong>${dto.animal_kind}</strong></p>
											<c:set var="TextValue" value="${dto.miss_date}" />
											<p class="card-text">실&nbsp;종&nbsp;일&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;<strong>${fn:substring(TextValue, 0, 10)}</strong></p>
											<c:set var="TextDate" value="${dto.written_date}" />
											<p class="card-text">작&nbsp;성&nbsp;일&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;<strong>${fn:substring(TextDate, 0, 10)}</strong></p>
										</div>
									</a>
								</div>
							</div>
						</div>
						<div class="col-12 d-md-none m-0">
							<div class="row">
								<a href="/miss/toDetail?seq_board=${dto.seq_board}">
								<span class="card-title" id="cardTitleSm">${dto.board_title}</span></a>
							</div>
							<div class="row resMissing">
								<div class="col imgSm d-flex">
									<a href="/miss/toDetail?seq_board=${dto.seq_board}">
									<c:if test="${empty dto.files_sys}">
                            			<img src="/resources/images/No_image.png">
                        			</c:if>
                        			<c:if test="${not empty dto.files_sys}">
                           		 		<img src="/mbFile/${dto.files_sys}">
                        			</c:if></a>
								</div>
								<div class="col cardInfoSmContainer">
									<a href="/miss/toDetail?seq_board=${dto.seq_board}">
										<div id="cardInfoSm">
											<p>실종 지역 : <strong>${dto.miss_area}</strong></p>
											<p>동물 종류 : <strong>${dto.animal_kind}</strong></p>
											<c:set var="TextValue" value="${dto.miss_date}" />
											<p class="card-text">실종일 : <strong>${fn:substring(TextValue, 0, 10)}</strong></p>
											<c:set var="TextDate" value="${dto.written_date}" />
											<p class="card-text">작성일 : <strong>${fn:substring(TextDate, 0, 10)}</strong></p>
										</div>
									</a>
								</div>

							</div>
						</div>
					</c:forEach>
				</c:if>
			</div>
			<div class="row">
				<div class="col page d-flex justify-content-end">
				  <c:if test="${empty map.category}">
                <c:if test="${map.pagingVO.startPage!=1}">
                    <a id="first"
                       href="/miss/toMissing?curPage=1">첫페이지</a>
                    <a class="arrow left"
                       href="/miss/toMissing?curPage=${map.pagingVO.startPage-1}">&lt;</a>
                </c:if>
                <c:forEach begin="${map.pagingVO.startPage}" end="${map.pagingVO.endPage}" var="p" step="1">
                    <a href="/miss/toMissing?curPage=${p}">${p}</a>
                </c:forEach>
                <c:if test="${map.pagingVO.endPage != map.pagingVO.lastPage}">
                    <a class="arrow right"
                       href="/miss/toMissing?curPage=${map.pagingVO.endPage+1}">&gt;</a>
                    <a id="last"
                       href="/miss/toMissing?curPage=${map.pagingVO.lastPage}">끝페이지</a>
                </c:if>
            </c:if>
            <c:if test="${not empty map.category}">
                <c:if test="${map.pagingVO.startPage!=1}">
                    <a id="first" href="/miss/search?category=${map.category}&search=${map.search}">첫페이지</a>
                    <a class="arrow left" href="/miss/search?category=${map.category}&search=${map.search}&curPage=${map.pagingVO.startPage-1}">&lt;</a>
                </c:if>
                <c:forEach begin="${map.pagingVO.startPage}" end="${map.pagingVO.endPage }" var="p" step="1">
                    <a href="/miss/search?category=${map.category}&search=${map.search}&curPage=${p}">${p}</a>
                </c:forEach>
                <c:if test="${map.pagingVO.endPage != map.pagingVO.lastPage}">
                    <a class="arrow right" href="/miss/search?category=${map.category}&search=${map.search}&curPage=${map.pagingVO.endPage+1}">&gt;</a>
                    <a id="last" href="/miss/search?category=${map.category}&search=${map.search}&curPage=${map.pagingVO.lastPage}">끝페이지</a>
                </c:if>
            </c:if>
				</div>
				<div class="col d-none d-md-flex justify-content-end">
					<button type="button" class="btn writeBtn">글쓰기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/frame/footer.jsp"></jsp:include>
	<!-- 탑버튼 -->
	<jsp:include page="/WEB-INF/views/frame/topButton.jsp"/>
	<script>
		// 글쓰기 버튼눌렀을때
		$(".writeBtn").click(function(){
			if(${not empty loginSession.member_id}){
				location.href = "/miss/toWrite";
			} else alert("회원에게만 제공되는 기능입니다.");
		})

		document.querySelector("#searchForm").addEventListener("submit", e=>{
			e.preventDefault();
			search();
		});

		document.querySelector(".lookup").addEventListener("click", e=> search());


	
		// 검색
		let search = function() {
			if ($("#keywordMissing").val() == "") {
				alert("검색어를 입력하세요");
			} else {
				let formData = $("#searchForm").serialize();

				$.ajax({
					url: "/miss/search"
					, type: "get"
					, data: formData
					, success: function (data) {
						console.log(data);
						//mkElement(data);
						$(".missingContent").empty();
						if (data.list.length == 0) { // 검색 결과 없음
							let divRow = $("<div>").addClass("col d-flex justify-content-center");
							let p2 = $("<p>")
							let strong = $("<strong>").html("검색된 결과가 없습니다.");
							p2.append(strong);
							p2.appendTo(divRow);
							$(".missingContent").append(divRow);
							$(".page").addClass("d-none");
						} else {
							for (let dto of data.list) {
								console.log(typeof dto.miss_date);
								let miss_date = new Date(dto.miss_date - new Date().getTimezoneOffset() * 60000).toISOString().slice(0, 10);
								let written_date = new Date(dto.written_date).toISOString().slice(0, 10);

								let col2 = $("<div>").addClass("col-6 d-none d-sm-flex justify-content-center");
								let card = $("<div>").addClass("card").css("width", "18rem");
								let a = $("<a>").attr("href", "/miss/toDetail?seq_board=" + dto.seq_board);
								if (dto.files_sys == null) {
									let img = $("<img>").attr("src", "/resources/images/No_image.png").addClass("card-img-top");
									a.append(img);
								} else if (dto.files_sys != null) {
									let img = $("<img>").attr("src", "/mbFile/" + dto.files_sys).addClass("card-img-top");
									a.append(img);
								}
								console.log();
								let cardBody = $("<div>").addClass("card-body");
								let h5 = $("<h5>").addClass("card-title").html(dto.board_title);
								let pMiss = $("<p>").html("실종 지역 : ");
								let sMiss = $("<strong>").html(dto.miss_area);
								let pKind = $("<p>").html("동물 종류 : ");
								let sKind = $("<strong>").html(dto.animal_kind);
								let cardText = $("<p>").addClass("card-text").html("실종일 : ");
								let scardText = $("<strong>").html(miss_date);
								let cardText2 = $("<p>").addClass("card-text").html("작성일 : ");
								let scardText2 = $("<strong>").html(written_date);

								pMiss.append(sMiss);
								pKind.append(sKind);
								cardText.append(scardText);
								cardText2.append(scardText2);
								cardBody.append(h5, pMiss, pKind, cardText, cardText2);

								card.append(a, cardBody);
								col2.append(card);
								col2.appendTo(".missingContent");

								let div3 = $("<div>").addClass("col-12 d-sm-none");
								let row = $("<div>").addClass("row resMissing");
								let col3 = $("<div>").addClass("col");
								let a2 = $("<a>").attr("href", "/miss/toDetail?seq_board=" + dto.seq_board);
								if (dto.files_sys == null) {
									let img2 = $("<img>").attr("src", "/resources/images/No_image.png").addClass("card-img-top");
									a2.append(img2);
								} else if (dto.files_sys != null) {
									let img2 = $("<img>").attr("src", "/mbFile/" + dto.files_sys).addClass("card-img-top");
									a2.append(img2);
								}
								let col4 = $("<div>").addClass("col");
								let h5_1 = $("<h5>").addClass("card-title").html(dto.board_title);
								let p3 = $("<p>").html("실종지역 : ");
								let sP3 = $("<strong>").html(dto.miss_area);
								let p4 = $("<p>").html("동물 종류 : ");
								let sP4 = $("<strong>").html(dto.miss_area);
								let p1 = $("<p>").html("실종일 : ");
								let sP1 = $("<strong>").html(miss_date);
								let p2 = $("<p>").html("작성일 : ");
								let sP2 = $("<strong>").html(written_date);

								p3.append(sP3);
								p4.append(sP4);
								p1.append(sP1);
								p2.append(sP2);

								col4.append(h5_1, p3, p4, p1, p2);
								col3.append(a2);
								row.append(col3, col4);
								div3.append(row);
								div3.appendTo(".missingContent");
								$(".page").removeClass("d-none");
							}
						}

					}, error: function (e) {
						console.log(e);
					}
				})
			}
		}
		
	</script>
	
</body>
</html>
