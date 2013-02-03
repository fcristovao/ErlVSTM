%%%=============================================================================
%%% @doc Transactions
%%% @copyright 2012 Filipe Cristovao
%%% @end
%%%=============================================================================

%%%_* Module declaration =======================================================

-module(transaction).

%%%_* Exports ==================================================================

-export([ new/1
        , get_tvar_value/2
        , set_tvar_value/3
        , tx_number/1
        , is_transaction/1
        ]).

%%%_* Includes =================================================================

-include_lib("transaction_gen_server_messages.hrl").

%%%_* Constants definition =====================================================

%%%_* Types definition =========================================================

-record(tx_object, {tx_number,
                    pid :: pid()}).

-opaque transaction() :: #tx_object{}.

-export_type([transaction/0]).

%%%_* Code =====================================================================

new(TxNumber) ->
  {ok, Pid} = gen_server:start(transaction_gen_server, TxNumber,[]),
  TxNr = gen_server:call(Pid, {?getTransactionNumber}),
  new(TxNr, Pid). %% the gen_server call might not be needed, since
%% basically it will have the same txnumber than the one we just sent

get_tvar_value(Transaction, TVar) ->
  gen_server:call(pid(Transaction), {?getTVarValue, Transaction, TVar}).

set_tvar_value(Transaction, TVar, NewValue) ->
  gen_server:cast(pid(Transaction), {?setTVarValue, Transaction, TVar, NewValue}).

commit(Transaction) ->
  gen_server:call(pid(Transaction), {?commit, Transaction}).

%%%_* Internal functions -------------------------------------------------------

new(TxNumber, Pid) ->
  #tx_object{tx_number = TxNumber, pid = Pid}.

pid(#tx_object{pid = Pid}) -> Pid.

tx_number(#tx_object{tx_number = TxNumber}) -> TxNumber.

is_transaction(AnyObject) ->
  is_record(AnyObject, tx_object).

%%%_* Emacs ====================================================================
%%% Local Variables:
%%% allout-layout: t
%%% erlang-indent-level: 2
%%% End:
