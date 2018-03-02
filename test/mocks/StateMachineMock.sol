pragma solidity 0.4.19;

import "../../contracts/StateMachine.sol";


contract StateMachineMock is StateMachine {
    bytes4 public dummyFunctionSelector = this.dummyFunction.selector;

    bytes32 public constant STAGE0 = "STAGE0";
    bytes32 public constant STAGE1 = "STAGE1";
    bytes32 public constant STAGE2 = "STAGE2";
    bytes32 public constant STAGE3 = "STAGE3";
    bytes32[] stages = [STAGE0, STAGE1, STAGE2, STAGE3];

    bool condition = false;
    bool callbackCalled = false;

    function StateMachineMock() public { 
        state.setStages(stages);
    }

    function dummyFunction() public checkAllowed {
    }

    function dummyCondition() internal view returns(bool) {
        return true;
    }

    function dummyVariableCondition() internal view returns(bool) {
        return condition;
    }

    function dummyCallback() internal {
        callbackCalled = true;
    }

    // Helper to test creating transitions
    function createTransition(bytes32 fromId, bytes32 toId) public {
        state.createTransition(fromId, toId);
    }

    // Helper to test going to next stage
    function goToNextStageHelper() public {
        goToNextStage();
    }

    // Sets the dummy condition for a stage
    function setDummyCondition(bytes32 stageId) public {
        setStageStartCondition(stageId, dummyCondition);
    }

    function setCondition(bool _condition) public {
        condition = _condition;
    }

    // Sets the dummy callback condition for a stage
    function setDummyVariableCondition(bytes32 stageId) public {
        setStageStartCondition(stageId, dummyVariableCondition);
    }

    // Sets the dummy callback for a stage
    function setDummyCallback(bytes32 stageId) public {
        setStageCallback(stageId, dummyCallback);
    }

    // Helper to test allowing a function
    function allowFunction(bytes32 stageId, bytes4 selector) public {
        state.allowFunction(stageId, selector);
    }

}
