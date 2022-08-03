<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/frame/header.jsp"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
            crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.js"
            integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <title>실종게시판 상세보기</title>
    <style>
        * {
            box-sizing: border-box;
        }

        :root {
            --sil: #d5d5d5;
        }

        .content {
            margin-top: 50px;
        }

        .board-title {
            display: flex;
            align-items: center;
        }

        /* 타이틀 */
        .title-body {
            margin-top: 20px;
            color: rgb(207, 147, 111);
			border-bottom: 1px solid lightgray;
        }

        .content-title {
            margin-top: 20px;
        }
		
		/* 글쓴이 등 */
        .writer {
            margin-top: 10px;
            font-size: 14px;
            border-bottom: 1px solid var(--sil);
        }
        .writer span {
            display: block;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        /*.writer > span:first-child {
            grid-area: 1/1/2/3;
        }
        .writer > span:nth-child(2) {
            grid-area: 1/5/2/7;
        }

        .writer > span:nth-child(3) {
            grid-area: 1/8/2/9;
        }*/

        .writer > .writerBtn {
            grid-area: 1/9/2/11;
            display: flex;
        }
		
		/* form-control */
		.form-control:focus {
			box-shadow: none;
			border: 1px solid #ced4da;
		}

        .content-box {
            margin-top: 20px;
            margin-bottom: 20px;
        }

        .content-box > div:first-child {
            display: flex;
            gap: 30px;
            border : 1px solid var(--sil);
            padding: 50px;
            margin-bottom: 40px;
            max-height: 500px;
        }

        .content-box > div:first-child > .imgContainer {
            flex-basis: 40%;
            display: flex;
            justify-content: center;
            align-items: center;
            border-right: 1px solid var(--sil);
            padding : 20px;
        }
        .content-box > div:first-child > .explain {
            flex-basis: 60%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            gap: 20px;

        }
        
        /* 글 내용 이미지 크기 조절 */
        .content-box img {
            max-width: 90%;
            max-height: 90%;
        }

        .board_content {
            min-height: 500px;
        }

        /* 댓글 타이틀 */
        .comment-title, .board-title {
            border-bottom: 1px solid black;
        }

        .writingModify, .writingDelete {
            margin-bottom: 10px;
        }

        /* 댓글타이틀 이미지 */
        .comment-title img {
            margin-bottom: 10px;
            width: 30px;
        }

        /* 댓글수정 / 삭제 커서 */
        .commentBtn span {
            cursor: pointer;
            color: #cf936f;
            font-weight: bold;
        }

        .commentBtn {
            text-align: right;
        }

        .comment-body, .comment-text {
            margin-top: 20px;
            font-size: 14px;
        }

        #commentBtn {
            float: right;
            margin: 10px;
        }

        .btns {
            margin-top: 20px;
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
        /* 댓글 입력  */
        .commentWrite {
            border-bottom: 1px solid black;
        }

        #commentNickname {
            margin-top: 10px;
            width: 30%;
            margin-bottom: 10px;
        }

        #comment_content {
            margin-top: 10px;
            width: 100%;
            height: 100px;
            resize: none;
            font-size: 14px;
        }

        #writeBtn {
            float: right;
        }

        .comment_content {
            border: 0px;
            margin-bottom: 10px;
        }

        .commentText {
            border-bottom: 1px solid grey;
            margin-bottom: 10px;
            margin-top: 10px;
        }

        .nick {
            font-weight: bold;
            font-size: 14px;
        }

        /* 댓글 닉네임 인풋창 */
        input[readonly].classname {
            background-color: transparent;
            border: 0;
            font-size: 15px;
        }

        input[readonly].comment_content {
            background-color: transparent;
            border: 0;
            font-size: 14px;
        }

        .comment_header {
            display: flex;
            gap: 20px;
        }

        .commentBtn {
            display: flex;
            gap: 20px;
            justify-content: flex-end;
        }

        .margin{
            margin: 0 12vw 0 12vw;
        }
    </style>
</head>
<body>
<div class="content margin">
    <div class="row title-body mt-5">
        <div class="col-5 d-none d-md-flex" style="align-items: flex-end; padding: 0px;">
			<h5><strong>실종 게시판</strong></h5>
		</div>
		<div class="col d-md-none text-center">
			<h5><strong>실종 게시판</strong></h5>
		</div>
    </div>
    <div class="row content-body">
        <div class="col content-title">
            <div class="row">
                <h5>[<c:out value="${map.MissingBoardDTO.miss_area}"/>] <c:out value="${map.MissingBoardDTO.board_title}"/></h5>
            </div>
            <div class="row">
                <div class="col d-flex writer">
                    <span class="col-3"><c:out value="${map.MissingBoardDTO.writer_nickname}"/> </span>
                    <c:set var="TextDate" value="${map.MissingBoardDTO.written_date}"/>
                    <span class="col-3">작성일 : ${fn:substring(TextDate, 0, 10)}</span>
                    <span class="col-3">조회수 : ${map.MissingBoardDTO.view_count}</span>
                    <!--로그인 세션으로 글쓴이 비교할것-->
                    <%-- <c:if test="${loginSession.member_id eq map.MissingBoardDTO.member_id}"> --%>
                    <div class="col-3 writerBtn justify-content-end">
                        <c:if test="${loginSession.member_id eq map.MissingBoardDTO.member_id||loginSession.member_grade == '4'}">
                            <button type="button" class="btn writingModify" style="margin-right: 10px;">수정</button>
                            <button type="button" class="btn writingDelete">삭제</button>
                            <script>
                                // 글 삭제
                                $(".writingDelete").click(function () {
                                    let answer = confirm("작성하신 글을 삭제하시겠습니까?");
                                    if (answer) {
                                        location.href = "/miss/delete?seq_board=" + $("#seq_board").val();
                                    }
                                })
                                // 글 수정
                                $(".writingModify").click(function () {
                                    location.href = "/miss/toModify?seq_board=" + $("#seq_board").val();
                                })
                            </script>
                        </c:if>
                    </div>
                    <%-- </c:if> --%>
                </div>
            </div>
        </div>
        <div class="content-box">
            <div>
                <div class="imgContainer">
                    <c:if test="${not empty map.files}">
                        <img src="/mbFile/${map.files[0].files_sys}" alt="">
                    </c:if>
                    <c:if test="${empty map.files}">
                        <img src="/resources/images/No_image.png" alt="">
                    </c:if>
                </div>
                <div class="explain">
                    <c:set var="date" value="${map.MissingBoardDTO.miss_date}"/>
                    <span>실종일 : ${fn:substring(date, 0, 10)}</span>
                    <span>실종지역 : <c:out value="${map.MissingBoardDTO.miss_area}"/></span>
                    <span>실종동물 : <c:out value="${map.MissingBoardDTO.animal_kind}"/></span>
                </div>
            </div>
            <div class="row">
                <div class="col board_content">
                    <c:out value="${map.MissingBoardDTO.board_content}" escapeXml="false"/>
                </div>
            </div>
        </div>
    </div>
    <div class="row comment">
        <div class="col comment-title">
            <i class="fa-regular fa-comments"></i>
            <span>Comment(${map.commentCount})</span>
        </div>
        <div class="row comment-body">
            <div class="col">
                <!-- 달린 댓글없으면 없다고 처리해주기 -->
                <c:if test="${map.commentDTO.size() == 0}">
                    <p> 등록된 댓글이 없습니다.</p>
                </c:if>
                <%-- 여러개 일 경우 for문--%>
                <c:if test="${map.commentDTO.size() > 0}">
                    <c:forEach items="${map.commentDTO}" var="commentDTO">
                        <div class="comment">
                            <div class="comment_header">
                                <span class="nick">${commentDTO.comment_nickname}</span>
                                <span>${commentDTO.comment_date}</span>
                                <c:if test="${loginSession.member_id eq commentDTO.comment_id|| loginSession.member_grade=='4'}">
                                    <div class="col commentBtn">
                                        <span class="commentModify">수정</span>
                                        <span class="commentModifyOk d-none" data-value="${commentDTO.seq_comment}">수정완료</span>
                                        <span class="commentDelete" data-value="${commentDTO.seq_comment}">삭제</span>
                                    </div>
                                </c:if>
                            </div>
                            <input type="text" class="comment_content form-control" name="comment_content" value="${commentDTO.comment_content}" readonly>
                        </div>

                        <%--</c:if>--%>
                    </c:forEach>
                </c:if>
            </div>
        </div>
        <form id="commentForm" action="/comment/missing_comment" method="post">
            <div class="row commentWrite">
                <div class="col">
                    <%-- ${loginSession.member_nickname} 로그인 세션으로 넣어줄것--%>
                    <textarea id="comment_content" name="comment_content" placeholder="내용을 입력해주세요" class="form-control"></textarea>
                    <button type="button" id="commentBtn" class="btn">댓글 등록
                    </button>
                </div>
                <div class="col d-none">
                    <input type="text" id="seq_board" value="${map.MissingBoardDTO.seq_board}" name="seq_board">
                </div>
            </div>
        </form>
    </div>
    <div class="row btns">
        <div class="col">
            <button type="button" id="listBtn" class="btn">목록
            </button>
            <button type="button" id="writeBtn" class="btn">글쓰기
            </button>
        </div>
    </div>
</div>
<script>
    // 마지막 댓글은 줄 없게
    $(".commentText").last().css("border-bottom", "none");

    // 댓글 입력
    document.querySelector("#commentBtn").addEventListener("click", () => {
        if (${empty loginSession}) {
            alert("회원만 이용가능한 기능입니다");
            return;
        }

        if (document.querySelector("#comment_content").value === '') {
            alert("댓글을 입력해주세요.");
            return;
        }

        $.ajax({
            url: "/comment/missingComment",
            type: "post",
            data: {
                comment_content: document.querySelector("#comment_content").value,
                seq_board: document.querySelector("#seq_board").value
            },
            success: function (data) {
                if (data === "success") {
                    showComment();
                }
            },
            error: function (e) {
                console.log(e);
            }
        });
    })
    // 목록 버튼
    $("#listBtn").click(function () {
        location.href = "/miss/toMissing";
    })
    // 글쓰기 버튼
    $("#writeBtn").click(function () {
        location.href = "/miss/toWrite";
    });

    document.querySelector(".comment-body > .col").addEventListener("click", function (e) {
        if (e.target.classList.contains("commentModify")) {
            e.target.classList.add("d-none");
            e.target.nextElementSibling.classList.remove("d-none");
            e.target.parentElement.parentElement.nextElementSibling.readOnly = false;
            e.target.parentElement.parentElement.nextElementSibling.focus();
        }

        if (e.target.classList.contains("commentModifyOk")) {
            e.target.classList.add("d-none");
            e.target.nextElementSibling.classList.remove("d-none");
            e.target.parentElement.parentElement.nextElementSibling.readOnly = false;
            e.target.parentElement.parentElement.nextElementSibling.focus();

            e.target.classList.add("d-none");
            e.target.previousElementSibling.classList.remove("d-none");

            let comment_content = e.target.parentElement.parentElement.nextElementSibling;
            comment_content.readOnly = true;

            $.ajax({
                url: "/comment/modifyMissingComment"
                , type: "post"
                , data: {seq_comment: e.target.getAttribute("data-value"), comment_content: comment_content.value}
                , success: function (data) {
                    console.log(data);
                    if (data === "success") {
                        showComment();
                        <%--location.href = "/miss/toDetail?seq_board=" + ${map.MissingBoardDTO.seq_board};--%>
                    }
                }, error: function (e) {
                    console.log(e);
                }
            });

        }

        if(e.target.classList.contains("commentDelete")){
            let rs = confirm("댓글을 삭제하시겠습니까?");
            if (rs) {
                $.ajax({
                    url: "/comment/deleteMissingComment",
                    data: {seq_comment: e.target.getAttribute("data-value")}
                    , type: "post"
                    , success: function (data) {
                        if (data === "success") {
                            showComment();
                        }
                    }, error: function (e) {
                        console.log(e);
                    }
                })
            }
        }

    });

    function showComment() {
        $.ajax({
            url: "/comment/missingComment",
            data: {seq_board: "${map.MissingBoardDTO.seq_board}"},
            type: "get",
            success: function (data) {
                let item = data.querySelectorAll("item");

                $(".comment-body > .col").empty();

                item.forEach(
                    e => {
                        let comment = document.createElement("div");
                        comment.classList.add("comment");

                        let comment_header = document.createElement("div");
                        comment_header.classList.add("comment_header");

                        let nick = document.createElement("span");
                        nick.classList.add("nick");
                        nick.innerHTML = e.querySelector("comment_nickname").innerHTML;

                        let date = document.createElement("span")
                        date.innerHTML = elapsedTime(e.querySelector("comment_date").innerHTML);

                        let commentBtn = document.createElement("div");
                        commentBtn.classList.add("commentBtn");
                        commentBtn.classList.add("col");

                        if("${loginSession.member_id}"===e.querySelector("comment_id").innerHTML||${loginSession.member_grade == '4'}){
                            let commentModify = document.createElement("span");
                            commentModify.innerHTML = "수정"
                            commentModify.classList.add("commentModify");

                            let commentModifyOk = document.createElement("span");
                            commentModifyOk.classList.add("commentModifyOk");
                            commentModifyOk.classList.add("d-none");
                            commentModifyOk.innerHTML = "수정완료"
                            commentModifyOk.setAttribute("data-value", e.querySelector("seq_comment").innerHTML);

                            let commentDelete = document.createElement("span");
                            commentDelete.classList.add("commentDelete");
                            commentDelete.innerHTML = "삭제"
                            commentDelete.setAttribute("data-value", e.querySelector("seq_comment").innerHTML);

                            commentBtn.append(commentModify, commentModifyOk, commentDelete);

                        }
                        comment_header.append(nick, date, commentBtn);

                        let input = document.createElement("input");
                        input.type = "text";
                        input.classList.add("comment_content");
                        input.classList.add("form-control");
                        input.name = "comment_content";
                        input.value = e.querySelector("comment_content").innerHTML;
                        input.readOnly = true;

                        comment.append(comment_header, input);

                        document.querySelector(".comment-body > .col").append(comment);

                    }
                )
                document.querySelector(".comment-title> span").innerHTML = 'Comment('+item.length+')';
            },
            error: (error) => {
                console.log(error);
            }
        })
    }

    /* 댓글 단지 시간 얼마나 걸렷는지 표시해주는거 */
    let date = document.querySelectorAll('.comment_Date');
    date.forEach(date=>{
        date.innerText = elapsedTime(date.innerText);
    })

    /* 댓글 단지 소요시간 나타내주는 함수 */
    function elapsedTime(date) {
        const start = new Date(date);
        const end = new Date(); // 현재 날짜

        const diff = (end - start); // 경과 시간

        const times = [
            {time: "분", milliSeconds: 1000 * 60},
            {time: "시간", milliSeconds: 1000 * 60 * 60},
            {time: "일", milliSeconds: 1000 * 60 * 60 * 24},
            {time: "개월", milliSeconds: 1000 * 60 * 60 * 24 * 30},
            {time: "년", milliSeconds: 1000 * 60 * 60 * 24 * 365},
        ].reverse();

        // 년 단위부터 알맞는 단위 찾기
        for(let i = 0; i < times.length; i++){
            const betweenTime = Math.floor(diff / times[i].milliSeconds);
            // 큰 단위는 0보다 작은 소수 단위 나옴
            if (betweenTime > 0) {
                return betweenTime + ' ' + times[i].time  + ' 전';
            }
        }

        return "방금 전";
    }

    let cmtDate = document.querySelectorAll(".comment_header > span:nth-child(2)");
    cmtDate.forEach(
        e => e.innerHTML = elapsedTime(e.innerHTML)
    )
</script>
</body>
</html>

<jsp:include page="/WEB-INF/views/frame/footer.jsp"></jsp:include>
