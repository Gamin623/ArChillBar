<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

      <c:set var="contextRoot" value="${pageContext.request.contextPath}" />

      <!DOCTYPE html>
      <html>

      <head>
        <meta charset="UTF-8">
        <title>verifyToPassword</title>
      </head>

      <body>
        <jsp:include page="../layout/navbar.jsp"></jsp:include>
        <div id="card-container">

          <div class="card w-100 w-md-50 m-auto mt-2">
            <div class="card-header bg-dark text-white">取得認證碼</div>
            <div class="card-body w-75 m-auto">
              <div class="form-floating mb-3">
                <input type="email" class="form-control" id="floatingInput" required="required">
                <label for="floatingInput">電子信箱</label>
                <span id="emailerr"></span>
              </div>
              <button id="emailinfo" class="btn btn-dark">送出</button>
            </div>
          </div>

          <div class="card  w-100 w-md-50 m-auto mt-2">
            <div class="card-header bg-dark text-white">輸入認證碼</div>
            <div class="card-body w-75 m-auto">
              <input type="hidden" name="email" id="hiddenemail" value="">
              <div class="form-floating mb-3">
                <input type="text" class="form-control" id="verify" required="required" name="randomString">
                <label for="verify" name="verify">驗證碼</label>
                <span id="verifyerror"></span>
              </div>
              <button class="btn btn-dark" id="vbtn">驗證</button>
            </div>
          </div>
        </div>
      </body>
      <script>
        $("#emailinfo").click(function () {
          let emailText = $('#floatingInput').val();
          $.ajax({
            url: '/sendVerify',
            method: 'post',
            data: { "email": emailText },
            success: function (result) {
            	if(result.sendOK != null){
	              	$('#emailerr').text(result.sendOK).css('color', 'green');
            	}else if(result.sendFail != null){
            		$('#emailerr').text(result.sandFail).css('color', 'red');
            	}else if(result.emailError != null){
            		$('#emailerr').text(result.emailError).css('color', 'red');
            	}else{
            		$('#emailerr').text(result.unexpectError).css('color', 'red');
            	}
            },
            error: function () {
              $('#emailerr').text("送出失敗").css('color', 'red');
            }
          })
        })

        $("#vbtn").click(function () {
          let val = $('#verify').val();
          $.ajax({
            url: '/checkString',
            method: 'post',
            data: { "randomString": val },
            success: function (result) {
              if (result.OK != null) {
                document.location.href = "/setNewPassword";
              } else {
                $('#verifyerror').text(result.Fail).css('color', 'red');
              }
              $('#hiddenemail').val(emailText);
            },
            error: function () {
              $('#verifyerror').text("認證失敗").css('color', 'red');
            }
          })
        })


      </script>

      </html>