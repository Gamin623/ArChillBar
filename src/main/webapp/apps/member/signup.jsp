<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

      <c:set var="contextRoot" value="${pageContext.request.contextPath}" />


      <!DOCTYPE html>
      <html>

      <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>signup</title>
      </head>

      <body>
        <jsp:include page="../layout/navbar.jsp"></jsp:include>
        <div class="container mt-2">
          <div class="card w-100 w-md-50 m-auto">
            <div class="card-header bg-dark text-light">
              註冊會員
            </div>
            <div class="card-body w-75 m-auto">
              <form action="${contextRoot}/member/insert" method="post" enctype="multipart/form-data">
                <div class="text-center mb-3">
                  <img width="200px" id="previewImg" src="${contextRoot}/apps/images/membericon.png" alt="">
                </div>
                <div class="form-group mb-3 row">
                  <label for="image" class="input-group-text bg-dark text-light">頭像</label>
                  <input type="file" class="form-control-file" id="image" name="photo"
                    value="${contextRoot}/apps/images/membericon.png">
                </div>
                <div class="form-group mb-3 row">
                  <label for="Name" class="input-group-text bg-dark text-light">姓名 </label>
                  <input type="text" name="memberName" id="Name" required="required"
                    pattern="^[A-Za-z0-9\u4e00-\u9fa5]+$" placeholder="不可使用特殊字符">
                </div>
                <div class="form-group mb-3 row">
                  <label for="pswd" class="input-group-text bg-dark text-light">密碼</label>
                  <input id="pswd" name="password" type="password" pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,16}$"
                    required="required" oninput="setCustomValidity('');"
                    oninvalid="setCustomValidity('請輸入正確的密碼格式:含大小英文、數，長度6~16個字元');" placeholder="含大小英文、數，長度6~16個字元" />
                </div>
                <div class="form-group mb-3 row">
                  <label for="ConfirmPassword" class="input-group-text bg-dark text-light">確認密碼</label>
                  <input name="ConfirmPassword" id="ConfirmPassword" placeholder="確認密碼" type="password"
                    required="required" oninput="setCustomValidity('');"
                    onchange="if(document.getElementById('pswd').value != document.getElementById('ConfirmPassword').value){setCustomValidity('密碼不吻合');}" />
                </div>
                <div class="form-group mb-3 row">
                  <label for="sex" class="input-group-text bg-dark text-light">性別</label>
                  <select name="sex" id="sex">
                    <option value="M">男</option>
                    <option value="F">女</option>
                    <option value="N" selected>不便透露</option>
                  </select>
                </div>
                <div class="form-group mb-3 row">
                  <label for="phoneNum" class="input-group-text bg-dark text-light">手機</label>
                  <input type="text" name="phone" id="phoneNum" required="required" maxlength="11"
                    pattern="09\d{2}-\d{6}" placeholder="09xx-xxxxxx" oninput="setCustomValidity('');"
                    oninvalid="setCustomValidity('請輸入正確的手機號瑪格式:09xx-xxxxxx');" />
                </div>
                <div class="form-group mb-3 row">
                  <label for="email" class="input-group-text bg-dark text-light">電子信箱</label>
                  <input type="email" name="email" id="email" placeholder="電子郵件地址">
                  <span id="emailCheck"></span>
                </div>
                <div class="form-group mb-3 row">
                  <label for="birthday" class="input-group-text bg-dark text-light">生日</label>
                  <input type="date" name="birthday" id="birthday" required="required" min="1900-01-01"
                    max="2004-12-31">
                </div>
                <div class="form-group mb-3">
                  <input type="submit" class="btn btn-dark" id="signup" value="註冊" disabled>
                  <a type="button" class="btn btn-dark" href="${contextRoot}/member/login">已有會員</a>
                </div>
              </form>
            </div>
          </div>
        </div>
        <script>
          //圖片預覽
          $("#image").change(function () {
            //上傳圖片檔案改變後觸發
            readURL(this);  // this代表<input id="imgInp">
          })
          //API FileReader讀取圖片file進行預覽
          function readURL(input) {
            if (input.files && input.files[0]) {
              var reader = new FileReader();
              reader.onload = function (e) {
                $("#previewImg").attr('src', e.target.result);
              }
              reader.readAsDataURL(input.files[0]);
            }
          }

          //信箱檢查
          $("#email").blur(function () {
            let emailText = $('#email').val();
            $.ajax({
              url: '/checkemail',
              contentType: 'application/json;chartset=UTF-8',
              method: 'get',
              data: { "email": emailText },
              success: function (result) {
                if (result != null) {
                  $('#emailCheck').text(result).css('color', 'red');
                  if (result == 'OK') {
                    $('#emailCheck').text(result).css('color', "green");
                    $('#signup').removeAttr('disabled');
                  } else {
                    $('#signup').attr('disabled', 'disabled');
                  }
                }
              }
            })
          });


        </script>
      </body>

      </html>