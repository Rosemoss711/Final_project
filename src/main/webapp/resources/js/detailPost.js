const active = document.getElementsByClassName('paging');
const category = document.getElementsByClassName('category');
const tap = document.querySelectorAll('.tap');
const noticeTr = document.querySelectorAll('tr');

/* 머무는 페이지 표시 */
for (let i = 0; i < active.length; i++) {
  if (active[i].innerText == nowPage) {
    active[i].style.cssText =
      'background-color: #f9f9f9; color: #555; border: 1px solid #aaa; border-radius: 2px';
  }
}

/* 머물고 잇는 소분류 카테고리 표시 */
for (let i = 0; i < category.length; i++) {
  if (category[i].id == etcMap.small_category) {
    category[i].style.cssText = 'text-decoration: underline; color: black';
  }
}

/* 상단에 노출시킨 공지 표시 */
for (let i = 0; i < tap.length; i++) {
  if (tap[i].innerText == '공지') {
    noticeTr[i + 1].className = 'table-secondary';
  }
}

document.addEventListener('click', function (e) {
  if (e.target.id == 'write') {
    // 글작성
    if (etcMap.search_type) {
      location.href =
        '/board/toWrite?nowPage=' +
        nowPage +
        '&seq_category=' +
        etcMap.category +
        '&small_category=' +
        etcMap.small_category +
        '&category_name=' +
        etcMap.category_name;
    } else {
      location.href =
        '/board/toWrite?nowPage=' +
        nowPage +
        '&seq_category=' +
        etcMap.category +
        '&small_category=' +
        etcMap.small_category +
        '&category_name=' +
        etcMap.category_name +
        '&search_type=' +
        etcMap.search_type +
        '&search_keyword=' +
        etcMap.search_keyword;
    }
  } else if (e.target.id == 'removePost') {
    // 글삭제
    let check = confirm('해당 게시물을 삭제하시겠습니까?');
    if (check) {
      location.href =
        '/board/deletePost?seq_board=' +
        seq_board +
        '&seq_category=' +
        etcMap.category +
        '&category_name=' +
        etcMap.category_name;
    }
  } else if (e.target.id == 'modifyPost') {
    // 글수정
    if (etcMap.search_type) {
      location.href =
        '/board/toModifyBoard?nowPage=' +
        nowPage +
        '&seq_board=' +
        seq_board +
        '&seq_category=' +
        etcMap.category +
        '&small_category=' +
        etcMap.small_category +
        '&category_name=' +
        etcMap.category_name;
    } else {
      location.href =
        '/board/toModifyBoard?nowPage=' +
        nowPage +
        '&seq_board=' +
        seq_board +
        '&seq_category=' +
        etcMap.category +
        '&small_category=' +
        etcMap.small_category +
        '&category_name=' +
        etcMap.category_name +
        '&search_type=' +
        etcMap.search_type +
        '&search_keyword=' +
        etcMap.search_keyword;
    }
  }
});

// 댓글 삭제 버튼 이벤트 동적으로 추가되는 부분이 존재해서 버블링으로 걸어줌
document.addEventListener('click', function (e) {
  if (e.target.className == 'comment_delete') {
    let check = confirm('삭제하시겠습니까?');
    if (check) {
      $.ajax({
        url: '/board/deleteComment',
        type: 'get',
        data: { seq_comment: e.target.value },
        success: function (data) {
          console.log(data);
          e.target.closest('div').remove();

          // 댓글 개수 표시
          let commentNum = document.querySelectorAll('.commentBox');
          document.getElementById('commentNum').innerText = commentNum.length;
          document.getElementById('commentNum2').innerText = commentNum.length;

          if (commentNum.length === 0) {
            document.getElementById('replyNumDiv').remove();
          }
        },
        error: function (e) {
          console.log(e);
        }
      });
    }
  }
});

// 댓글 수정 버튼 이벤트 동적으로 추가되는 부분이라 버블링으로 걸어줌
document.addEventListener('click', function (e) {
  if (e.target.className == 'comment_modify') {
    // 댓글 수정 버튼 누르면 나오는 디브창
    let content = e.target
      .closest('div')
      .getElementsByClassName('comment_content');
    console.log(content[0].innerText);

    let div = $('<div>').attr('class', 'col-12 commentBox');
    let p1 = $('<p>').attr('class', 'comment_Nk');
    let button1 = $('<button>').attr({
      id: 'comment_close',
      type: 'button'
    });
    let button2 = $('<button>').attr({
      id: 'modifyCommentBtn',
      type: 'button',
      value: e.target.value
    });
    let strong = $('<strong>').append(' 댓글 수정');
    let textarea = $('<textarea>').attr({
      name: 'comment_content',
      id: 'modify_content'
    });
    let i1 = $('<i>').attr('class', 'fa-solid fa-arrow-right');
    let i2 = $('<i>').attr('class', 'fa-solid fa-xmark');

    button1.append(i2, ' 닫기');
    button2.append('등록');
    p1.append(i1, strong, button1);
    textarea.append(content[0].innerText);
    div.append(p1, textarea, button2);
    e.target.closest('div').after(div.get(0));
  } else if (e.target.id == 'comment_close') {
    // 댓글 닫기 버튼 누르면 수정눌러서 나온 입력창이 다시 사라짐
    e.target.closest('div').remove();
  } else if (e.target.id == 'modifyCommentBtn') {
    // 댓글 수정하고 등록버튼 누르면 ajax로 보내는 거
    $.ajax({
      url: '/board/modifyComment',
      type: 'get',
      data: {
        seq_comment: e.target.value,
        comment_content: $('#modify_content').val()
      },
      success: function (data) {
        console.log(data);

        let content = e.target.closest('div').previousSibling;
        content.getElementsByClassName('comment_content')[0].innerText =
          document.getElementById('modify_content').value;

        e.target.closest('div').remove();

        // 댓글 개수 표시
        let commentNum = document.querySelectorAll('.commentBox');
        document.getElementById('commentNum').innerText = commentNum.length;
        document.getElementById('commentNum2').innerText = commentNum.length;
      },
      error: function (e) {
        console.log(e);
      }
    });
  } else if (e.target.id === 'loginComment') {
    let check = confirm('로그인 하시겠습니까?');
    if (check) {
      location.href = '/member/toLoginPage';
      return;
    }
  }
});

