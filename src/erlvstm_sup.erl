%%%=============================================================================
%%% @doc ErlVSTM main supervisor
%%% @copyright 2012 Filipe Cristovao
%%% @end
%%%=============================================================================

%%%_* Module declaration =======================================================

-module(erlvstm_sup).
-behaviour(supervisor).

%%%_* Exports ==================================================================

-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%%%_* Constants definition =====================================================

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%%%_* Code =====================================================================

%%%_* API functions ------------------------------------------------------------

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%%%_* Supervisor callbacks -----------------------------------------------------

init([]) ->
    {ok, { {one_for_one, 5, 10}, []} }.

%%%_* Emacs ====================================================================
%%% Local Variables:
%%% allout-layout: t
%%% erlang-indent-level: 2
%%% End:
