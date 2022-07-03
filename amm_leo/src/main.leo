// The 'amm' main function.
import amm_state.AmmState;
import account.Account;
import modify_account.*;
import ammbatchoutput.AmmBatchOutput;

function transaction_loop(state : AmmState, transactions : SwapTransaction ,n_transactions : u32) -> AmmState{
    if (n_transactions == 0){
        return state;
    }

    let first_transaction = transactions;
    let state = swap(
        state, first_transaction
    );

    return transaction_loop(
        state,
        transactions + 1,
        n_transactions - 1,
    );
}


function main(output_ptr : u32) -> u32 {
    let account_dict = get_account_dict();

    let output_ptr = output_ptr + AmmBatchOutput.SIZE;

    let (transactions, n_transactions) = get_transactions();
    let state = transaction_loop(state,transactions,n_transactions);


    let (root_before, root_after) = compute_merkle_roots(state);

    return 0;
}

