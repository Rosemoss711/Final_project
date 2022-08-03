const active = document.getElementsByClassName('paging');
const category = document.getElementsByClassName('category');
const tap = document.getElementsByClassName('tap');
const noticeTr = document.querySelectorAll('tr');

/* 현재 머물고 있는 페이지에 대한 표시 이벤트 */
for (let i = 0; i < active.length; i++) {
  if (active[i].innerText == nowPage) {
    active[i].style.cssText =
      'background-color: #f9f9f9; color: #555; border: 1px solid #aaa; border-radius: 2px';
  }
}

/* 소분류 카테고리로 들어간 해당 카테고리에 대한 밑줄 이벤트 */
for (let i = 0; i < category.length; i++) {
  if (category[i].id == etcMap.small_category) {
    category[i].style.cssText = 'text-decoration: underline; color: black';
  }
}

/* 노티스로 상단으로 올라온 공지에 대한 색깔처리 */
for (let i = 0; i < tap.length; i++) {
  if (tap[i].innerText == '공지') {
    noticeTr[i + 1].className = 'table-secondary';
  }
}

document.addEventListener('click', function (e) {
  if (e.target.id == 'write') {
    // 글작성버튼
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
  }
});

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
