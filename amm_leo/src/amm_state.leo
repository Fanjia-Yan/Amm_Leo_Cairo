import account.Account;
circuit AmmState{
    account_dict_start : [[Account; 2]; 100]
    account_dict_end : [[Account; 2]; 100]
    token_a_balance : u32
    token_b_balance : u32
}