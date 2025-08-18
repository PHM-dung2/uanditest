
/*
 * 01. JS명   : common.js
 * 02. 내용 
 *   ● svcId     : 서비스 ID
 *   ● type      : Http Method(GET, POST, PUT, DELETE)
 *   ● url       : api 호출 url
 *   ● inData    : 송신 {json형식}, formData
 *   ● async     : 동기(true), 비동기(false)
 *   ● callback  : 콜백함수(고정)
 * 03. 작성자 : 박희만 
 * 04. 작성날짜 : 2025.08.18
 * 04. 사용예시
 *   ● var svcId = "test";
 *     var type = "GET";
 *     var url = "/";
 *     var inData = {};
 *     var async = true;( 생략시 false ) 
 *    
 *     transaction( svcId, type, url, inData, callbackFunc, async );
 *
 *   ● function callbackFunc( svcId, data ) {
 *         if (svcId === "test") {
 *             // 콜백 코드 작성
 *         }
 *     };
 */
function ajaxFunc( svcId, type, url, inData, callback, async ){
  
  var ajaxOptions = {
    type: type,
    url: url,
    async: async ?? true,
    success: function( res ){
      console.log( res );
      if ( res !== "" ) {
          callback( svcId, res );
      } else {
          res = "";
          callback( svcId, res );
      }
    },
    error: function( jqXHR, textStatus, errorThrown ){
      console.log("jqXHR.status:", jqXHR.status);             // ex: 404
      console.log("jqXHR.responseText:", jqXHR.responseText); // 서버 응답 내용
      console.log("textStatus:", textStatus);                 // ex: "error" or "parsererror"
      console.log("errorThrown:", errorThrown);               // ex: "Not Found" or "Internal Server Error"
      
      const responseText = JSON.parse( jqXHR.responseText );
      
      if( responseText.RuntimeException != null ){
        alert("에러 발생 : " + responseText.RuntimeException);
      }
    }
  };
  
  if ( type.toLowerCase() !== "get" ) {
      ajaxOptions.data = inData;
  }
  
  if ( inData instanceof FormData ) {
    ajaxOptions.processData = false;
    ajaxOptions.contentType = false;
  }

  $.ajax( ajaxOptions );
  
}

// 정규식 함수
  // 이름(한글, 특수문자 제외)
  function isValidName(name){
    const nameRegex = /^[^ㄱ-ㅎㅏ-ㅣ가-힣!@#$%^&*()_+={}\[\]|\\:;"'<>,.?\/~`-]+$/;
    return nameRegex.test(name);
  }
  
  // 이메일(영어, 숫자, 특수문자(_ . @)만 입력 가능)
  function isValidEmail(email){
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
  }
  
  // 비밀번호(문자, 숫자, 특수문자 조합 8~15자리)
  function isValidPassword(password){
    const passwordRegex = /^(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*])[a-z\d!@#$%^&*]{8,15}$/
    return passwordRegex.test(password);
  }
  
  // 휴대폰번호
  function isValidPhone(phone){
    const phoneRegex = /^010-[0-9]{4}-[0-9]{4}$/;
    return phoneRegex.test(phone);
  }

// vaildation
function blankCheck( data ){
  if( data === '' ){ 
    alert("이메일을 입력해주세요."); 
    return;
  }
}

// 로그아웃
function logout(){
  
  if( !confirm("로그아웃 하시겠습니까?") ){ return false; }
  
  var svcId = "logout";
  var type = "GET";
  var url = "/api/logout";
  var inData = "";
  
  ajaxFunc( svcId, type, url, inData, ( svcId, res ) => commonCallBack( svcId, res ) );
  
}

//콜백 함수
function commonCallBack( svcId, res ){
  console.log("response : ", res);
  
  if( svcId === "logout" ){
    location.href="/";
  }
  
}

// daum 주소 api
function daumPostcode() {
  new daum.Postcode({
    oncomplete: function(data) {
      // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

      // 각 주소의 노출 규칙에 따라 주소를 조합한다.
      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
      var addr = ''; // 주소 변수
      var extraAddr = ''; // 참고항목 변수

      //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
      if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
          addr = data.roadAddress;
      } else { // 사용자가 지번 주소를 선택했을 경우(J)
          addr = data.jibunAddress;
      }

      // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
      if(data.userSelectedType === 'R'){
        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
        if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
            extraAddr += data.bname;
        }
        // 건물명이 있고, 공동주택일 경우 추가한다.
        if(data.buildingName !== '' && data.apartment === 'Y'){
            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
        }
        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
        if(extraAddr !== ''){
            extraAddr = ' (' + extraAddr + ')';
        }
        // 조합된 참고항목을 해당 필드에 넣는다.
        document.getElementById("user_refer_address").value = extraAddr;
      
      } else {
          document.getElementById("user_refer_address").value = '';
      }

      // 우편번호와 주소 정보를 해당 필드에 넣는다.
      document.getElementById('user_zonecode').value = data.zonecode;
      document.getElementById("user_road_address").value = addr;
      // 커서를 상세주소 필드로 이동한다.
      document.getElementById("user_detail_address").focus();
    }
  }).open();
}
