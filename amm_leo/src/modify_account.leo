import amm_state.AmmState;
import account.Account;

circuit SwapTransaction{
     account_id : u32
     token_a_amount : u32
}

function swap(state : AmmState, transaction : SwapTransaction) -> AmmState{
    let a = 0 - transaction.token_a_amount;
    let x = state.token_a_balance;
    let y = state.token_b_balance;
    let b = (y * a) / (x + a);

    let state = modify_account(state,transaction.account_id,a,b);

    let new_state = AmmState{account_dict_start: ,account_dict_end:0,token_a_balance:0,token_b_balance:0};
    new_state.account_dict_start = state.account_dict_start;
    new_state.account_dict_end = state.account_dict_end;
    new_state.token_a_balance = new_x;
    new_state.token_b_balance = new_y;
    return new_state;
}

function modify_account (state: AmmState, account_id : u32, diff_a : u32, diff_b : u32 ) ->  AmmState {
    let account_dict_end = state.account_dict_end;
    let old_account= account_dict_end[account_id][1];
    let new_token_a_balance = old_account.token_a_balance + diff_a;
    let new_token_b_balance = old_account.token_b_balance + diff_b;
    console.assert(new_token_a_balance >= 0);
    console.assert(new_token_b_balance >= 0);
    let new_account = Account{public_key: old_account.public_key, token_a_balance:old_account.token_a_balance, token_b_balance:old_account.token_b_balance};
    /**account_dict_end[account_id][1] = new_account; */
    let new_state = AmmState {account_dict_start : state.account_dict_start, account_dict_end : state.account_dict_end,token_a_balance : state.token_a_balance, token_b_balance : state.token_b_balance};
    return new_state;
}
    
