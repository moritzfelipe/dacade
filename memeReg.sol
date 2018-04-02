pragma solidity ^0.4.18;

contract memecertification {
    
    //In the memecert object we save the address of the creator of the meme, 
    //the name that the creator sets as a string, a timestamp when it was created
    //and the boolean 'used' to easily check if a certain url was already registered 
    struct memecert {
        address creator;
        string name;
        uint256 timestamp;
    }
    
    mapping (string => memecert) memecerts;
    
    //We will create an event so we can add a watcher in our dapp to check if the 
    //meme was successfully registered
    event memecertInfo(
       address creator,
       string name,
       uint256 timestamp,
       string url
    );
    
    //With setMemecert we register a new meme. We use require to ensure that the 
    //url is not already registered, then we save the struct and emit the event
    function setMemecert(string _url, address _creator, string _name) public {
        
        // sicherstellen, dass diese parameter in der transaktion nicht vergessen wurden
        require (bytes(_url).length != 0);
        require (_creator != 0x0);
        require (bytes(_name).length != 0);
        
        require(memecerts[_url].creator == 0x0); // Anstelle des "used" fields im memecert struct reicht es auch, einfach zu checken, ob diese URL bereits einen creator hat, spart gas :)
        memecerts[_url] = memecert(_creator, _name, now);
        emit memecertInfo(_creator, _name, now, _url);
    }
    
    
    //This is the getter for the memes
    function getMemecert(string _url) view public returns (address, string, uint256) {
        return (memecerts[_url].creator, memecerts[_url].name, memecerts[_url].timestamp);
    }
}
