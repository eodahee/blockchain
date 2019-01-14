pragma solidity ^0.4.25;
pragma experimental ABIEncoderV2; // 실험적으로 제공해주는 것(버전 업글되면 없어질듯)

contract Voting {
	string[] public candidateList; // 후보자 목록
	mapping(string => uint8) private votesReceived; // 후보자별 득표수

	constructor (string[] candidateNames) public {
		candidateList = candidateNames;
	}

	// KEY-POINT!!!!(이거때문에 투표예제 한거)
	// 배열의 배열은 한큐에 값 못 가져오고, length를 호출해서 하나하나 뽑아와야함
	function candidateCount() public view returns (uint256) {
	    return candidateList.length;
	}
	
	// 후보자의 득표수를 반환
	function totalVotesFor(string candidate) view public returns (uint8) {
		require(validCandidate(candidate)); // 반드시 참이어야 하는 것은 require로 지정
		return votesReceived[candidate];
	}

	// 특정 후보에게 투표
	function voteForCandidate(string candidate) public {
		require(validCandidate(candidate)); // 반드시 참이어야 하는 것은 require로 지정
		votesReceived[candidate] ++;
	}

	// 등록된 후보 여부를 확인하는 공통함수(bool타입 return값 반환)
	function validCandidate(string candidate) view public returns (bool) {
		// 파라미터로 전달된 candidate가 후보자 목록(candidateList)에 등록되어 있어야 함!!		
		for(uint i=0; i<candidateList.length; i++) {
			if (sha3(candidateList[i]) == sha3(candidate)) {
				// 등록된 후보
				return true;
			}
		}
		return false;
	}
}
