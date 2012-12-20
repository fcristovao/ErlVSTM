%%%=============================================================================
%%% @doc Transactions Gen Server
%%% @copyright 2012 Filipe Cristovao
%%% @end
%%%=============================================================================

%%%_* Module declaration =======================================================
-module(transaction_gen_server).
-behavior(gen_server).

%%%_* Exports ==================================================================
-export([ init/1
        , handle_call/3
%        , handle_info/2
        ]).

%%%_* Includes =================================================================

-include_lib("transaction_gen_server_messages.hrl").

%%%_* Constants definition =====================================================
%-define(TRANSACTION_NUMBER, transaction_number).

%%%_* Types definition =========================================================

-record(state, { tx_number :: integer()
               , readset
               , writeset
               }).

-type state() :: #state{}.
-type tvar()  :: tvar:tvar().

%%%_* Code =====================================================================

%%------------------------------------------------------------------------------
%% Function: transaction(Fun) -> _
%%------------------------------------------------------------------------------

init(TxNumber) ->
  {ok, newState(TxNumber)}.

handle_call({?getTransactionNumber}, _From, State) ->
  {reply, tx_number(State), State};

handle_call({?getTVarValue, Transaction, TVar}, _From, State) ->
  {NewState, Result} = get_tvar_value(State, Transaction, TVar),
  {reply, Result, NewState}.


get_tvar_value(State, Transaction, TVar) ->
  Result =
    case get_local_tvar_value(State, TVar) of
      none -> tvar:get_body(TVar, Transaction);
      {ok, Value} -> Value
    end,
  {add_to_readset(State, TVar), Result}.


-spec get_local_tvar_value(state(), tvar()) -> {ok, any()} | none.
get_local_tvar_value(State, TVar) ->
  case dict:find(TVar, writeset(State)) of
    error -> none;
    AnythingElse -> AnythingElse
  end.


%%%_* Internal functions -------------------------------------------------------

newState(TxNumber) ->
  #state{ tx_number = TxNumber,
          readset   = dict:new(),
          writeset  = dict:new()
        }.

tx_number(#state{tx_number = TxNumber}) -> TxNumber.

readset(#state{readset = Readset}) -> Readset.

set_readset(State = #state{}, NewReadset) ->
  State#state{readset = NewReadset}.


add_to_readset(State, TVar) ->
  NewReadSet = dict:append(TVar, true, readset(State)),
  set_readset(State, NewReadSet).

writeset(#state{writeset = Writeset}) -> Writeset.

set_writeset(State = #state{}, NewWriteset) ->
  State#state{writeset = NewWriteset}.


%%%_* Emacs ====================================================================
%%% Local Variables:
%%% allout-layout: t
%%% erlang-indent-level: 2
%%% End:
