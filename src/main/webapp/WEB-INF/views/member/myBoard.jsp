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
            <title>내 글 - Comme</title>
        </head>
        <style>
            #profileTap {
                list-style: none;
                font-size: 15px;
                padding: 0;
            }

            #profileTap li{
                text-align: center;
                float: left;
                border: 1px solid lightgray;
            }

            #profileTap li a{
                color: black;
                display: inline-block;
                padding: 7px 7px 7px 7px;
                min-width: 70px;
                text-decoration: none;
            }

            #profileTap li a:hover{
                background-color: rgb(98, 188, 240);
                color: white;
                text-decoration: none;
            }

            #boardInfo{
                font-size: 15px;
            }
            #boardBox table{
                text-align: center;
                font-size: 13px;
            }

            #boardBox a{
                color: black;
                text-decoration: none;
            }

            #boardBox a:hover{
                text-decoration: underline;
            }

            .written_date,
            .seq_board,
            .view_count{
                color: #777;
            }
            
            .table{
            	table-layout: fixed;
            }
            
            .titleTd, .seqBoard, .replyCnt, .view_count, .written_date {
            	text-overflow: ellipsis;
    			overflow: hidden;
    			white-space: nowrap;
    			text-align: start;
            }
            
			.categoryName {
				float: left;
			}
			
            th.col-2.profileTap{
                background-color: #f9f9f9;
            }

            .searchBox{
                border: 1px solid lightgray; 
                display: inline-block; 
                border-radius: 2px;
                height: 28px;
                /* width: 140px; */
            }

            #search, #searchBtn, #search_type{
                position: relative;
                top: 0;
                border-style: none;
                background-color: white;
                font-size: 13px;
            }
            
            #search{
                width: 140px;
            }

            #modifyBtn,
            #updatePwBtn,
            #deleteBtn{
                float: right;
                color: black;
                border: 1px solid lightgray;
                background-color: white;
                border-radius: 2px;
                padding: 5px;
                font-size: 13px;
            }

            #modifyBtn,
            #updatePwBtn{
                margin-right: 10px;
            }

            /* 페이지네이션 */
            .page_wrap {
                text-align: center;
            }

            .page_nation {
                display: inline-block;
            }


            .page_nation a:not(#first):not(#last)  {
                display: block;
                margin: 0 3px;
                float: left;
                width: 28px;
                height: 28px;
                line-height: 28px;
                font-size: 13px;
                color: #999;
                text-decoration: none;
            }

            .page_nation a:hover{
                background-color: #f9f9f9; 
                color: #555; 
                border: 1px solid #aaa; 
                border-radius: 2px;
            }

            .tap:hover{
                text-decoration: underline;
            }

            #first, #last{
                color: black;
                display: block;
                margin: 0 3px;
                float: left;
                line-height: 28px;
                font-size: 13px;
                text-decoration: none;
            }

            #boardBox,
            #tapBox,
            #searchBox{
                margin: 0 12vw 0 12vw;
            }

        </style>

        <body>
                <!-- header -->
                <jsp:include page="/WEB-INF/views/frame/header.jsp"></jsp:include>

                <div class="row mt-5" id="tapBox">
                    <div class="col">
                        <ul id="profileTap">
                            <li><a href="/member/toMyPage">회원정보</a></li>
                            <c:choose>
                               <c:when test="${loginSession.member_grade eq 2}">
                                    <li><a href="/member/toShelterVolList">봉사 신청 관리</a></li>
                                    <li><a href="/member/toMyBoard">내 글</a></li>
                                    <li><a href="/member/toMyComment">내 댓글</a></li>
                                    <li><a href="/member/toMySupport">후원 글 조회</a></li>
                                    <li><a href="/member/toMyPay">후원 내역 조회</a></li>
                               </c:when>
                               <c:when test="${loginSession.member_grade eq 4}">
                                    <li><a href="/admin/memberList?curPage=1">전체 회원 목록</a></li>
                                    <li><a href="/admin/toBlackList?curPage=1">블랙리스트 관리</a></li>
                                    <li><a href="/admin/toInquiryList?seq_category=${inquiry.seq_category}">문의/신고</a></li>
                                    <li><a href="/admin/toCategoryCM">카테고리 관리</a></li>
                                    <li><a href="/member/toMyBoard">내 글</a></li>
                                    <li><a href="/member/toMyComment">내 댓글</a></li>
                                    <li><a href="/admin/toAllPay">사용자 후원 내역 조회</a></li>
                               </c:when>
                               
                               <c:otherwise>
                                    <li><a href="/member/toCheckVol">봉사 신청 확인</a></li>
                                    <li><a href="/member/toMyBoard">내 글</a></li>
                                    <li><a href="/member/toMyComment">내 댓글</a></li>
                                    <li><a href="/member/toMyPayList">후원 내역 조회</a></li>
                               </c:otherwise>
                            </c:choose>
                            <li><a href="#" id="return">돌아가기</a></li>
                        </ul>
                    </div>
                </div>

                <div class="row mt-3" id="boardBox">
                    <div class="col">

                        <h3>
                            <span id="boardInfo"><i class="fa-solid fa-book"></i>  &nbsp;내 글 보기</span>
                        </h3>
						<div class="col d-none d-md-block">
                        <table class="table table-hover">
                            <thead style="border-top: 1px solid lightgray;">
                                <tr>
                                    <th scope="col" class="col-1">번호</th>
                                    <th scope="col" class="col-2">대상 게시판</th>
                                    <th scope="col" class="col-6">제목</th>
                                    <th scope="col" class="col-1">조회</th>
                                    <th scope="col" class="col-2">날짜</th>
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
                                                <td class="seq_board">${dto.SEQ_BOARD}</td>
                                                <td>
                                                <c:choose>
                                                   <c:when test="${dto.CATEGORY_NAME eq '문의'}">
                                                    <a class="tap" href="/board/toBoard?nowPage=1&seq_category=${dto.CATEGORY_PK}&small_category=${dto.SEQ_CATEGORY}&category_name=${dto.CATEGORY_NAME}"> 
                                                   </c:when>
                                                    <c:when test="${dto.CATEGORY_PK eq null}" >
                                                    <a class="tap" href="/board/toBoard?nowPage=1&seq_category=${dto.SEQ_CATEGORY}&small_category=${dto.SEQ_CATEGORY}"> 
                                                    </c:when>

                                                   <c:otherwise>
                                                    <a class="tap" href="/board/toBoard?nowPage=1&seq_category=${dto.CATEGORY_PK}&small_category=${dto.SEQ_CATEGORY}"> 
                                                   </c:otherwise>
                                                </c:choose>

                                                    <c:choose>
                                                       <c:when test="${dto.CATEGORY_PK eq null}">
                                                        공지
                                                       </c:when>
                                                    
                                                       <c:otherwise>
                                                        ${dto.CATEGORY_NAME}
                                                       </c:otherwise>
                                                    </c:choose> </a></td>

                                                <td id="titleTd">
                                                <c:choose>
                                                   <c:when test="${dto.CATEGORY_NAME eq '문의'}">
                                                   <a href="/board/detailPost?nowPage=1&seq_board=${dto.SEQ_BOARD}&seq_category=${dto.CATEGORY_PK}&category_name=${dto.CATEGORY_NAME}">${dto.BOARD_TITLE}</a>
                                                   </c:when>
                                                   <c:when test="${dto.CATEGORY_PK eq null}" >
                                                   <a href="/board/detailPost?nowPage=1&seq_board=${dto.SEQ_BOARD}&seq_category=${dto.SEQ_CATEGORY}">${dto.BOARD_TITLE}</a>
                                                   </c:when>
                                                
                                                   <c:otherwise>
                                                   <a href="/board/detailPost?nowPage=1&seq_board=${dto.SEQ_BOARD}&seq_category=${dto.CATEGORY_PK}">${dto.BOARD_TITLE}</a>
                                                   </c:otherwise>
                                                </c:choose>

                                                    <c:if test="${dto.CM_COUNT != 0}" > <!-- 댓글 수 체크해서 0개 보다 많을 때만 게시물 옆에 추가해줌 -->
                                                        <span style="font-size: 6px; font-weight: bold;"> &nbsp;&nbsp;${dto.CM_COUNT}</span>
                                                    </c:if> </td>
                                                <td class="view_count">${dto.VIEW_COUNT}</td>
                                                <td class="written_date"><fmt:formatDate value="${dto.WRITTEN_DATE}" pattern="yyyy-MM-dd"/></td>
                                            </tr>
                                        </c:forEach>
                                   </c:otherwise>
                                </c:choose>
                                
                            </tbody>
                        </table>
                        </div>
                        <%-- sm사이즈 --%>
                        <table class="table d-md-none table-hover">
                            <thead style="border-top: 1px solid lightgray;">
                                <tr>
                                    <th scope="col" class="col-1">내 글 목록</th>
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
                                            <tr class="smContentRow">
                                                <td class="seq_board">
                                                	<div class="col-3 categoryName">
                                                		<c:choose>
                                                   			<c:when test="${dto.CATEGORY_NAME eq '문의'}">
                                                    			<a class="tap" href="/board/toBoard?nowPage=1&seq_category=${dto.CATEGORY_PK}&small_category=${dto.SEQ_CATEGORY}&category_name=${dto.CATEGORY_NAME}"> 
                                                   			</c:when>
                                                    		<c:when test="${dto.CATEGORY_PK eq null}" >
                                                    			<a class="tap" href="/board/toBoard?nowPage=1&seq_category=${dto.SEQ_CATEGORY}&small_category=${dto.SEQ_CATEGORY}"> 
                                                    		</c:when>
                                                   			<c:otherwise>
                                                    			<a class="tap" href="/board/toBoard?nowPage=1&seq_category=${dto.CATEGORY_PK}&small_category=${dto.SEQ_CATEGORY}"> 
                                                   			</c:otherwise>
                                                		</c:choose>
                                                    	<c:choose>
                                                       		<c:when test="${dto.CATEGORY_PK eq null}">
                                                        		공지
                                                       		</c:when>
                                                       		<c:otherwise>
                                                        		${dto.CATEGORY_NAME}
                                                       		</c:otherwise>
                                                    	</c:choose> </a></div>
                                                	<div class="col titleTd">
                                                	<span style="color: #dee2e6;">|</span>
                                                		<c:choose>
                                                   			<c:when test="${dto.CATEGORY_NAME eq '문의'}">
                                                   				<a href="/board/detailPost?nowPage=1&seq_board=${dto.SEQ_BOARD}&seq_category=${dto.CATEGORY_PK}&category_name=${dto.CATEGORY_NAME}">${dto.BOARD_TITLE}</a>
                                                   			</c:when>
                                                   			<c:when test="${dto.CATEGORY_PK eq null}" >
                                                   				<a href="/board/detailPost?nowPage=1&seq_board=${dto.SEQ_BOARD}&seq_category=${dto.SEQ_CATEGORY}">${dto.BOARD_TITLE}</a>
                                                   			</c:when>
                                                   			<c:otherwise>
                                                   				<a href="/board/detailPost?nowPage=1&seq_board=${dto.SEQ_BOARD}&seq_category=${dto.CATEGORY_PK}">${dto.BOARD_TITLE}</a>
                                                   			</c:otherwise>
                                                		</c:choose>
                                                	</div>
                                                    <div class="smContentRow d-flex">
                                                    	<div class="col-3 seqBoard">글번호&nbsp;:&nbsp;${dto.SEQ_BOARD}</div>
														<span style="color: #dee2e6;">|</span>
														<c:choose>
                                                    	<c:when test="${dto.CM_COUNT != 0}" > <!-- 댓글 수 체크해서 0개 보다 많을 때만 게시물 옆에 추가해줌 -->
                                                        	<div class="col-3 replyCnt"><span>댓글&nbsp;:&nbsp;${dto.CM_COUNT}</span></div>
                                                    	</c:when> 
                                                    	<c:otherwise>
                                                    		<div class="col-3 replyCnt">댓글&nbsp;:&nbsp;0</div>
                                                    	</c:otherwise>
                                                    	</c:choose>
                                                		<span style="color: #dee2e6;">|</span>
                                                		<div class="col-3 view_count">조회수&nbsp;:&nbsp;${dto.VIEW_COUNT}</div>
                                                		<span style="color: #dee2e6;">|</span>
                                                		<div class="col-3 written_date"><fmt:formatDate value="${dto.WRITTEN_DATE}" pattern="yy-MM-dd"/></div>
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

                <div class="row" id="searchBox">
                    <!-- 검색박스부분 -->
                    <div class="col mb-2">
                        <form action="/member/toMyBoard" method="get">
                        <span class="searchBox">
                            <input type="text" name="search_keyword" id="search" value="${etcMap.search_keyword}">
                            <button type="submit" id="searchBtn"><i class="fa-solid fa-magnifying-glass"></i></button>
                        </span>
                        <span class="searchBox">
                            <select name="search_type" id="search_type">
                                <option value="board_title">제목</option>
                                <option value="board_content">내용</option>
                            </select>
                        </span>
                        </form>
                    </div>
                </div>

                <div class="page_wrap mb-5">
                    <div  class="page_nation">	
                        <c:choose>
                           <c:when test="${etcMap.search_type eq null}">
                                <c:if test="${paging.startPage!=1}" >
                                    <a id="first" href="/member/toMyBoard?nowPage=1">첫 페이지</a>
                                    <a class="arrow left" href="/member/toMyBoard?nowPage=${paging.startPage-1}">&lt;</a>
                                </c:if>	
                                <c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p" step="1">
                                    <a href="/member/toMyBoard?nowPage=${p}"
                                        class="paging">${p}</a>
                                </c:forEach>
                                <c:if test="${paging.endPage != paging.lastPage}">
                                    <a class="arrow right" href="/member/toMyBoard?nowPage=${paging.endPage+1}">&gt;</a>
                                    <a id="last" href="/member/toMyBoard?nowPage=${paging.lastPage}">끝 페이지</a>
                                </c:if>
                           </c:when>
                           <c:otherwise>
                                <c:if test="${paging.startPage!=1}" >
                                    <a id="first" href="/member/toMyBoard?nowPage=1&search_type=${etcMap.search_type}&search_keyword=${etcMap.search_keyword}">첫 페이지</a>
                                    <a class="arrow left" href="/member/toMyBoard?nowPage=${paging.startPage-1}&search_type=${etcMap.search_type}&search_keyword=${etcMap.search_keyword}">&lt;</a>
                                </c:if>	
                                <c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p" step="1">
                                    <a href="/member/toMyBoard?nowPage=${p}&search_type=${etcMap.search_type}&search_keyword=${etcMap.search_keyword}"
                                        class="paging">${p}</a>
                                </c:forEach>
                                <c:if test="${paging.endPage != paging.lastPage}">
                                    <a class="arrow right" href="/member/toMyBoard?nowPage=${paging.endPage+1}&search_type=${etcMap.search_type}&search_keyword=${etcMap.search_keyword}">&gt;</a>
                                    <a id="last" href="/member/toMyBoard?nowPage=${paging.lastPage}&search_type=${etcMap.search_type}&search_keyword=${etcMap.search_keyword}">끝 페이지</a>
                                </c:if>
                           </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- footer -->
	            <jsp:include page="/WEB-INF/views/frame/footer.jsp"></jsp:include>
				<!-- 탑버튼 -->
				<jsp:include page="/WEB-INF/views/frame/topButton.jsp"/>

        </body>
        <script>
            const select = '${etcMap.search_type}';
            const option = document.querySelectorAll('#search_type option');
            option.forEach(option=>{
                if(option.value === select){
                    option.selected = true;
                }
            })

            /* 현재 머물고 있는 페이지에 대한 표시 이벤트 */
            const active = document.getElementsByClassName('paging');
            for (let i = 0; i < active.length; i++) {
                if (active[i].innerText == '${paging.nowPage}') {
                    active[i].style.cssText = "background-color: #f9f9f9; color: #555; border: 1px solid #aaa; border-radius: 2px";
                }
            };

            let referrer = document.referrer;

            if (referrer.indexOf('toMyPage') < 0 && referrer.indexOf('toShelterVolList') < 0 && referrer.indexOf('toMyBoard') < 0 && referrer.indexOf('toMyComment') < 0 &&
                referrer.indexOf('toMySupport') < 0 && referrer.indexOf('toMyPay') < 0 && referrer.indexOf('memberList') < 0 && referrer.indexOf('toBlackList') < 0 && referrer.indexOf('toInquiryList') < 0
                && referrer.indexOf('toCategoryCM') < 0 && referrer.indexOf('toAllPay') < 0 && referrer.indexOf('toCheckVol') < 0 && referrer.indexOf('toMyPayList') < 0
                && referrer.indexOf('toSignup_business') < 0 && referrer.indexOf('toSingup_general') < 0){
                sessionStorage.setItem("referrer", document.referrer);
            }

            document.getElementById('return').addEventListener('click', () =>{
                let referrer = sessionStorage.getItem('referrer');
                sessionStorage.removeItem("referrer"); 
                location.href = referrer || '/';
            })
        </script>

        </html>