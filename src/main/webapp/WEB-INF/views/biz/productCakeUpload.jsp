<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../default/header.jsp"%>

<style>
	label{margin-top:10px;}
	#radio{
	height : auto;
	width : auto;
	font-size : 15px;
	margin : auto 0;
}
#checkbox{
	margin-top:18px;
}

#search{
background : #9bcaba;
}

#join{
	background : #f6c6c9;
}

#cancle{
	background : #9bcaba;
}

#joinbutton{
	margin-top : 30px;
}

#inputtag{
margin-top:10px;}
</style>
<!-- Page Content Wraper Area Start -->
<section class="page-content-wrapper">
	<div class="container">
		<div class="row">
			<div class="content-full ptb-50 fix" style="margin: 0 auto;">


				<!-- Left Side Start -->
				<div class="col-md-2">
					<div class="right-area">
						<div class="product-filter">
							<!-- Category Product -->
							<div class="category">
								<h4>My Page</h4>
								<div class="category-list mt-20">
									<ul>
										<!-- li style="border-bottom:0px;" << 라인 없애기 -->
										<li style="border-bottom: 0px;"><a href="#"><i
												class="zmdi zmdi-chevron-right"></i>케이크 등록하기</a></li>
										<li style="border-bottom: 0px;"><a href="#"><i
												class="zmdi zmdi-chevron-right"></i>사업가 정보 수정</a></li>
										<li style="border-bottom: 0px;"><a href="#"><i
												class="zmdi zmdi-chevron-right"></i>주문내역</a></li>
										<li style="border-bottom: 0px;"><a href="#"><i
												class="zmdi zmdi-chevron-right"></i>문의글 모음</a></li>

									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- Left Side End -->

				<!-- Right Side Start -->
				<div style = "margin-bottom : 30px;">
				<span style="border: 2px solid pink;"></span>&nbsp;&nbsp;
				<h1 style="display: inline; margin-top: 0">
					<small><b>케이크 등록하기</b></small>
				</h1>
				</div>
				<br>

				<article class="container">
					<div class="col-md-10">
						<form class="form-horizontal">
							<div class="form-group">
								<label class="col-sm-3 control-label" for="inputID">이미지</label>
								<div class="col-sm-4">
									<input class="form-control" id="inputImage" type="text"
										placeholder="이미지">
									</div>	
								<button class="btn btn-success btn-lg" type="button" id="search">이미지 찾기</button>
								
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label" for="inputCakeName">케이크 이름</label>
								<div class="col-sm-6">
									<input class="form-control" id="inputCakeName" type="text"
										placeholder="케이크 이름">
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-3 control-label" for="inputMiniCakeName">케이크 소제목</label>
								<div class="col-sm-6">
									<input class="form-control" id="inputMiniCakeName" type="text"
										placeholder="케이크 소제목">
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-3 control-label" for="inputPrice">가격
									</label>
								<div class="col-sm-6">
									<input class="form-control" id="inputPrice" type="text"
										placeholder="가격">
								</div>
							</div>

							<div class="form-group">
								<label class="col-sm-3 control-label" for="inputCakeInfo">케이크 설명</label>
								<div class="col-sm-6">
									<textarea class="form-control" id="inputCakeInfo"
										placeholder="케이크의 설명을 입력해 주세요." rows = 6 style = "resize : none"></textarea>
								</div>
							</div>
							
						
							
							<div class="form-group">
								<label class="col-sm-3 control-label" for="inputCakeInfo">예약시 주의사항</label>
								<div class="col-sm-6">
									<textarea class="form-control" id="inputCakeInfo"
										placeholder="주의사항을 입력해 주세요." rows = 6 style = "resize : none"></textarea>
								</div>
							</div>
							
								<div class="form-group">
								<label class="col-sm-3 control-label" for="inputCakeInfo">태그</label>
								<div class="col-sm-6">
									<input class="form-control" id="inputtag" type="text"
										placeholder="태그입력">
										<input class="form-control" id="inputtag" type="text"
										placeholder="태그입력">
										<input class="form-control" id="inputtag" type="text"
										placeholder="태그입력">
									<button class="btn btn-success" type="button" id="search" style = "border-radius : 50%; margin-left : 45%; margin-top : 20px;" >+</button>
								</div>
							</div>
							
							
							
							<div class="form-group">
								<label class="col-sm-3 control-label" for="inputemail">케이크 당일 구매 여부</label>
								<div class="col-sm-3" id="checkbox">
									<input class="checkbox-inline" id="radio" type="radio">
									&nbsp;가능
								</div>

								<div class="col-sm-3" id="checkbox">
									<input class="checkbox-inline" id="radio" type="radio">
									&nbsp;불가능
								</div>
							</div>

							
							<div class="form-group">
								<div class="col-sm-12 text-center" id="joinbutton">
									<button class="btn btn-primary btn-lg" type="submit" id="join">
										등록하기</button>
									<button class="btn btn-danger btn-lg" type="submit" id="cancle">
										등록취소</button>
								</div>
							</div>
						</form>
					</div>
				</article>
			</div>
		</div>
	</div>
</section>

</body>

</html>
<%@ include file="../default/footer.jsp"%>