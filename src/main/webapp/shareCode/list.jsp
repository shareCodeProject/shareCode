<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="functions" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ShareCode</title>
<link rel="stylesheet" href="css/list.css" type="text/css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	var cate="";
	
	$(window).bind("pageshow", function (event) {
        if (event.originalEvent.persisted || (window.performance && window.performance.navigation.type == 2)) {
            console.log(job);
            
        } else {
            console.log('새로 열린 페이지');
        }
    });
	
	selectAjax();
	
	function selectAjax() {
		$.ajax({
			url : '/web/shareCode/list.do',
			data : {
				"job" : $(".languageSelect option:selected").val()
			},
			dataType : 'json',
			success : function(v) {
				var temp = "";
				$.each(v.slang, function(index, dom) {
					
					temp += "<tr onClick=\"location.href='postInfo.do?post_no="+dom.post_no+"'\">";
					temp += "<td>"+dom.post_no+"</td>";
					temp += "<td>"+dom.post_category+"</td>";
					temp += "<td>"+dom.post_title+"</td>";
					temp += "<td>"+dom.user_no+"</td>";
					temp += "<td>"+dom.post_date+"</td>";
					temp += "<td>"+dom.post_hit+"</td>";
					temp += "</tr>"
					
					cate = dom.post_category; //카테고리 선택된것
					
				});
				$("#tblist").html(temp);
				var startNum=$("#tblist tr").length;
				console.log("선택된 카테고리 : ",cate);
				console.log("리스트 갯수 : ",startNum);
				
			},
			error : function(e) {
				alert('에이젝스에서 에러뜬다' + e);
			}

		});
	}
	
	function postWrite(){
		if(${member.user_no == null}){
			alert('로그인 후 이용해주세요');
			return
		}
		window.location.href = 'post-write.jsp';
	}
	


</script>
</head>
<body>
	<jsp:include page="header.jsp" />

	<div class="inner_cont">
		<div class="borad_list_tbl">
			<table>
				<caption>게시판 리스트</caption>
				<colgroup>
					<col width="30">
					<col width="30">
					<col width="180">
					<col width="50">
					<col width="50">
					<col width="30">
				</colgroup>
				<thead>
					<select class="languageSelect" onchange="selectAjax()">
					<option value="all" selected>전체 </option>
					<option id="category" value="Java">Java</option>
						<option id="category" value="C++">C++</option>
						<option id="category" value="Python">Python</option>
					</select>
					<tr>
						<th scope="col">글번호</th>
						<th scope="col">카테고리</th>
						<th scope="col">글제목</th>
						<th scope="col">작성자</th>
						<th scope="col">작성일</th>
						<th scope="col">조회수</th>
					</tr>
				</thead>
					<tbody id ="tblist">
				
				</tbody>
			

				<%-- <c:forEach var="i" items="${selectLang}" varStatus="cnt">


					<tbody>
						<tr onClick="location.href='postInfo.do?post_no=${i.post_no}'">

							<td><c:out value="${i.post_no}"></c:out></td>
							<td><c:out value="${i.post_title }"></c:out></td>
							<td><c:out value="${i.user_no }"></c:out></td>
							<td><c:out value="${i.post_date }"></c:out></td>
							<td><c:out value="${i.post_hit }"></c:out></td>
						</tr>
					</tbody>
				</c:forEach> --%>

			</table>
		</div>
		<div class="btn-div">
			<button class="write-btn" type="button" onclick="postWrite();">글작성</button>
		</div>

		<div class="container xlarge">
			<div class="pagination">
				<ul>
					<li><a href="#">PREVIOUS</a></li>
					<li><a href="#">1</a></li>
					<li class="active"><a href="#">2</a></li>
					<li><a href="#">3</a></li>
					<li><a href="#">4</a></li>
					<li><a href="#">5</a></li>
					<li><a href="#">NEXT</a></li>
				</ul>
			</div>
		</div>
	</div>

</body>
</html>