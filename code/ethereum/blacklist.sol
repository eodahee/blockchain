pragma solidity ^0.4.25;

contract OpenEgCoin {
    // 상태변수 선언
    string public name; // 코인이름(openeg)
    
    string public symbol; // 코인단위(oc)
    uint8 public decimals; // 소수점 이하 자리수(0)
    int256 public totalSupply; // 전체 발행량(10000)

    // 계정별 잔액
    mapping (address => int256) public balanceOf; // address(사용자 주소)에 따른 uint256(coin)을 mapping
    // 블랙리스트(부정 사용자 목록) : TRUE/FALSE로 구분(TRUE면 블랙리스트)
    mapping (address => bool) public blacklist;
    
    //계약 소유자 : 생성자를 호출한 주소를 값으로 설정
    address public owner;
    
    // 수정자 : 계약 소유자만 기능을 수행할 수 있도록 제한
    modifier onlyOwner() {
    	if(msg.sender != owner) 	revert("계약 소유자 전용 기능입니다.");
    	_; // modifier를 호출한 원래 기능을 수행해라
    }

    // 이벤트 정의
    // 송금 완료 이벤트
    event EvtTransfer(address indexed from, address indexed to, int256 value);
    // 블랙리스트 추가 이벤트
    event EvtInsertIntoBlacklist(address indexed addr);	
    // 블랙리스트 삭제 이벤트
    event EvtDeleteFromBlacklist(address indexed addr);	
    // 블랙리스트 계정에서 송금 거부 이벤트
    event EvtRejectPaymentToBlacklist(address indexed from, address indexed to, int256 value);
    // 블랙리스트 계정으로 송금 거부 이벤트
    event EvtRejectPaymentFromBlacklist(address indexed from, address indexed to, int256 value);

   // 생성자
   // 일반적으로 생성자에서는 상태변수 초기화를 처리
   constructor (int256 _supply, string _name, string _symbol, uint8 _decimals) public {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _supply;
        
        // 생성자를 호출한 사용자에게 전체 코인을 할당
        balanceOf[msg.sender] = _supply;
        
        // 생성자를 호출한 사용자의 주소를 owner에게 할당
        owner = msg.sender;
   }

	// 블랙리스트 등록 함수
	function insertBlacklist(address _addr) public onlyOwner {
		blacklist[_addr] = true;
		emit EvtInsertIntoBlacklist(_addr);
	}

	// 블랙리스트 삭제 함수 
	function deleteBlacklist(address _addr) public onlyOwner {
		blacklist[_addr] = false;
		emit EvtDeleteFromBlacklist(_addr);
	}
   
    // 송금 : 함수를 호출한 계정에서 _to 계정으로 _value만큼의 oc를 전송
    function transfer(address _to, int256 _value) public {
        // 검증을 통한 부정 방지
        if(_value < 0)
          revert("마이너스는 송금할 수 없습니다.");
        if(balanceOf[msg.sender] < _value)
          revert("잔액보다 많은 금액은 송금할 수 없습니다."); 
        
        // 블랙리스트 계정으로 송금 불가
        if (blacklist[_to] == true) {
        	emit EvtRejectPaymentToBlacklist(msg.sender, _to, _value);
        }
        // 블랙리스트 계정에서 송금 불가
        else if (blacklist[msg.sender] == true) {
        	emit EvtRejectPaymentFromBlacklist(msg.sender, _to, _value);
        }
        // 그 외 경우 = 정상
        else {
        	balanceOf[msg.sender] -= _value; // 함수를 호출한 계정에서 -value
        	balanceOf[_to] += _value; // 받을 사람(_to)에게 +value
        	emit EvtTransfer(msg.sender, _to, _value);
        }
    }
}
