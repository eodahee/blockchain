pragma solidity ^0.4.25;

// Music 계약
contract Music {
    // 상태 변수
    string musicName;
    uint32 downloadCount;
    // public을 사용하면 solidity에서는 알아서 get함수를 만들어줌(그러므로, get함수를 따로 만들 필요 없음)
    string public imageUrl; // 음원 이미지 주소
    string public comment; // 음원 설명

    // 카운트 증가 이벤트
    event EventCountUp(uint32 count);

    // 생성자
    constructor (string name, string url, string comm) public {
        musicName = name;
        imageUrl = url;
        comment = comm;        
    }

    // getter 함수
    function getMusicName() public view returns (string) {
        return musicName;
    }
    function getDownloadCount() public view returns (uint32) {
        return downloadCount;
    }
