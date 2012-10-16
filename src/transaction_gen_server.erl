%% -*- erlang-indent-level: 2 -*-
%%%=============================================================================
%%% @doc Transactions Gen Server
%%%
%%% @copyright 2012 Filipe Cristóvão
%%%
%%% @end
%%%=============================================================================

%%%_* Module declaration =======================================================
-module(transaction_gen_server).
-behavior(gen_server).

%%%_* Exports ==================================================================
-export([
        ]).

%%%_* Includes =================================================================


%%%_* Constants definition =====================================================
-define(TRANSACTION_NUMBER, transaction_number).

%%%_* Types definition =========================================================

-record(state, {readSet,
                writeSet
              }).

%%%_* Code =====================================================================

%%------------------------------------------------------------------------------
%% Function: transaction(Fun) -> _
%%------------------------------------------------------------------------------

init(TxNumber) ->
  undefined = put(?TRANSACTION_NUMBER, TxNumber),
  {ok, newState()}.

handle_call({getTransationNumber}, _From, _State) ->
  Result = getTransactionNumber(),
  {reply, Result, _State}

handle_call({getTVarValue, Transaction, TVar}, _From, State) ->
  {NewState, Result} = getTVarValue(State, Transaction, TVar),
  {reply, Result, NewState}


getTransactionNumber() ->
  get(?TRANSACTION_NUMBER).
  

getTVarValue(State, Transaction, TVar) ->
  Result =
    case getLocalTVarValue(TVar) of 
      none -> tvar:getBody(TVar, Transaction);
      {ok, Value} -> Value
    end.
  {addToReadSet(State, TVar), Result}


-spec getLocalTVarValue(state(), tvar()) -> {ok, any()} | none
getLocalTVarValue(State, TVar) ->
  case dict:find(TVar, writeSet(State)) of 
    error -> none;
    AnythingElse -> AnythingElse
  end.


addToReadSet(State, TVar) ->
  NewReadSet = dict:append(TVar,true,readSet(State)),
  setReadSet(State, NewReadSet).

newState() ->
  #state{ readSet  = dict:new(),
          writeSet = dict:new()}.

readSet(#state{readSet = ReadSet}) -> ReadSet.

setReadSet(State = #state{}, NewReadSet) ->
  State#state{readSet = NewReadSet}.

writeSet(#state{writeSet = WriteSet}) -> WriteSet.

setWriteSet(State = #state{}, NewWriteSet) ->
  State#state{writeSet = NewWriteSet}.


