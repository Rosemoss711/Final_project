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
            <link href="${pageContext.request.contextPath}/resources/css/board.css" rel="stylesheet" type="text/css">
            <title><c:out value="${etcMap.bigCategory}" /> - Comme</title>
        </head>

        <body>
                <jsp:include page="/WEB-INF/views/frame/header.jsp"></jsp:include>

            <div class="margin">
                <div class="row mt-5">
                    <div class="col">
                        <h5 style="display: inline-block; font-size: 17;"><a id="head" href="/board/toBoard?nowPage=1&seq_category=${etcMap.category}&category_name=${etcMap.category_name}"><strong>${etcMap.bigCategory}</strong> </a></h5>
                        <ul style="display: inline-block; margin-bottom: 0;">
                            <li><a class="category" href="/board/toBoard?nowPage=1&seq_category=${etcMap.category}&small_category=${etcMap.category}&category_name=${etcMap.category_name}" id="${etcMap.category}">공지</a></li>
                            <c:forEach items="${categoryMenu}" var="list">
                                <li><a class="category" href="/board/toBoard?nowPage=1&seq_category=${etcMap.category}&small_category=${list.seq_category}&category_name=${etcMap.category_name}" id="${list.seq_category}">${list.category_name}</a></li>
                            </c:forEach>
                        </ul>
                    
                    </div>
                </div>

                <!-- 게시물 뿌려주기 -->
                <div class="col">
                    <div class="col d-none d-md-block">
                        <table class="table table-hover">
                            <thead>
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
                                                <td><a class="tap" href="/board/toBoard?nowPage=1&seq_category=${etcMap.category}&small_category=${dto.SEQ_CATEGORY}&category_name=${etcMap.category_name}"> <!-- 카테고리 번호에 따라서 탭 뿌려주기 대분류는 공지로 변환 -->
                                                    <c:choose>
                                                       <c:when test="${dto.SEQ_CATEGORY eq etcMap.category}">
                                                        공지
                                                       </c:when>
                                                    
                                                       <c:otherwise>
                                                        ${dto.CATEGORY_NAME}
                                                       </c:otherwise>
                                                    </c:choose> </a></td>
                                                    <!-- 검색어가 존재하는지에 대한 여부에 따라 타이틀에 넘겨주는 정보를 달리함 이렇게 안하고 편하게 갈 수 잇엇을거 같은데 실수한듯 돌이키기는 좀 그럼 -->
                                                    <c:choose> 
                                                        <c:when test="${etcMap.search_type eq null}">
                                                                <td class="titleTd"><a href="/board/detailPost?nowPage=${paging.nowPage}&seq_board=${dto.SEQ_BOARD}&seq_category=${etcMap.category}&small_category=${etcMap.small_category}&category_name=${etcMap.category_name}" class="title">${dto.BOARD_TITLE}</a> 
                                                                <c:if test="${dto.CM_COUNT != 0}" > <!-- 댓글 수 체크해서 0개 보다 많을 때만 게시물 옆에 추가해줌 -->
                                                                <span style="font-size: 6px; font-weight: bold;">&nbsp;&nbsp;${dto.CM_COUNT}</span>
                                                                </c:if> </td>
                                                        </c:when>
                                                        <c:otherwise>
                                                                <td class="titleTd"><a href="/board/detailPost?nowPage=${paging.nowPage}&seq_board=${dto.SEQ_BOARD}&seq_category=${etcMap.category}&small_category=${etcMap.small_category}&search_type=${etcMap.search_type}&search_keyword=${etcMap.search_keyword}&category_name=${etcMap.category_name}" class="title">${dto.BOARD_TITLE}</a> 
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
                    <div class="row d-none d-md-flex">
                    	<!-- 검색박스부분 -->
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
                
                    <%-- sm사이즈 --%>
                    <div class="col d-md-none">
                        <table class="table tableSm table-hover">
                            <thead></thead>
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
                                                <td> 
                                                	<div class="col d-flex">
                                                		
                                                    <!-- 검색어가 존재하는지에 대한 여부에 따라 타이틀에 넘겨주는 정보를 달리함 이렇게 안하고 편하게 갈 수 잇엇을거 같은데 실수한듯 돌이키기는 좀 그럼 -->
                                                    <c:choose> 
                                                        <c:when test="${etcMap.search_type eq null}">
                                                        	<div class="col titleTd smContentHigh text-start">
                                                        		<i class="fa-regular fa-comment-dots"></i>&nbsp;
                                                        		<a href="/board/detailPost?nowPage=${paging.nowPage}&seq_board=${dto.SEQ_BOARD}&seq_category=${etcMap.category}&small_category=${etcMap.small_category}&category_name=${etcMap.category_name}" class="title">${dto.BOARD_TITLE}</a> 
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="col titleTd smContentHigh">
                                                            	<i class="fa-regular fa-comment-dots"></i>
                                                            	<a href="/board/detailPost?nowPage=${paging.nowPage}&seq_board=${dto.SEQ_BOARD}&seq_category=${etcMap.category}&small_category=${etcMap.small_category}&search_type=${etcMap.search_type}&search_keyword=${etcMap.search_keyword}&category_name=${etcMap.category_name}" class="title">${dto.BOARD_TITLE}</a> 
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    </div>
                                                    <div class="col d-flex">
                                                    	<div class="col-2 smContentRow">
                                                			<a class="tap" href="/board/toBoard?nowPage=1&seq_category=${etcMap.category}&small_category=${dto.SEQ_CATEGORY}&category_name=${etcMap.category_name}"> <!-- 카테고리 번호에 따라서 탭 뿌려주기 대분류는 공지로 변환 -->
                                                    			<c:choose>
                                                       				<c:when test="${dto.SEQ_CATEGORY eq etcMap.category}">
                                                        				공지
                                                       				</c:when>
                                                       				<c:otherwise>
                                                        				${dto.CATEGORY_NAME}
                                                       				</c:otherwise>
                                                    			</c:choose> 
                                                    		</a>
                                                    	</div>
                                                    	<span style="color: #dee2e6;">|</span>
                                                    	<div class="col-3 smContentRow">${dto.WRITER_NICKNAME}</div>
                                                    	<span style="color: #dee2e6;">|</span>
                                                		<div class="col-2 smContentRow"><fmt:formatDate value="${dto.WRITTEN_DATE}" pattern="yy.MM.dd"/></div>
                                                		<span style="color: #dee2e6;">|</span>
                                                		<div class="col-2 smContentRow">
                                                			댓글&nbsp;:&nbsp;
                                                			<c:choose>
                                                				<c:when test="${dto.CM_COUNT != 0}">
                                                					<span style="font-size: 6px; font-weight: bold;">${dto.CM_COUNT}</span>
                                                				</c:when>
                                                				<c:otherwise>
                                                					<span style="font-size: 6px; font-weight: bold;">0</span>
                                                				</c:otherwise>
                                                			</c:choose>
                                                        </div>
                                                        <span style="color: #dee2e6;">|</span>
                                                		<div class="col-2 smContentRow">조회수&nbsp;:&nbsp;${dto.VIEW_COUNT}</div>
                                                	</div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                   </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row d-md-none">
                    <!-- 검색박스부분 -->
                    <div class="col">
                        <form action="/board/toBoard" method="get">
                        <span class="searchBoxSm" id="seachSelectSm">
                            <select name="search_type" id="search_type">
                                <option value="board_title">제목</option>
                                <option value="board_content">내용</option>
                                <option value="writer_nickname">닉네임</option>
                            </select>
                            <c:if test="${small_category != 0}" >
                            	<input type="hidden" name="small_category" value="${etcMap.small_category}">
                        	</c:if>
                        </span>
                        <span class="searchBoxSm" id="searchInputSm">
                            <input type="text" name="search_keyword" id="search" value="${etcMap.search_keyword}" style="width:100px;">
                            <button type="submit" id="searchBtn" value="${etcMap.category}" name="seq_category"><i class="fa-solid fa-magnifying-glass"></i></button>
                        </span>
                        </form>
                    </div>
                    <c:if test="${not empty loginSession}" >
                        <div class="col">
                            <button type="button" id="write" ><i class="fa-solid fa-pen"></i>  쓰기</button>
                        </div>
                    </c:if>
                </div>
                <!-- 페이지네이션 이녀석도 마찬가지로 검색 유무에 따라서 길에 주소로 정보를 보냇는데.. 흠 더러워 진걸 보니 100% 옳은 방향은 아닌듯 -->
                <div class="page_wrap mb-5 mt-5">
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
        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/board.js"></script>
        </html>