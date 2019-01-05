pragma solidity >=0.5.0 <0.6.0;

contract ProductRating {
    /*struct GiveScore {
        address to;
        uint score;
    }*/

    struct RatingMan {
        uint creditCoin;
        uint ratingVotes;
        uint gender;
        string[] offerProductLink;
        uint[] offerProductScore;
        uint productKind;
        string phoneNumber;
        string id;
    }

    address payable contractOwner;
    address[] addressbook;
    address[] public washingAddress;
    //string[] public serviceList;
      function register(string memory phoneNumber, uint gender, string memory id) public payable{
        string memory non;
        non='';
        require(keccak256(abi.encodePacked(id)) != keccak256(abi.encodePacked(non)));
        require(!isRegister[msg.sender]);
        RatingMan storage tool = ratingman[msg.sender];
        tool.phoneNumber = phoneNumber;
        tool.gender = gender;
        tool.id = id;
        tool.ratingVotes = 10;
        tool.creditCoin = 100;
        isRegister[msg.sender] = true;
        addressbook.push(msg.sender);
        //emit Registered(msg.sender);
    }

    mapping(address => RatingMan) ratingman;
    mapping(address => bool) public isRegister;
    

    function offerProduct(string memory _offerProductLink) public {
        require(isRegister[msg.sender]);
        RatingMan storage offer = ratingman[msg.sender];
        offer.offerProductLink.push(_offerProductLink);
        offer.productKind += 1;
        //Servicelistupdate();
       // emit getserviceoffer (msg.sender, _serviceContent, price);
    }
    
  
    function givevote(address addrTool, uint number, uint score) public {
        // msg.sender is lazyman
    
        require(isRegister[msg.sender]);
        require(isRegister[addrTool]);
        require(score <= 10);
        RatingMan storage sender = ratingman[msg.sender];
        RatingMan storage tool = ratingman[addrTool];
       
        sender.ratingVotes -= score;
        tool.offerProductScore[number] += score;
//        emit finishService(msg.sender, addrTool, tool.serviceContent[number-1], price, score);
    }
    
   
    function getRatingManProduct(address addr, uint number) public view returns (
        uint score,
        string memory productlink
        ) {

        RatingMan storage tool = ratingman[addr];
        score = tool.offerProductScore[number];
        productlink = tool.offerProductLink[number];
        
          }

    function getmyinfo() public view returns (
        uint ratingVotes, uint creditCoin) {
        RatingMan storage tool = ratingman[msg.sender];
        ratingVotes = tool.ratingVotes;
        creditCoin = tool.creditCoin;
    }


}
