// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address to, uint256 amount) external returns (bool);

    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}

abstract contract ReentrancyGuard {
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    uint256 private _status;

    constructor() {
        _status = _NOT_ENTERED;
    }

    modifier nonReentrant() {
        _nonReentrantBefore();
        _;
        _nonReentrantAfter();
    }

    function _nonReentrantBefore() private {
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");

        _status = _ENTERED;
    }

    function _nonReentrantAfter() private {
        _status = _NOT_ENTERED;
    }
}
error NotOwner();

contract DivineAuraBliss is ReentrancyGuard {
    IERC20 public token;
    address private owner;
    uint256 public currentCountedAura;
    struct Spirit {
        string aura;
        address provider;
        uint256 blissGained;
    }
    mapping(uint256 => Spirit) private auras;
    mapping(address => string) private auraProvider;
    Spirit[] public auraList;

    constructor() {
        owner = msg.sender;
    }

    function shareAura(string memory _aura) public nonReentrant {
        uint256 quoteLength = bytes(_aura).length;
        Spirit memory spirit = Spirit(_aura, msg.sender, quoteLength);
        auraList.push(spirit);
        currentCountedAura++;
        auras[currentCountedAura] = spirit;
        if (token.balanceOf(address(this)) >= quoteLength) {
            token.transfer(msg.sender, quoteLength);
        }
    }

    function setToken(address _token) public {
        if (msg.sender != owner) revert NotOwner();
        token = IERC20(_token);
    }

    function createOrUpdateProfile(string memory _url) public {
        auraProvider[msg.sender] = _url;
    }

    function getAuraList() public view returns (Spirit[] memory) {
        return auraList;
    }

    function getAuras() public view returns (Spirit[] memory) {
        Spirit[] memory list = new Spirit[](currentCountedAura);
        for (uint256 i = 0; i < currentCountedAura; i++) {
            list[i] = auras[i + 1];
        }
        return list;
    }

    function getAddressToProfile(
        address _provider
    ) public view returns (string memory) {
        return auraProvider[_provider];
    }
}
