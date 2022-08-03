<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>후원게시판 - Comme</title>
    <style>
        :root {
            --sil: #d5d5d5;
            --bro: #CFB988;
        }

        * {
            box-sizing: border-box;
        }


        .content {
            margin: 0 12vw 0 12vw;
        }

        .content_header {
            height: 50px;
        }

        .content_footer {
            height: 50px;
        }

        .boardList {
            height: 86%;
        }

        .content_header {
            display: flex;
            justify-content: space-between;
            border-bottom: 1px solid var(--sil);
        }

        .content_header h5 {
            display: flex;
            justify-content: center;
            align-items: center;
            color: #cf936f;
        }

        #search_form {
            flex-basis: 300px;
            display: flex;
            align-items: center;
            gap: 40px;
        }

        #search_form #category {
            width: 30%;
            height: 40px;
            margin-right: 10px;
        }

        #search_form .search {
            position: relative;
            flex-basis: 65%;
        }

        #search_form #search {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            width: 100%;
            height: 40px;
            padding-left: 20px;
            border-top-right-radius: 10px;
            border-bottom-right-radius: 10px;
            border : 1px solid var(--sil);
        }

        #search_form #searchBtn {
            width: 40px;
            height: 40px;
            position: absolute;
            top: 50%;
            left: -40px;
            transform: translate(0%, -50%);
            background-color: var(--sil);
            border: none;
            display: flex;
            justify-content: center;
            align-items: center;
            border-top-left-radius: 10px;
            border-bottom-left-radius: 10px;
        }

        #searchBtn img {
            background-color: var(--sil);
            width: 30px;
            height: 30px;
        }

        .boardList {
            margin-top: 30px;
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 30px;
            padding: 10px;
            margin-bottom: 50px;
        }

        .boardList a {
            color: black;
            text-decoration: none;
            max-height: 400px;
        }

        .boardList a:hover {
            text-decoration: none;
        }

        .board {
            display: flex;
            flex-direction: column;
            align-items: center;
            height: 100%;
            width: 100%;
            gap: 20px;
            padding: 10px;
        }
        .board_img {
            flex-basis: 50%;
            width: 80%;
            display: flex;
            border-radius: 20px;
            justify-content: center;
            align-items: center;
        }

        .board_img img {
            overflow: hidden;
            width: 100%;
            max-width: 180px;
            max-height: 180px;
            height: auto;
        }

        .board_content {
            flex-basis: 25%;
            width: 80%;
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            grid-template-rows: repeat(3, 1fr);
        }

        .board_content span {
            color: var(--sil);
            font-size: 0.8em;
            display: block;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;

        }

        .board_content .title {
            color: black;
            font-size: 1.0em;
        }
        .board_content span:first-child {
            grid-area: 1/1/2/3;
        }
        .board_content span:nth-child(2) {
            grid-area: 2/1/3/3;
        }

        .board_content span:nth-child(3) {
            grid-area: 3/1/4/3;
        }

        .content_footer {
            border-top: 1px solid var(--sil);
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        #write {
            position: absolute;
            right: 3%;
            height: 40px;
            width: 70px;
            background-color: white;
            border: 1px solid var(--sil);
            color: var(--sil);
            border-radius: 10px;
        }

        #write:hover {
            color: #ffffff;
            background-color: var(--sil);
        }

        .noResult {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        @media screen and (max-width: 960px) {
            .content {
                margin: 0 0 0 0;
                padding : 0 1vw 0 1vw;
            }

            .content_header {
                flex-direction: column;
                align-items: flex-start;
                height: 110px;
                gap: 3px;
            }

            #search_form {
                flex-basis: auto;
                height: 60px;
                width: 100%;
            }

            .boardList {
                grid-template-columns: none;
                grid-template-rows: repeat(12, 1fr);
                gap: 10px;
            }

            .boardList a {
                color: black;
                text-decoration: none;
            }

            .board {
                flex-direction: row;
                border-bottom: 1px solid var(--sil);
            }

            .board_img {
                flex-basis: 30%;
                height: 100%;
            }

            .board_content {
                flex-basis: 65%;
                grid-template-columns: repeat(2, 1fr);
                grid-template-rows: repeat(4, 1fr);
            }

            .board_content .title {
                grid-column: 1/2;
                grid-row: 1/2;
                font-size: 1.2em;
                margin-bottom: 3px;
            }

            .board_content .nickname {
                grid-column: 1/2;
                grid-row: 2/3;

            }

            .board_content .written_date {
                grid-column: 2/3;
                grid-row: 2/3;
            }

            .boardList > a:last-child > .board {
                border-bottom: none;
            }

            .page a {
                display: block;
                margin: 0 3px;
                font-size: 13px;
                color: #999;
                text-decoration: none;
            }

            .page a:hover {
                background-color: #f9f9f9;
                color: #555;
                border: 1px solid #aaa;
                border-radius: 2px;
            }

            

        }
        
        .margin{
            margin: 0 12vw 0 12vw;
        }
    </style>
</head>
<link rel="stylesheet"
      href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
      crossorigin="anonymous">
<link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
        rel="stylesheet" />
<script
        src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.5/dist/umd/popper.min.js"></script>
