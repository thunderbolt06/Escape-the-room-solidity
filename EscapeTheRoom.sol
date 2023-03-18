// SPDX-License-Identifier: GPL

pragma solidity ^0.8.9;

contract EscapeTheRoom{
    struct userEscapeRoomData{
        uint currentBlockTime;
        uint[3][3] currentRoomCoordinates;
        uint currentPaths;
    }

    mapping(address => userEscapeRoomData) escapeRoomData;

    constructor(){}
    event str(
        string a
    );
    event num(
        uint a
    );

    function generateNewBoard() external{
        uint8[3][3] memory currentRoom;
        uint time = block.timestamp;
        escapeRoomData[msg.sender].currentBlockTime = time;
        uint determinant = (time % 7) + 2;
        emit str("hello");
        uint i = 0;
        uint j = 1;
        uint count = 2;
        while(i < 3){
            j=0;
            while(j < 3){
                if(determinant == count){
                    currentRoom[i][j] = 1;
                }
                j+=1;
                count+=1;
            }
            i+=1;
        }

        escapeRoomData[msg.sender].currentRoomCoordinates = currentRoom;
        emit num(determinant);
        escapeRoomData[msg.sender].currentPaths = 0;
    }

    function getCurrentPaths() public view returns (uint){
        return escapeRoomData[msg.sender].currentPaths;
    }
    function getCurrentRoom() public view returns (userEscapeRoomData memory){
        return escapeRoomData[msg.sender];
    }
    function computePathsCurrentBoard() external {
        uint i = 0;
        uint j = 1;
        uint numPaths = 0;

        while(i < 3){
            j=0;
            while(j < 3){
                if(escapeRoomData[msg.sender].currentRoomCoordinates[i][j] == 1){
                    if(i == 0 && j == 2){
                        numPaths = 5;
                    }
                    else if(i == 1 && j == 1){
                        numPaths = 2;
                    }
                    else {
                        numPaths = 3;
                    }
                }
                j+=1;
            }
            i+=1;
        }
        escapeRoomData[msg.sender].currentPaths = numPaths;
    }
}