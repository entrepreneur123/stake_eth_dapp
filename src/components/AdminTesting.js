import React from "react";

import classes from "./AdminTesting.module.css";

export const AdminTesting = (props) => {
  return (
    <div className={classes.for_testing}>
      <p>FOR TESTING PURPOSE ONLY</p>
      <button onClick={props.claimTst}> Claim for 1000 Tst(user)</button>

      <button onClick={props.redistributeRewards}>
        {props.page === 1
          ? `Redistribute rewards(admin)`
          : `custom redistribution(admin)`}
      </button>
      <div className={classes.network}>
        <p>
          Selected Network:<b>{props.network.name}</b>
          $nbsp; id:<b>{props.network.id}</b>
        </p>

        <p>Contract Balance:{props.contractBalance}TestToken(Tst)</p>
        <p> Staking Contract address: {props.tokenStakingContract._address}</p>
      </div>
    </div>
  );
};