// 댓글 등록 이벤트
document.getElementById('registerBtn').addEventListener('click', function () {
  if (!member_id) {
    alert('로그인 후 이용 부탁드립니다.');
    return;
  }

  if (!document.getElementById('comment_content').value) {
    alert('내용을 입력해주세요.');
    return;
  }

  let data = $('#commentForm').serialize();
  $.ajax({
    url: '/board/registerComment',
    type: 'get',
    data: data,
    success: function (data) {
      console.log(data);
      const now = new Date();

      if (!document.getElementById('replyNumDiv')) {
        let div1 = $('<div>').attr('class', 'row mt-5');
        let div2 = $('<div>').attr({
          class: 'col',
          id: 'replyNumDiv'
        });
        let strong = $('<strong>').attr('id', 'commentNum').append('1');
        div2.append('댓글 ', strong, ' 개');
        div1.append(div2);
        $('#commentList').before(div1);
      }

      let div = $('<div>').attr('class', 'col-12 commentBox');
      let p1 = $('<p>').attr('class', 'comment_Nk').append(nickname);
      let p2 = $('<p>')
        .attr('class', 'comment_content')
        .append($('#comment_content').val());
      let span = $('<span>').attr('class', 'comment_Date').append(' 방금 전');
      let button1 = $('<button>').attr({
        class: 'comment_delete',
        type: 'button',
        value: data
      });
      let button2 = $('<button>').attr({
        class: 'comment_modify',
        type: 'button',
        value: data
      });
      let i1 = $('<i>').attr('class', 'fa-solid fa-eraser');
      let i2 = $('<i>').attr('class', 'fa-solid fa-pen');

      button1.append(i1, ' 삭제');
      button2.append(i2, ' 수정');
      p1.append(span, button1, button2);
      div.append(p1, p2);
      div.appendTo('#commentList');
      document.getElementById('comment_content').value = '';

      // 댓글 개수 표시
      let commentNum = document.querySelectorAll('.commentBox');
      document.getElementById('commentNum').innerText = commentNum.length;
      document.getElementById('commentNum2').innerText = commentNum.length;
    },
    error: function (e) {
      console.log(e);
    }
  });
});

/* 목록으로 버튼 누르면 아래로 스크롤 내려줌 */
document.getElementById('listBtn').addEventListener('click', function () {
  window.scrollBy({ left: 0, top: 1000, behavior: 'smooth' });
});

/* 댓글 단지 시간 얼마나 걸렷는지 표시해주는거 */
let date = document.querySelectorAll('.comment_Date');
date.forEach(date => {
  date.innerText = elapsedTime(date.innerText);
});

/* 댓글 단지 소요시간 나타내주는 함수 */
function elapsedTime(date) {
  const start = new Date(date);
  const end = new Date(); // 현재 날짜

  const diff = end - start; // 경과 시간

  const times = [
    { time: '분', milliSeconds: 1000 * 60 },
    { time: '시간', milliSeconds: 1000 * 60 * 60 },
    { time: '일', milliSeconds: 1000 * 60 * 60 * 24 },
    { time: '개월', milliSeconds: 1000 * 60 * 60 * 24 * 30 },
    { time: '년', milliSeconds: 1000 * 60 * 60 * 24 * 365 }
  ].reverse();

  // 년 단위부터 알맞는 단위 찾기
  for (let i = 0; i < times.length; i++) {
    const betweenTime = Math.floor(diff / times[i].milliSeconds);
    // 큰 단위는 0보다 작은 소수 단위 나옴
    if (betweenTime > 0) {
      return betweenTime + ' ' + times[i].time + ' 전';
    }
  }

  return '방금 전';
}

document.getElementById('topBtn').addEventListener('click', function () {
  window.scrollTo({ left: 0, top: 0, behavior: 'smooth' });
});

// Top 버튼
$(window).scroll(function () {
  if ($(this).scrollTop() > 300) {
    $('#topBtn').show();
  } else {
    $('#topBtn').hide();
  }
});

const select = etcMap.search_type;
const option = document.querySelectorAll('#search_type option');
option.forEach(option => {
  if (option.value === select) {
    option.selected = true;
  }
});
