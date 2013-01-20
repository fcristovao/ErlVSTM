%%%=============================================================================
%%% @doc Transactions Gen Server
%%% @copyright 2012 Filipe Cristovao
%%% @end
%%%=============================================================================

%%%_* Module declaration =======================================================
-module(transaction_gen_server).
-behavior(gen_server).

%%%_* Exports ==================================================================

%% Gen Server Interface:
-export([ init/1
        , handle_call/3
        , handle_cast/2
        , handle_info/2
        , terminate/2
        , code_change/3
        ]).

%%%_* Includes =================================================================

-include_lib("transaction_gen_server_messages.hrl").

%%%_* Constants definition =====================================================

%%%_* Types definition =========================================================

-record(state, { tx_number :: integer()
               , readset   :: dict()
               , writeset  :: dict()
               }).

-type state()       :: #state{}.
-type tvar()        :: tvar:tvar().
-type transaction() :: transaction:transaction().

%%%_* Code =====================================================================

%%%_* Gen Server Interface -----------------------------------------------------

init(TxNumber) ->
  {ok, newState(TxNumber)}.

handle_call({?getTransactionNumber}, _From, State) ->
  {reply, tx_number(State), State};

handle_call({?getTVarValue, Transaction, TVar}, _From, State) ->
  {NewState, Result} = get_tvar_value(State, Transaction, TVar),
  {reply, Result, NewState}.

handle_cast({?setTVarValue, Transaction, TVar, NewValue}, State) ->
  NewState = set_tvar_value(State, Transaction, TVar, NewValue),
  {noreply, NewState};

handle_cast(Cast, State) ->
  utilities:unexpected(cast, Cast),
  {noreply, State}.

handle_info(Info, State) ->
  utilities:unexpected(info, Info),
  {noreply, State}.

terminate(_, _) -> ok.

code_change(_, State, _) -> {ok, State}.

%%%_* Internal functions -------------------------------------------------------

-spec get_tvar_value(state(), transaction(), tvar()) -> {state(), any()}.
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

-spec set_tvar_value(state(), transaction(), tvar(), any()) -> {state()}.
set_tvar_value(State, _Transaction, TVar, NewValue) ->
  add_to_writeset(State, TVar, NewValue).

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

add_to_writeset(State, TVar, NewValue) ->
  NewWriteSet = dict:append(TVar, NewValue, writeset(State)),
  set_writeset(State, NewWriteSet).


%%%_* Emacs ====================================================================
%%% Local Variables:
%%% allout-layout: t
%%% erlang-indent-level: 2
%%% End:
