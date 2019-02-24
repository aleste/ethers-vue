pragma solidity >=0.4.23 <0.6.0;


/*
    (zero) 0 value in int256 meaning null
*/

contract NotarizeArba {

    address owner;
    mapping (uint256 => Document) private documents;
    uint256 secuence ;
    struct Document {
        address[] owners;
        uint256 id;
        string date;
        string subject;
        string description;
        string hash;
        uint256 next;
        uint256 root;
        bool available ;
    }

    event newDocumentEvent(string successfulMessage, uint256 documentId );
    event deleteDocumentEvent(string successfulMessage, string documentId);
    event updateDocumentEvent(string successfulMessage, uint documentId);
    event findedDocumentEvent(string successfulMessage, string documentId);

    function newNotarize(address[] memory owners ,string memory date ,string memory subject ,string memory description , string memory hash , uint256 root )public  returns (uint256){
        return  newDocument( owners , date , subject , description ,  hash , 0 ,root) ;
    }

    function newDocument(address[] memory owners ,string memory date ,string memory subject ,string memory description , string memory hash , uint256 next ,uint256 root )  internal returns (uint256){
        uint256 id = getId();
        if(!checkExists(id)) {
                if(root == 0){
                    root=id;
                }
                documents[id]=Document(owners,id,date,subject,description,hash,next,root,true);
                emit newDocumentEvent("Notarized success", id );
                return id;
        }
        emit newDocumentEvent(" Notarize Fail  " , 0 );
        return 0;
    }

    function updateDocument(uint256 id,string memory newHash,string memory newDescription,string memory date, address ownerDoc) public returns (bool){
        if (check(ownerDoc , documents[id].owners)){
                uint256  idFinded ;
                idFinded = returnLastestDocumentId(id);
                Document storage doc = documents[idFinded];
                Document memory local = documents[id];
                doc.next=newDocument(local.owners,date,doc.subject,newDescription,newHash,0,local.root);
                return true;
        } else {
                return false;
                }
    }

   function getDocument(uint256 id) view public  returns (uint256 ,string memory,string memory ,string memory , string memory,uint256 ,uint256 ) {
        return (documents[id].id ,documents[id].date ,documents[id].subject , documents[id].description, documents[id].hash, documents[id].root ,documents[id].next) ;
    }

   function check( address  candidate , address[] memory owners ) view public returns (bool){
        for (uint i = 0; i < owners.length; i++) {
            if(owners[i] == candidate){
                return true;
            }
        }
        return false ;
    }

    function checkExists(uint256  id) public view returns (bool ){
        return documents[id].available;
    }

    function returnLastestDocumentId(uint256 id) view public returns (uint256 ){
            uint256  limite= 0;
            Document memory doc = documents[id];
            while (doc.next != limite){
                    doc=documents[doc.next];
            }
            return (doc.id);
    }

    function getId()internal returns(uint256) {
         secuence = secuence + 1 ;
            return secuence;
    }

    function getActual()internal returns(uint256) {
            return secuence;

    }
 }