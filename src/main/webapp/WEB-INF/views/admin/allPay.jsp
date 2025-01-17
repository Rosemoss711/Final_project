<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
            <title>전체 후원 내역 - Comme</title>
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
            
            table {
            	table-layout: fixed;
            }
            
            .contentSm {
            	text-align: start;
            }
            
            .contentSm div {
            	text-overflow: ellipsis;
    			overflow: hidden;
    			white-space: nowrap;
            }

            #boardInfo{
                font-size: 15px;
            }
            #boardBox table{
                text-align: center;
                font-size: 12px;
            }

            #boardBox a{
                color: black;
                text-decoration: none;
            }

            #boardBox a:hover{
                text-decoration: underline;
            }

            .pay_date,
            .seq_board,
            .seq_pay{
                color: #777;
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
            <div>
                <!-- header -->
                <jsp:include page="/WEB-INF/views/frame/header.jsp"></jsp:include>

                <div class="row mt-5" id="tapBox">
                    <div class="col">
                        <ul id="profileTap">
                            <li><a href="/member/toMyPage">회원정보</a></li>
                            <li><a href="/admin/memberList?curPage=1">전체 회원 목록</a></li>
                            <li><a href="/admin/toBlackList?curPage=1">블랙리스트 관리</a></li>
                            <li><a href="/admin/toInquiryList?seq_category=${inquiry.seq_category}">문의/신고</a></li>
                            <li><a href="/admin/toCategoryCM">카테고리 관리</a></li>
                            <li><a href="/member/toMyBoard">내 글</a></li>
                            <li><a href="/member/toMyComment">내 댓글</a></li>
                            <li><a href="/admin/toAllPay">사용자 후원 내역 조회</a></li>
                            <li><a href="#" id="return">돌아가기</a></li>
                        </ul>
                    </div>
                </div>

                <div class="row mt-3" id="boardBox">
                    <div class="col">

                        <h3>
                            <span id="boardInfo"><i class="fa-solid fa-book"></i>  &nbsp;후원 내역 조회</span>
                        </h3>
						<div class="d-none d-md-block">
                        <table class="table table-hover">
                            <thead style="border-top: 1px solid lightgray;">
                                <tr>
                                    <th scope="col" class="col-1">결제 번호</th>
                                    <th scope="col" class="col-1">글 번호</th>
                                    <th scope="col" class="col-2">회원아이디</th>
                                    <th scope="col" class="col-2">금액</th>
                                    <th scope="col" class="col-2">보호소명</th>
                                    <th scope="col" class="col-2">보호소아이디</th>
                                    <th scope="col" class="col-2">날짜</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                   <c:when test="${empty list}">
                                    <tr>
                                        <td colspan="7">후원 내역이 없습니다.</td>
                                    </tr>
                                   </c:when>
                                
                                   <c:otherwise>
                                        <c:forEach items="${list}" var="dto">
                                            <tr>
                                                <td class="seq_pay">${dto.SEQ_PAY}</td>
                                                <td><a class="tap" href="/supportBoard/view?nowPage=1&seq_board=${dto.SEQ_BOARD}">${dto.SEQ_BOARD}</a></td>
                                                <td class="member_id">${dto.MEMBER_ID}</td>
                                                <td data-value="${dto.PAY_MONEY}" class="payMoney">&#8361;<fmt:formatNumber type="number" maxFractionDigits="3" value="${dto.PAY_MONEY}" /></td>
                                                <td class="member_id">${dto.WRITER_NICKNAME}</td>
                                                <td class="member_id">${dto.SHELTER_ID}</td>
                                                <td class="pay_date"><fmt:formatDate value="${dto.PAY_DATE}" pattern="yyyy-MM-dd"/></td>
                                            </tr>
                                        </c:forEach>
                                   </c:otherwise>
                                </c:choose>

                                <c:if test="${fn:length(etcMap.search_keyword) > '0' && !empty list}" >
                                    <tr style="border-top: 2px solid black;">
                                        <td colspan="7" id="totalMoney">총 금액&nbsp; : &nbsp; &#8361;</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                        </div>
                        <div class="d-md-none">
                        <table class="table table-hover">
                            <thead style="border-top: 1px solid lightgray;">
                                <tr>
                                    <th scope="col" class="col-1">후원 목록</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                   <c:when test="${empty list}">
                                    <tr>
                                        <td colspan="7">후원 내역이 없습니다.</td>
                                    </tr>
                                   </c:when>
                                
                                   <c:otherwise>
                                        <c:forEach items="${list}" var="dto">
                                            <tr>
                                            	<td>
                                            		<div class="contentSm d-flex">
                                                		<div class="col-4 seq_pay">결제번호&nbsp;:&nbsp;${dto.SEQ_PAY}</div>
                                                		<span style="color: #dee2e6;">|&nbsp;</span>
                                                		<div class="col-4 "><a class="tap" href="/supportBoard/view?nowPage=1&seq_board=${dto.SEQ_BOARD}">글번호&nbsp;:&nbsp;${dto.SEQ_BOARD}</a></div>
                                                		<span style="color: #dee2e6;">|&nbsp;</span>
                                                		<div class="col-5 pay_date">결제일&nbsp;:&nbsp;<fmt:formatDate value="${dto.PAY_DATE}" pattern="yy-MM-dd"/></div>
                                                	</div>	
                                                	<div class="contentSm d-flex">
                                                		<div class="col-6 member_id">보호소명&nbsp;:&nbsp;${dto.WRITER_NICKNAME}</div>
                                                		<span style="color: #dee2e6;">|&nbsp;</span>
                                                		<div class="col-6 member_id">보호소ID&nbsp;:&nbsp;${dto.SHELTER_ID}</div>
                                            		</div>
                                                	<div class="contentSm d-flex">
                                                		<div class="col-6 member_id">회원ID&nbsp;:&nbsp;${dto.MEMBER_ID}</div>
                                                		<span style="color: #dee2e6;">|&nbsp;</span>
                                                		<div data-value="${dto.PAY_MONEY}" class="col-6 payMoney">&#8361;<fmt:formatNumber type="number" maxFractionDigits="3" value="${dto.PAY_MONEY}" /></div>
                                                		
                                                	</div>
                                            	</td>
                                            </tr>
                                        </c:forEach>
                                   </c:otherwise>
                                </c:choose>

                                <c:if test="${fn:length(etcMap.search_keyword) > '0' && !empty list}" >
                                    <tr style="border-top: 2px solid black;">
                                        <td colspan="7" id="totalMoney">총 금액&nbsp; : &nbsp; &#8361;</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                        </div>
                    </div>
                </div>


                <div class="row" id="searchBox">
                    <!-- 검색박스부분 -->
                    <div class="col">
                        <form action="/admin/toAllPay" method="get">
                        <span class="searchBox">
                            <input type="text" name="search_keyword" id="search" value="${etcMap.search_keyword}">
                            <button type="submit" id="searchBtn"><i class="fa-solid fa-magnifying-glass"></i></button>
                        </span>
                        <span class="searchBox">
                            <select name="search_type" id="search_type">
                                <option value="seq_board">글 번호</option>
                                <option value="member_id">회원아이디</option>
                                <option value="MEMBER_ID">보호소아이디</option>
                                <option value="writer_nickname">보호소명</option>
                            </select>
                        </span>
                        </form>
                    </div>
                </div>

                <div class="page_wrap mb-5 mt-2">
                    <div  class="page_nation">	
                        <c:choose>
                        <c:when test="${etcMap.search_type eq null}">
                                <c:if test="${paging.startPage!=1}" >
                                    <a id="first" href="/admin/toAllPay?nowPage=1">첫 페이지</a>
                                    <a class="arrow left" href="/admin/toAllPay?nowPage=${paging.startPage-1}">&lt;</a>
                                </c:if>	
                                <c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p" step="1">
                                    <a href="/admin/toAllPay?nowPage=${p}"
                                        class="paging">${p}</a>
                                </c:forEach>
                                <c:if test="${paging.endPage != paging.lastPage}">
                                    <a class="arrow right" href="/admin/toAllPay?nowPage=${paging.endPage+1}">&gt;</a>
                                    <a id="last" href="/admin/toAllPay?nowPage=${paging.lastPage}">끝 페이지</a>
                                </c:if>
                        </c:when>
                        <c:otherwise>
                                <c:if test="${paging.startPage!=1}" >
                                    <a id="first" href="/admin/toAllPay?nowPage=1&search_type=${etcMap.search_type}&search_keyword=${etcMap.search_keyword}">첫 페이지</a>
                                    <a class="arrow left" href="/admin/toAllPay?nowPage=${paging.startPage-1}&search_type=${etcMap.search_type}&search_keyword=${etcMap.search_keyword}">&lt;</a>
                                </c:if>	
                                <c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p" step="1">
                                    <a href="/admin/toAllPay?nowPage=${p}&search_type=${etcMap.search_type}&search_keyword=${etcMap.search_keyword}"
                                        class="paging">${p}</a>
                                </c:forEach>
                                <c:if test="${paging.endPage != paging.lastPage}">
                                    <a class="arrow right" href="/admin/toAllPay?nowPage=${paging.endPage+1}&search_type=${etcMap.search_type}&search_keyword=${etcMap.search_keyword}">&gt;</a>
                                    <a id="last" href="/admin/toAllPay?nowPage=${paging.lastPage}&search_type=${etcMap.search_type}&search_keyword=${etcMap.search_keyword}">끝 페이지</a>
                                </c:if>
                        </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                

                <!-- footer -->
	            <jsp:include page="/WEB-INF/views/frame/footer.jsp"></jsp:include>

            </div>

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

            if(document.getElementById('totalMoney')){
                if('${etcMap.searchMoney}'){
                    document.getElementById('totalMoney').innerText += parseInt('${etcMap.searchMoney}').toLocaleString('en-US');
                }
            }
            
            
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