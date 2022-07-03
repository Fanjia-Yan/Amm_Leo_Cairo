import amm_state.AmmState;
circuit SwapTranscation{
    account_id : u32
    token_a_amount : u32
}
const MAX_BALANCE = 2**64 -1;
function swap (state : AmmState, transcation : SwapTranscation) -> AmmState{
    let a = transcation.token_a_amount;
    let x = state.token_a_balance;
    let y = state.token_b_balance;

    console.assert(a >= 0);
    console.assert(a <= MAX_BALANCE);

    let b = (y * a ) / (x + a);

    console.assert(b >= 0);
    console.assert(b <= MAX_BALANCE);

    let state = modify_account(state : state, account_id : transcation.account_id, diff_a : a, diff_b : b);
    let new_x = x + a;
    let new_y = y - a;
    console.assert(new_x >= 0);
    console.assert(new_y >= 0);

    let new_state = AmmState {account_dict_start : state.account_dict_start, account_dict_end : state.account_dict_end,token_a_balance : new_x, token_b_balance : new_y};

    return new_state;
}