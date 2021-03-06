pragma solidity >=0.6.6;

pragma experimental ABIEncoderV2;


interface DyDxInterface {
  function ownerSetSpreadPremium ( uint256 marketId, tuple spreadPremium ) external;
  function getIsGlobalOperator ( address operator ) external view returns ( bool );
  function getMarketTokenAddress ( uint256 marketId ) external view returns ( address );
  function ownerSetInterestSetter ( uint256 marketId, address interestSetter ) external;
  function getAccountValues ( tuple account ) external view returns ( tuple, tuple );
  function getMarketPriceOracle ( uint256 marketId ) external view returns ( address );
  function getMarketInterestSetter ( uint256 marketId ) external view returns ( address );
  function getMarketSpreadPremium ( uint256 marketId ) external view returns ( tuple );
  function getNumMarkets (  ) external view returns ( uint256 );
  function ownerWithdrawUnsupportedTokens ( address token, address recipient ) external returns ( uint256 );
  function ownerSetMinBorrowedValue ( tuple minBorrowedValue ) external;
  function ownerSetLiquidationSpread ( tuple spread ) external;
  function ownerSetEarningsRate ( tuple earningsRate ) external;
  function getIsLocalOperator ( address owner, address operator ) external view returns ( bool );
  function getAccountPar ( tuple account, uint256 marketId ) external view returns ( tuple );
  function ownerSetMarginPremium ( uint256 marketId, tuple marginPremium ) external;
  function getMarginRatio (  ) external view returns ( tuple );
  function getMarketCurrentIndex ( uint256 marketId ) external view returns ( tuple );
  function getMarketIsClosing ( uint256 marketId ) external view returns ( bool );
  function getRiskParams (  ) external view returns ( tuple );
  function getAccountBalances ( tuple account ) external view returns ( address[], tuple[], tuple[] );
  function renounceOwnership (  ) external;
  function getMinBorrowedValue (  ) external view returns ( tuple );
  function setOperators ( tuple[] args ) external;
  function getMarketPrice ( uint256 marketId ) external view returns ( tuple );
  function owner (  ) external view returns ( address );
  function isOwner (  ) external view returns ( bool );
  function ownerWithdrawExcessTokens ( uint256 marketId, address recipient ) external returns ( uint256 );
  function ownerAddMarket ( address token, address priceOracle, address interestSetter, tuple marginPremium, tuple spreadPremium ) external;
  function operate ( tuple[] accounts, tuple[] actions ) external;
  function getMarketWithInfo ( uint256 marketId ) external view returns ( tuple, tuple, tuple, tuple );
  function ownerSetMarginRatio ( tuple ratio ) external;
  function getLiquidationSpread (  ) external view returns ( tuple );
  function getAccountWei ( tuple account, uint256 marketId ) external view returns ( tuple );
  function getMarketTotalPar ( uint256 marketId ) external view returns ( tuple );
  function getLiquidationSpreadForPair ( uint256 heldMarketId, uint256 owedMarketId ) external view returns ( tuple );
  function getNumExcessTokens ( uint256 marketId ) external view returns ( tuple );
  function getMarketCachedIndex ( uint256 marketId ) external view returns ( tuple );
  function getAccountStatus ( tuple account ) external view returns ( uint8 );
  function getEarningsRate (  ) external view returns ( tuple );
  function ownerSetPriceOracle ( uint256 marketId, address priceOracle ) external;
  function getRiskLimits (  ) external view returns ( tuple );
  function getMarket ( uint256 marketId ) external view returns ( tuple );
  function ownerSetIsClosing ( uint256 marketId, bool isClosing ) external;
  function ownerSetGlobalOperator ( address operator, bool approved ) external;
  function transferOwnership ( address newOwner ) external;
  function getAdjustedAccountValues ( tuple account ) external view returns ( tuple, tuple );
  function getMarketMarginPremium ( uint256 marketId ) external view returns ( tuple );
  function getMarketInterestRate ( uint256 marketId ) external view returns ( tuple );
}


 interface KollateralInterface {
  function currentRepaymentAmount (  ) external view returns ( uint256 );
  function currentSender (  ) external view returns ( address );
  function currentTokenAddress (  ) external view returns ( address );
  function currentTokenAmount (  ) external view returns ( uint256 );
  function estimateRepaymentAmount ( address tokenAddress, uint256 tokenAmount ) external view returns ( uint256 );
  function invoke ( address invokeTo, bytes invokeData, address tokenAddress, uint256 tokenAmount ) external payable;
  function invokeCallback (  ) external;
  function isOwner (  ) external view returns ( bool );
  function isTokenAddressRegistered ( address tokenAddress ) external view returns ( bool );
  function liquidityProxies ( address tokenAddress ) external view returns ( address[] );
  function owner (  ) external view returns ( address );
  function platformReward (  ) external view returns ( uint256 );
  function platformVaultAddress (  ) external view returns ( address );
  function poolReward (  ) external view returns ( uint256 );
  function poolRewardAddress ( address tokenAddress ) external view returns ( address );
  function removeStuckTokens ( address tokenAddress, address to, uint256 amount ) external returns ( bool );
  function renounceOwnership (  ) external;
  function setLiquidityProxies ( address tokenAddress, address[] liquidityProxies ) external;
  function setPlatformReward ( uint256 platformRewardBips ) external;
  function setPlatformVaultAddress ( address platformVaultAddress ) external;
  function setPoolReward ( uint256 poolRewardBips ) external;
  function setPoolRewardAddress ( address tokenAddress, address poolRewardAddress ) external;
  function totalLiquidity ( address tokenAddress ) external view returns ( uint256 );
  function transferOwnership ( address newOwner ) external;
}

// I have imported the Kollateral contract as i have NPM installed the module to this repo

import "@kollateral/contracts/invoke/IInvoker.sol";

import "@kollateral/contracts/invoke/KollateralInvokable.sol";

contract MyContract is KollateralInvokable {
  constructor () public { }
 
  function execute(bytes calldata data) external payable {
   
    // Here i will intereact with DYDX interface 
    // I will build a Webhook that calls the Kolkaterial contract 
    // The webhook will have the data to interact with DYDX interface and place Trades based on alerts on trading view 
    // This is where ProxyContracts will help Deploy and execute a series of operations in conjuction to the Flashloan Logic 
    // Once profit/loss has been made fees will be repaid and profit if made will be sent to a ne contract/wallet.
    
    
    repay();
  }
}

address internal _invokerAddress;

function myMethod() external payable {
  address to;
  bytes memory data;
  address tokenAddress;
  uint256 tokenAmount;
  IInvoker(_invokerAddress).invoke(to, data, tokenAddress, tokenAmount);
}


function execute(bytes calldata data) external payable {
  
  (uint256 myNum, bytes memory myData) = abi.decode(data, (uint256, bytes));
  // use params
  repay();
}