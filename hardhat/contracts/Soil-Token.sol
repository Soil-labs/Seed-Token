// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./IWhitelist.sol";

error CONTRACT_CURRENTLY_PAUSED();
error YOU_ARE_NOT_WHITELISTED();
error YOU_ALREADY_CLAIMED_REWARD();
error NOT_OWNER_OF_CONTRACT();

contract Seeds is ERC20 {
    // _paused is used to pause the contract in case of an emergency
    bool public _paused;

    // Whitelist contract instance
    IWhitelist whitelist;

    // onwer of the contract
    address public owner;

    // mapping to check which user have claim 100 seeds
    mapping(address => bool) public claim;

    // modifier to check Pause
    modifier onlyWhenNotPaused() {
        if (_paused) {
            revert CONTRACT_CURRENTLY_PAUSED();
        }
        _;
    }

    constructor(address whitelistContract, address _owner)
        ERC20("Seed", "Seed")
    {
        whitelist = IWhitelist(whitelistContract);
        owner = _owner;
    }

    // onlyOwner to check the owner
    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert NOT_OWNER_OF_CONTRACT();
        }
        _;
    }

    /**
     * @dev mint100 to mint 100 soil token
     */
    function mint100() public onlyWhenNotPaused {
        if (!whitelist.whitelistedAddresses(msg.sender)) {
            revert YOU_ARE_NOT_WHITELISTED();
        }
        if (claim[msg.sender] == true) {
            revert YOU_ALREADY_CLAIMED_REWARD();
        }
        claim[msg.sender] = true;
        _mint(msg.sender, 100);
    }

    /**
     * @dev setPaused makes the contract paused or unpaused
     */
    function Pause() public onlyOwner {
        _paused = true;
    }

    function unPause() public onlyOwner {
        _paused = false;
    }
}
