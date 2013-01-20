%%%=============================================================================
%%% @doc Main file for the STM operations
%%% @copyright 2012 Filipe Cristovao
%%% @end
%%%=============================================================================

%%%_* Module declaration =======================================================
-module(stm).

%%%_* Exports ==================================================================
-export([ atomic/1
        , create_transaction/0
        , get_current_transaction/0
        ]).

%%%_* Includes =================================================================
-include("include/stm.hrl").

%%%_* Constants definition =====================================================
-define(STM_TRANSACTION_KEY, stm_transaction_key).

%%%_* Types definition =========================================================

%%%_* Code =====================================================================

%%------------------------------------------------------------------------------
%% Function: atomic(Fun) -> _
%%------------------------------------------------------------------------------

atomic(Fun) ->
  %% Execute Fun in a transactional context
  case get_current_transaction() of
    none -> % No transaction has been started yet
      NewTransaction = create_transaction(),
      set_current_transaction(NewTransaction),
      true;
    _CurrentTransaction -> % There's already a transaction running.
      true
  end,
  Fun().


create_transaction() ->
  transaction:new(tx_counter:get()).

get_current_transaction() ->
  case get(?STM_TRANSACTION_KEY) of
    undefined -> % No transaction has been started yet
      none;
    CurrentTransaction ->
      CurrentTransaction
  end.

set_current_transaction(Transaction) ->
  put(?STM_TRANSACTION_KEY, Transaction).

%%%_* Emacs ====================================================================
%%% Local Variables:
%%% allout-layout: t
%%% erlang-indent-level: 2
%%% End:
