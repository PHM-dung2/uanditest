
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
      
      callback( svcId, res );
    },
    error: function( jqXHR, textStatus, errorThrown ){
      console.log("jqXHR.status:", jqXHR.status);             // ex: 404
      console.log("jqXHR.responseText:", jqXHR.responseText); // 서버 응답 내용
      console.log("textStatus:", textStatus);                 // ex: "error" or "parsererror"
      console.log("errorThrown:", errorThrown);               // ex: "Not Found" or "Internal Server Error"
      
      const responseText = JSON.parse( jqXHR.responseText );
      
      // 로그인이 안된 상태거나 session 없을 때
      if ( jqXHR.status === 401 ) {
        const response = JSON.parse( jqXHR.responseText );
        alert( response.message ); // "로그인이 필요합니다."
        window.location.href = '/login';
        return;
      }
      
      if( responseText.RuntimeException != null ){
        alert("에러 발생 : " + responseText.RuntimeException);
      }
    }
  };
  
  if ( type.toLowerCase() !== "get" ) {
      ajaxOptions.data = inData;
      ajaxOptions.dataType = "json";
  }
  
  if ( inData instanceof FormData ) {
    ajaxOptions.processData = false;
    ajaxOptions.contentType = false;
  }

  $.ajax( ajaxOptions );
  
}

// Validation
  // validator 객체 생성
  function makeValidator( fn, label ){
    return { 
      fn,
      label,
      invalidMsg: `사용 불가능한 ${label}입니다.`, 
      validMsg: `사용 가능한 ${label}입니다.`
    };
  }
  
  const validators = {
    name: makeValidator( isValidName, "이름(닉네임)" ),
    email: makeValidator( isValidEmail, "이메일" ),
    password: makeValidator( isValidPassword, "비밀번호" ),
    matchedPassword: makeValidator( null, "비밀번호 중복 여부" ),
    phone: makeValidator( isValidPhone, "휴대폰 번호" ),
    address: makeValidator( null, "주소" )
  }
  
  // 조사 자동 처리
  function blankMsg( label ) {
    const lastChar = label.charCodeAt(label.length - 1);
    const josa = (lastChar - 44032) % 28 === 0 ? "를" : "을";
    return `${label}${josa} 입력해주세요.`;
  }
  
  // 결과 객체 생성
  function validResult( valid, msg ){
    return { valid, msg };
  }
  
  // 검증 로직
  function runValidation( type, value, compareValue = null ){
    const rule = validators[type];
    
    // validator에 해당하는 type이 없을 때
    if( !rule ){ return validResult( true, "" ); }
    
    // 빈값 검증
      if( value === "" ){ return validResult( false, blankMsg( rule.label ) ); }
      
      // 휴대폰번호는 010 만 입력시에도 alert 출력
      if( type === "phone" ){
        if( value === "010" ){ return validResult( false, blankMsg( rule.label ) ); }
      }
    
    // 유효성 검사
      // 이름(닉네임), 주소 alert x
      if( type === "name" || type === "address" ){ 
        return validResult( true, "" ); 
      }
    
      // 비밀번호 비교
      if( type === "matchedPassword" && compareValue ){
        if( value !== compareValue ){ return validResult( false, "비밀번호가 일치하지 않습니다." ); }
        else{ return validResult( true, "비밀번호가 일치합니다." ); }
      }
      
      if( !rule.fn( value ) ){ return validResult( false, rule.invalidMsg ); }
      else{ return validResult( true, rule.validMsg ); }

  }
  
  // UI 처리
  function validateField( type, el, showSuccessMsg = true , compareValue = null, ) {
    const compareVal = compareValue && compareValue.val ? compareValue.val() : compareValue;
    
    const result = runValidation( type, el.val(), compareVal );
    if ( !result.valid ) { el.focus(); }

    // msg 내용이 있으면 alert 출력
    if ( result.msg && ( !result.valid || showSuccessMsg ) ) {
      alert( result.msg );
    }

    return result.valid;
  }
  
  function validateForm( inputs ) {
    if ( !validateField( "name", inputs.name, false ) ){ return false; }
    if ( !validateField( "email", inputs.email, false ) ){ return false; }
    if ( !validateField( "password", inputs.password, false ) ){ return false; }
    if ( !validateField( "matchedPassword", inputs.passwordCheck, false, inputs.password ) ){ return false; }
    if ( !validateField( "phone", inputs.phone, false ) ){ return false; }
    if ( !validateField( "address", inputs.roadAddress ) ){ return false; }
    if ( !validateField( "address", inputs.detailAddress ) ){ return false; }
    if ( !validateField( "address", inputs.referAddress ) ){ return false; }

    // 2. 마지막에 중복 체크 확인
    if ( !isNameChecked ) {
      alert("이름(닉네임) 중복을 확인해주세요.");
      inputs.name.focus();
      return false;
    }
    if ( !isEmailChecked ) {
      alert("이메일 중복을 확인해주세요.");
      inputs.email.focus();
      return false;
    }
    if ( !isPhoneChecked ) {
      alert("사용 불가능한 휴대폰 번호입니다.");
      inputs.phone.focus();
      return false;
    }
    
    return true;
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

// 로그아웃
function logout(){
  
  if( !confirm("로그아웃 하시겠습니까?") ){ return false; }
  
  var svcId = "logout";
  var type = "GET";
  var url = "/api/logout";
  var inData = "";
  
  ajaxFunc( svcId, type, url, inData, commonCallBack );
  
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
