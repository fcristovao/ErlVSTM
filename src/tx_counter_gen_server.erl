%%%=============================================================================
%%% @doc Transactions Counter
%%% @copyright 2012 Filipe Cristóvão
%%% @end
%%%=============================================================================

%%%_* Module declaration =======================================================
-module(tx_counter_gen_server).
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

-export([ start_link/0
        ]).

%%%_* Includes =================================================================

-include_lib("tx_counter_gen_server_messages.hrl").

%%%_* Constants definition =====================================================

%%%_* Types definition =========================================================

%%%_* Code =====================================================================

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, no_arguments, []).

%%%_* Gen Server Interface -----------------------------------------------------

init(no_arguments) ->
  {ok, 0}.

handle_call({?get}, _From, CurrentValue) ->
  {reply, CurrentValue, CurrentValue};

handle_call({?get_and_increment}, _From, CurrentValue) ->
  {reply, CurrentValue, CurrentValue + 1};

handle_call({?increment_and_get}, _From, CurrentValue) ->
  {reply, CurrentValue + 1, CurrentValue + 1}.

handle_cast(Cast, State) ->
  utilities:unexpected(cast, Cast),
  {noreply, State}.

handle_info(Info, State) ->
  utilities:unexpected(info, Info),
  {noreply, State}.

terminate(_, _) -> ok.

code_change(_, State, _) -> {ok, State}.

%%%_* Emacs ====================================================================
%%% Local Variables:
%%% allout-layout: t
%%% erlang-indent-level: 2
%%% End: