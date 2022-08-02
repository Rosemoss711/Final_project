<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <script src="https://code.jquery.com/jquery-3.6.0.js"
                integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
                integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
                crossorigin="anonymous">
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
                crossorigin="anonymous"></script>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
            <link href="${pageContext.request.contextPath}/resources/css/detailPost.css" rel="stylesheet" type="text/css">
            <title><c:out value="${post.board_title}" /> - <c:out value="${post.category_name}" /></title>
        </head>
        <body>

                <!-- header -->
		        <jsp:include page="/WEB-INF/views/frame/header.jsp"></jsp:include>
            <div class="margin">
                <div class="row mt-3">
                    <div class="col"> <!-- 상단에 큰 분류 카테고리 이름이랑 소분류 카테고리 출력 -->
                        <span style="font-size: 17px;"><a id="head" href="/board/toBoard?nowPage=1&seq_category=${etcMap.category}&category_name=${etcMap.category_name}" style="color: #555;"><strong>${etcMap.bigCategory}</strong> </a></span>
                        <span style="margin-left: 10px; padding: 0 10px 0 10px ;border-left: 1px solid lightgray; border-right: 1px solid lightgray;">
                            <a id="tap" href="/board/toBoard?nowPage=1&seq_category=${etcMap.category}&small_category=${post.seq_category}&category_name=${etcMap.category_name}">
                                <c:choose>
                                   <c:when test="${post.seq_category eq etcMap.category}">
                                    공지
                                   </c:when>
                                
                                   <c:otherwise>
                                    ${post.category_name}
                                   </c:otherwise>
                                </c:choose> </a>
                        </span>
                    </div>
                </div>

                <div class="row mt-2" style="margin-left: 0px;">
                    <div class="col postBar"> <!-- 글 제목이랑 시간 나타내기 -->
                        <span id="title"><strong><c:out value="${post.board_title}" /> </strong></span>
                        <span class="postInfo"><fmt:formatDate value="${post.written_date}" pattern="yyyy.MM.dd HH:mm"/></span>
                    </div>
                    
                </div>

                <div class="row" style="margin-left: 0px;">
                    <div class="col postBar2"> <!-- 조회 수랑 댓글 수 나타내기 -->
                        <span style="font-size: 12px;">${post.writer_nickname}</span>
                        <span class="postInfo">댓글 <strong id="commentNum2">${post.cm_count}</strong>  </span>
                        <span class="postInfo">조회 수 <strong>${post.view_count}</strong> </span>
                    </div>
                </div>

                <div class="row mt-3 mb-5" style="padding-left: 10px;"> <!-- 게시물 내용 -->
                    <div class="col" style="font-size: 13px;">
                        <c:out value="${post.board_content}" escapeXml="false" />
                    </div>
                </div>

                <div class="row mb-4 mt-5">
                    <div class="col pb-3" style="text-align: center; border-bottom: 1px solid lightgray; margin: 0 12px 0 12px;">
                        <button type="button" id="listBtn">목록으로 </button>
                    </div>
                </div>

                <div class="row" id>
                    <c:if test="${loginSession.member_id eq post.member_id || loginSession.member_grade eq 4}" >
                        <div class="col"> <!-- 게시물 수정 삭제 버튼 -->
                            <button type="button" id="removePost"><i class="fa-solid fa-xmark"></i>  삭제</button>
                            <button type="button" id="modifyPost"><i class="fa-solid fa-pen"></i>  수정</button>
                        </div>
                    </c:if>
                </div>

                <c:if test="${post.cm_count != 0}" > <!-- 댓글이 존재할 시 나오는 댓글갯수 나타내는 박스 -->
                    <div class="row mt-5" >
                        <div class="col" id="replyNumDiv">
                            댓글 <strong id="commentNum">${post.cm_count}</strong>  개
                        </div>
                    </div>
                </c:if>
                
                <!-- 게시물에 해당하는 댓글이 존재할시 뿌려줌 -->
                <div class="row" id="commentList">
                    <c:choose> 
                        <c:when test="${post.cm_count == 0}">
                        </c:when>
                        
                        <c:otherwise>
                        <c:forEach items="${comment}" var="list">
                                <div class="col-12 commentBox">
                                    <p class="comment_Nk">${list.comment_nickname}   <span class="comment_Date" >${list.comment_date}</span> 
                                        <c:if test="${loginSession.member_id eq list.comment_id || loginSession.member_grade eq 4}" >
                                            <button type="button" class="comment_delete" value="${list.seq_comment}"><i class="fa-solid fa-eraser"></i> 삭제</button>
                                            <button type="button" class="comment_modify" value="${list.seq_comment}"><i class="fa-solid fa-pen"></i>  수정</button> 
                                        </c:if>
                                    </p>
                                    <p class="comment_content"><c:out value="${list.comment_content}" /></p>
                                </div>
                        </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>

                
                <!-- 댓글 쓰는거 인풋 히든으로 글번호 보내줌 -->
                <div class="row mt-4" id="replyWrite">
                    <div class="col-12"> 
                        <label for="comment_content" style="margin-bottom: 10px;">
                            <strong>댓글 쓰기</strong> </label>
                    </div>
                    <div class="col-11">
                        <form id="commentForm">
                            <input type="hidden" id="seq_board" name="seq_board" value="${post.seq_board}">
                            <c:choose>
                               <c:when test="${empty loginSession}">
                                    <p id="loginComment">댓글 작성 하시려면 로그인 해주세요. 로그인 하시겠습니까?</p>
                               </c:when>
                            
                               <c:otherwise>
                                    <textarea name="comment_content" id="comment_content" placeholder="회원 간의 불편함을 주는 댓글은 자제해주시고 따뜻한 댓글 부탁드립니다."></textarea>
                               </c:otherwise>
                            </c:choose>
                        </form>
                    </div>
                    <div class="col-1"  style="text-align: center; padding: 0; ">
                        <button type="button" id="registerBtn">등록</button>
                    </div>
                </div>

                <div class="row mt-3">
                    <div class="col"> <!-- 이하부터는 board.jsp 그대로 출력하는거라서 주석 안달음 -->
                        <h5 style="display: inline-block; font-size: 17;"><a id="head" href="/board/toBoard?nowPage=1&seq_category=${etcMap.category}&category_name=${etcMap.category_name}"><strong>${etcMap.bigCategory}</strong> </a></h5>
                        <ul style="display: inline-block; margin-bottom: 0;">
                            <li><a class="category" href="/board/toBoard?nowPage=1&seq_category=${etcMap.category}&small_category=${etcMap.category}&category_name=${etcMap.category_name}" id="${etcMap.category}">공지</a></li>
                            <c:forEach items="${categoryMenu}" var="list">
                                <li><a class="category" href="/board/toBoard?nowPage=1&seq_category=${etcMap.category}&small_category=${list.seq_category}&category_name=${etcMap.category_name}" id="${list.seq_category}">${list.category_name}</a></li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>

                <div class="row">
                    <div class="col">
                        <table class="table table-hover">
                            <thead style="border-top: 1px solid lightgray;">
                                <tr>
                                    <th scope="col" class="col-2">탭</th>
                                    <th scope="col" class="col-6">제목</th>
                                    <th scope="col" class="col-2">글쓴이</th>
                                    <th scope="col" class="col-1">날짜</th>
                                    <th scope="col" class="col-1">조회</th>
                                </tr>
                            </thead>
                            <tbody>
        
                                <c:choose>
                                   <c:when test="${empty list}">
                                    <tr>
                                        <td colspan="5">등록 된 글이 없습니다.</td>
                                    </tr>
                                   </c:when>
                                   
                                   <c:otherwise>
                                        <c:forEach items="${list}" var="dto">
                                            <tr>
                                                <td><a class="tap" href="/board/toBoard?nowPage=1&seq_category=${etcMap.category}&small_category=${dto.SEQ_CATEGORY}&category_name=${etcMap.category_name}">
                                                    <c:choose>
                                                       <c:when test="${dto.SEQ_CATEGORY eq etcMap.category}">
                                                        공지 
                                                       </c:when>
                                                    
                                                       <c:otherwise>
                                                        ${dto.CATEGORY_NAME}
                                                       </c:otherwise>
                                                    </c:choose> </a></td>
                                                    <c:choose>
                                                        <c:when test="${etcMap.search_type eq null}">
                                                                <td><a href="/board/detailPost?nowPage=${paging.nowPage}&seq_board=${dto.SEQ_BOARD}&seq_category=${etcMap.category}&small_category=${etcMap.small_category}&category_name=${etcMap.category_name}" class="title">${dto.BOARD_TITLE}</a> 
                                                                <c:if test="${dto.CM_COUNT != 0}" >
                                                                <span style="font-size: 6px; font-weight: bold;">&nbsp;&nbsp;${dto.CM_COUNT}</span>
                                                                </c:if> </td>
                                                        </c:when>
                                                        <c:otherwise>
                                                                <td><a href="/board/detailPost?nowPage=${paging.nowPage}&seq_board=${dto.SEQ_BOARD}&seq_category=${etcMap.category}&small_category=${etcMap.small_category}&search_type=${etcMap.search_type}&search_keyword=${etcMap.search_keyword}&category_name=${etcMap.category_name}" class="title">${dto.BOARD_TITLE}</a> 
                                                                <c:if test="${dto.CM_COUNT != 0}" >
                                                                <span style="font-size: 6px; font-weight: bold;">&nbsp;&nbsp;${dto.CM_COUNT}</span>
                                                                </c:if> </td>
                                                        </c:otherwise>
                                                    </c:choose>
                                                <td>${dto.WRITER_NICKNAME}</td>
                                                <td><fmt:formatDate value="${dto.WRITTEN_DATE}" pattern="yyyy.MM.dd"/></td>
                                                <td>${dto.VIEW_COUNT}</td>
                                            </tr>
                                        </c:forEach>
                                   </c:otherwise>
                                </c:choose>
                                
                            </tbody>
                        </table>
                    </div>
                </div>
            

                <div class="row">
                    <div class="col">
                        <form action="/board/toBoard" method="get">
                        <span class="searchBox">
                            <input type="text" name="search_keyword" id="search" value="${etcMap.search_keyword}">
                            <button type="submit" id="searchBtn" value="${etcMap.category}" name="seq_category"><i class="fa-solid fa-magnifying-glass"></i></button>
                        </span>
                        <span class="searchBox">
                            <select name="search_type" id="search_type">
                                <option value="board_title">제목</option>
                                <option value="board_content">내용</option>
                                <option value="writer_nickname">닉네임</option>
                            </select>
                        </span>
                        <c:if test="${small_category != 0}" >
                            <input type="hidden" name="small_category" value="${etcMap.small_category}">
                        </c:if>
                        </form>
                    </div>
                    <c:if test="${not empty loginSession}" >
                        <div class="col">
                            <button type="button" id="write" ><i class="fa-solid fa-pen"></i>  쓰기</button>
                        </div>
                    </c:if>
                </div>

                <div class="page_wrap mb-5">
                    <div  class="page_nation">	
                        <c:choose>
                           <c:when test="${etcMap.search_type eq null}">
                                <c:if test="${paging.startPage!=1}" >
                                    <a id="first" href="/board/toBoard?nowPage=1&seq_category=${etcMap.category}&small_category=${etcMap.small_category}&category_name=${etcMap.category_name}">첫 페이지</a>

                                    <a class="arrow left" href="/board/toBoard?nowPage=${paging.startPage-1}&seq_category=${etcMap.category}&small_category=${etcMap.small_category}&category_name=${etcMap.category_name}">&lt;</a>
                                </c:if>	
                                <c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p" step="1">
                                    <a href="/board/toBoard?nowPage=${p}&seq_category=${etcMap.category}&small_category=${etcMap.small_category}&category_name=${etcMap.category_name}"
                                        class="paging">${p}</a>
                                </c:forEach>
                                <c:if test="${paging.endPage != paging.lastPage}">
                                    <a class="arrow right" href="/board/toBoard?nowPage=${paging.endPage+1}&seq_category=${etcMap.category}&small_category=${etcMap.small_category}&category_name=${etcMap.category_name}">&gt;</a>

                                    <a id="last" href="/board/toBoard?nowPage=${paging.lastPage}&seq_category=${etcMap.category}&small_category=${etcMap.small_category}&category_name=${etcMap.category_name}">끝 페이지</a>
                                </c:if>
                           </c:when>
                           <c:otherwise>
                                <c:if test="${paging.startPage!=1}" >
                                    <a id="first" href="/board/toBoard?nowPage=1&seq_category=${etcMap.category}&small_category=${etcMap.small_category}&search_type=${etcMap.search_type}&search_keyword=${etcMap.search_keyword}&category_name=${etcMap.category_name}">첫 페이지</a>

                                    <a class="arrow left" href="/board/toBoard?nowPage=${paging.startPage-1}&seq_category=${etcMap.category}&small_category=${etcMap.small_category}&search_type=${etcMap.search_type}&search_keyword=${etcMap.search_keyword}&category_name=${etcMap.category_name}">&lt;</a>
                                </c:if>	
                                <c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p" step="1">
                                    <a href="/board/toBoard?nowPage=${p}&seq_category=${etcMap.category}&small_category=${etcMap.small_category}&search_type=${etcMap.search_type}&search_keyword=${etcMap.search_keyword}&category_name=${etcMap.category_name}"
                                        class="paging">${p}</a>
                                </c:forEach>
                                <c:if test="${paging.endPage != paging.lastPage}">
                                    <a class="arrow right" href="/board/toBoard?nowPage=${paging.endPage+1}&seq_category=${etcMap.category}&small_category=${etcMap.small_category}&search_type=${etcMap.search_type}&search_keyword=${etcMap.search_keyword}&category_name=${etcMap.category_name}">&gt;</a>

                                    <a id="last" href="/board/toBoard?nowPage=${paging.lastPage}&seq_category=${etcMap.category}&small_category=${etcMap.small_category}&search_type=${etcMap.search_type}&search_keyword=${etcMap.search_keyword}&category_name=${etcMap.category_name}">끝 페이지</a>
                                </c:if>
                           </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

                	<!-- footer -->
	            <jsp:include page="/WEB-INF/views/frame/footer.jsp"></jsp:include>


            <!--top버튼-->
	        <a id="topBtn"><img src="/resources/mainImg/DIEALRIGHT.png"></a>
        </body>
        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/detailPost.js"></script>

        </html>