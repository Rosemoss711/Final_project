document.addEventListener("DOMContentLoaded", function topButton() {

            document.getElementById('topBtn').addEventListener('click', function () {
                window.scrollTo({left: 0, top: 0, behavior: "smooth"});
            })

            // Top 버튼
            $(window).scroll(function () {
                if ($(this).scrollTop() > 300) {
                    $("#topBtn").show();
                } else {
                    $("#topBtn").hide();
                }
            });
        });