<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<body>

    <jsp:include page="/WEB-INF/views/frame/header.jsp"/>

    <div class="content margin">
        <div class="content_header">
            <div class="col-5 d-none d-md-flex" style="align-items: flex-end; padding: 0px;">
				<h5><strong>후원 게시판</strong></h5>
			</div>
			<div class="col d-md-none text-center mt-2 mb-2">
				<h5><strong>후원 게시판</strong></h5>
			</div>
            <form action="/supportBoard/search" id="search_form">
                <label for="category"></label>
                <select name="category" id="category">
                    <option value="board_title">제목</option>
                    <option value="board_content">내용</option>
                    <option value="writer_nickname">작성자</option>
                </select>
                <div class="search">
                    <button type="submit" id="searchBtn"><img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png"></button>
                    <label for="search">
                        <input type="text" id="search" name="search" required
                               oninvalid="this.setCustomValidity('검색어를 입력해주세요')"
                               oninput="this.setCustomValidity('')">
                    </label>
                </div>
            </form>
        </div>
        <div class="boardList">
            <c:if test="${empty map.list}">
                <div class = "noResult"><span>조회된 게시글이 없습니다.</span></div>
            </c:if>
            <c:if test="${not empty map.list}">
                <c:forEach items="${map.list}" var="i">
                    <a href="/supportBoard/view?seq_board=${i.seq_board}">
                        <div class="board">
                            <div class="board_img">
                                <c:if test="${empty i.files_sys}">
                                    <img src="/resources/images/No_image.png">
                                </c:if>
                                <c:if test="${not empty i.files_sys}">
                                    <img src="/files/support/${i.files_sys}">
                                </c:if>
                            </div>
                            <div class="board_content">
                                <span class="title"><c:out value="${i.board_title}"/></span>
                                <span class="nickname"><c:out value="${i.writer_nickname}"/></span>
                                <span class="written_date"><fmt:formatDate value="${i.written_date}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </c:if>
        </div>
        <div class="content_footer">
            <div class="page">
                <c:if test="${empty map.category}">
                    <c:if test="${map.pagingVO.startPage!=1}">
                        <a id="first"
                           href="/supportBoard/lists?curPage=1">첫
                            페이지</a>
                        <a class="arrow left"
                           href="/supportBoard/lists?curPage=${map.pagingVO.startPage-1}">&lt;</a>
                    </c:if>
                    <c:forEach begin="${map.pagingVO.startPage}" end="${map.pagingVO.endPage }" var="p" step="1">
                        <a href="/supportBoard/lists?curPage=${p}">${p}</a>
                    </c:forEach>
                    <c:if test="${map.pagingVO.endPage != map.pagingVO.lastPage}">
                        <a class="arrow right"
                           href="/supportBoard/lists?curPage=${map.pagingVO.endPage+1}">&lt></a>

                        <a id="last"
                           href="/supportBoard/lists?curPage=${map.pagingVO.lastPage}">끝페이지</a>
                    </c:if>
                </c:if>
                <c:if test="${not empty map.category}">
                    <c:if test="${map.pagingVO.startPage!=1}">
                        <a id="first"
                           href="/supportBoard/search?category=${map.category}&search=${map.search}">첫
                            페이지</a>
                        <a class="arrow left"
                           href="/supportBoard/search?category=${map.category}&search=${map.search}&curPage=${map.pagingVO.startPage-1}">&lt;</a>
                    </c:if>
                    <c:forEach begin="${map.pagingVO.startPage}" end="${map.pagingVO.endPage }" var="p" step="1">
                        <a href="/supportBoard/search?category=${map.category}&search=${map.search}&curPage=${p}">${p}</a>
                    </c:forEach>
                    <c:if test="${map.pagingVO.endPage != map.pagingVO.lastPage}">
                        <a class="arrow right"
                           href="/supportBoard/search?category=${map.category}&search=${map.search}&curPage=${map.pagingVO.endPage+1}">&lt></a>

                        <a id="last"
                           href="/supportBoard/search?category=${map.category}&search=${map.search}&curPage=${map.pagingVO.lastPage}">끝페이지</a>
                    </c:if>
                </c:if>
            </div>
            <c:if test="${loginSession.member_grade==2}">
                <button type="button" id="write">글쓰기</button>
                <script>
                    document.querySelector("#write").addEventListener("click",()=>{
                        let brn = "${loginSession.member_grade}";
                        if(brn==="2"){
                            location.href = "/supportBoard/write"
                        } else{
                            alert("기관 회원만 이용할 수 있는 기능입니다.");
                        }
                    })
                </script>
            </c:if>
        </div>
    </div>

</body>
<!-- 탑버튼 -->
<jsp:include page="/WEB-INF/views/frame/topButton.jsp"/>
<script>


    // pagination css 안 먹어서 스크립트로 해둘게요
    let page = document.querySelectorAll(".page a");
    page.forEach(target=>{
        target.style.color = "#999";
        target.style.textDecoration = "none"
    });
    page.forEach(e => e.addEventListener('mouseover', (target) => {
        target.style.color = "#555";
        target.style.backgroundColor = "#f9f9f9";
        target.style.textDecoration = "none"
        target.style.border = "1px solid #aaa";
        target.style.borderRadius = "2px";

    }))


</script>
</html>
<jsp:include page="/WEB-INF/views/frame/footer.jsp"/>
