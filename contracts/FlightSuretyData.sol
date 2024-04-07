pragma solidity ^0.4.26;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract FlightSuretyData {
    using SafeMath for uint256;

    /********************************************************************************************/
    /*                                       DATA VARIABLES                                     */
    /********************************************************************************************/

    address private contractOwner;                                      // Account used to deploy contract
    bool private operational = true;                                    // Blocks all state changes throughout the contract if false

    mapping (address => bool) private authorizedApps;
    
    struct AirlineRecord {
        string name;
        bool isRegistered;
        bool isFunded;
        uint256 ID;
    }

    mapping (address => AirlineRecord) private airlines;

    mapping (address => address[]) private votesReceived;

    uint256 private numberOfAirlines = 0;

    struct PassengerFlightInsurance {
        bytes32 flightID;
        uint256 insuranceAmount;
    }
    mapping (address => PassengerFlightInsurance) private passengerInsuranceData;


    /********************************************************************************************/
    /*                                       EVENT DEFINITIONS                                  */
    /********************************************************************************************/


    /**
    * @dev Constructor
    *      The deploying account becomes contractOwner
    */
    constructor
                                (
                                    address firstAirlineAddress,
                                    string firstAirlineName
                                ) 
                                public 
    {
        contractOwner = msg.sender;
        airlines[firstAirlineAddress].name = firstAirlineName;
        airlines[firstAirlineAddress].isRegistered = true;
        airlines[firstAirlineAddress].isFunded = true;
        airlines[firstAirlineAddress].ID = 1;
        numberOfAirlines = 1;
    }

    /********************************************************************************************/
    /*                                       FUNCTION MODIFIERS                                 */
    /********************************************************************************************/

    // Modifiers help avoid duplication of code. They are typically used to validate something
    // before a function is allowed to be executed.

    /**
    * @dev Modifier that requires the "operational" boolean variable to be "true"
    *      This is used on all state changing functions to pause the contract in 
    *      the event there is an issue that needs to be fixed
    */
    modifier requireIsOperational() 
    {
        require(operational, "Contract is currently not operational");
        _;  // All modifiers require an "_" which indicates where the function body will be added
    }

    /**
    * @dev Modifier that requires the "ContractOwner" account to be the function caller
    */
    modifier requireContractOwner()
    {
        require(msg.sender == contractOwner, "Caller is not contract owner");
        _;
    }


    modifier requireCallerIsAnAuthorizedApp()
    {
        require(isAppAuthorized(msg.sender), "Caller is not an authorized app");
        _;
    }

    /********************************************************************************************/
    /*                                       UTILITY FUNCTIONS                                  */
    /********************************************************************************************/

    /**
    * @dev Get operating status of contract
    *
    * @return A bool that is the current operating status
    */      
    function isOperational() 
                            public 
                            view 
                            returns(bool) 
    {
        return operational;
    }


    /**
    * @dev Sets contract operations on/off
    *
    * When operational mode is disabled, all write transactions except for this one will fail
    */    
    function setOperatingStatus
                            (
                                bool mode
                            ) 
                            external
                            requireContractOwner 
    {
        operational = mode;
    }

    function getNumberOfAirlines
                            (
                            ) 
                            requireIsOperational
                            external
                            returns(uint256)
    {
        return numberOfAirlines;
    }

    function authorizeCaller(address appToBeAuthorized) requireIsOperational requireContractOwner public returns(bool){
        authorizedApps[appToBeAuthorized] = true;
        return true;
    }

    function deAuthorizeCaller(address appToBeDeauthorized) requireIsOperational requireContractOwner public returns(bool){
        authorizedApps[appToBeDeauthorized] = false;
        return true;
    }

    function isAppAuthorized(address appAddress) public view returns(bool){
        return authorizedApps[appAddress];
    }

    function isAirlineRegistered(address airlineAddress) 
                            public 
                            view 
                            returns(bool) 
    {
        return airlines[airlineAddress].isRegistered;
    }

    function isAirlineFunded(address airlineAddress) 
                            public 
                            view 
                            returns(bool) 
    {
        return airlines[airlineAddress].isFunded;
    }

    function castAffirmativeVoteByAirline (address votingAirlineAddress, address votedAirlineAddress) requireCallerIsAnAuthorizedApp public {
        bool isDuplicate = false;
        for(uint i = 0; i < votesReceived[votedAirlineAddress].length; i++) {
            if (votesReceived[votedAirlineAddress][i] == votingAirlineAddress) {
                isDuplicate = true;
                break;
            }
        }
        require (!isDuplicate, "The voting airline has already voted for this airline.");
        
        votesReceived[votedAirlineAddress].push(votingAirlineAddress);

    }

    function getAffirmativeVotes (address airlineAddress) requireCallerIsAnAuthorizedApp public view returns(uint)  {
            return votesReceived[airlineAddress].length;
    }


    function addAirline (
                            address newAirlineAddress,
                            string newAirlineName
                        )
                        requireIsOperational
                        requireCallerIsAnAuthorizedApp 
                        public
    {
        airlines[newAirlineAddress].isRegistered = true;
        airlines[newAirlineAddress].isRegistered = false;
        airlines[newAirlineAddress].name = newAirlineName;
        ++numberOfAirlines;
        airlines[newAirlineAddress].ID = numberOfAirlines;
    }

    function setIsFunded
                            (
                                address airlineAddress,
                                bool fundedStatus
                            ) 
                            external
                            requireIsOperational
                            requireCallerIsAnAuthorizedApp 
    {
        airlines[airlineAddress].isFunded = fundedStatus;
    }

    function addPassengerFlightInsurance (
                            address passenger,
                            bytes32 flight,
                            uint256 insurance
                        )
                        requireIsOperational
                        requireCallerIsAnAuthorizedApp 
                        public
    {
        passengerInsuranceData[passenger].flightID = flight;
        passengerInsuranceData[passenger].insuranceAmount = insurance;
    }

    /********************************************************************************************/
    /*                                     SMART CONTRACT FUNCTIONS                             */
    /********************************************************************************************/

   /**
    * @dev Add an airline to the registration queue
    *      Can only be called from FlightSuretyApp contract
    *
    */   


   /**
    * @dev Buy insurance for a flight
    *
    */   
    function buy
                            (

                            )
                            external
                            payable
    {

    }

    /**
     *  @dev Credits payouts to insurees
    */
    function creditInsurees
                                (
                                )
                                external
                                pure
    {
    }
    

    /**
     *  @dev Transfers eligible payout funds to insuree
     *
    */
    function pay
                            (
                            )
                            external
                            pure
    {
    }

   /**
    * @dev Initial funding for the insurance. Unless there are too many delayed flights
    *      resulting in insurance payouts, the contract should be self-sustaining
    *
    */   
    function fund
                            (   
                            )
                            public
                            payable
    {
    }

    function getFlightKey
                        (
                            address airline,
                            string memory flight,
                            uint256 timestamp
                        )
                        pure
                        internal
                        returns(bytes32) 
    {
        return keccak256(abi.encodePacked(airline, flight, timestamp));
    }

    /**
    * @dev Fallback function for funding smart contract.
    *
    */
    function() 
                            external 
                            payable 
    {
        fund();
    }


}

