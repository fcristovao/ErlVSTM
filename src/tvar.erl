%%%=============================================================================
%%% @doc Main file for the TVar operations
%%% @copyright 2012 Filipe Cristovao
%%% @end
%%%=============================================================================

%%%_* Module declaration =======================================================

-module(tvar).

%%%_* Exports ==================================================================
-export([ new/1
        , get/1
        , set/2
        , get_body/2
        ]).

%%%_* Includes =================================================================

-include_lib("tvar_gen_server_messages.hrl").

%%%_* Constants definition =====================================================

%%%_* Types definition =========================================================

-record(tvar_object, {pid :: pid()}).

-opaque tvar() :: #tvar_object{}.

-export_type([tvar/0]).

%%%_* Code =====================================================================

%%------------------------------------------------------------------------------
%% Function: new
%% Creates a new Transactional Variable
%%------------------------------------------------------------------------------
-spec new(InitialValue :: any()) -> tvar().
new(InitialValue) ->
  {ok, Pid} = gen_server:start(tvar_gen_server, InitialValue, []),
  #tvar_object{pid = Pid}.


get(TVar) ->
  Tmp = fun(Transaction) ->
          gen_server:call(pid(TVar),{?get, TVar, Transaction})
        end,
  maybeCreateTransactionAndRun(Tmp).

set(TVar, NewValue) ->
  Tmp = fun(Transaction) ->
          gen_server:call(pid(TVar),{?set, TVar, Transaction, NewValue})
        end,
  maybeCreateTransactionAndRun(Tmp).

maybeCreateTransactionAndRun(Function) ->
  CurrentTransaction = stm:get_current_transaction(),
  case CurrentTransaction of
    none ->
      stm:atomic(fun() -> Function(stm:get_current_transaction()) end);
    Transaction ->
      Function(Transaction)
  end.

get_body(TVar, Transaction)->
  gen_server:call(pid(TVar), {?getBody, TVar, Transaction}).


pid(#tvar_object{pid = Pid}) -> Pid.

%%%_* Emacs ====================================================================
%%% Local Variables:
%%% allout-layout: t
%%% erlang-indent-level: 2
%%% End:
