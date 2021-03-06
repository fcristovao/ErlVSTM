%%%=============================================================================
%%% @doc Main file for the TVar operations
%%% @copyright 2012 Filipe Cristovao
%%% @end
%%%=============================================================================

%%%_* Module declaration =======================================================
-module(tvar_gen_server).
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

-include_lib("tvar_gen_server_messages.hrl").

%%%_* Constants definition =====================================================


%%%_* Types definition =========================================================


%%%_* Code =====================================================================

%%%_* Gen Server Interface -----------------------------------------------------

init(InitialValue) ->
  {ok, vbox:new(InitialValue)}.

handle_call({?get, TVar, Transaction}, _From, _VBox) ->
  Result = get(TVar, Transaction),
  {reply, Result, _VBox};

handle_call({?set, TVar, Transaction, NewValue}, _From, _VBox) ->
  Result = set(TVar, Transaction, NewValue),
  {reply, Result, _VBox};

handle_call({?getBody, _TVar, Transaction}, _From, VBox) ->
  Result = getBody(VBox, Transaction),
  {reply, Result, VBox}.

handle_cast(Cast, State) ->
  utilities:unexpected(cast, Cast),
  {noreply, State}.

handle_info(Info, State) ->
  utilities:unexpected(info, Info),
  {noreply, State}.

terminate(_, _) -> ok.

code_change(_, State, _) -> {ok, State}.

%%%_* Internal functions -------------------------------------------------------

get(TVar, Transaction) ->
  transaction:get_tvar_value(Transaction, TVar).

set(TVar, Transaction, NewValue) ->
  transaction:set_tvar_value(Transaction, TVar, NewValue).

getBody(VBox, Transaction) ->
  vbox:get(VBox, transaction:tx_number(Transaction)).

%%%_* Emacs ====================================================================
%%% Local Variables:
%%% allout-layout: t
%%% erlang-indent-level: 2
%%% End:
