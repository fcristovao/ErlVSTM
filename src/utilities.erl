%%%=============================================================================
%%% @doc Utility functions
%%% @copyright 2012 Filipe Cristovao
%%% @end
%%%=============================================================================

%%%_* Module declaration =======================================================
-module(utilities).

%%%_* Exports ==================================================================
-export([ first/2
        ]).

%%%_* Includes =================================================================

%%%_* Constants definition =====================================================

%%%_* Types definition =========================================================

%%%_* Code =====================================================================

first(Pred, []) when is_function(Pred) -> throw(not_possible);
first(Pred, List) when is_function(Pred), is_list(List) ->
  [Head | _ ] = lists:dropwhile(Pred, List),
  Head.

%%%_* Emacs ====================================================================
%%% Local Variables:
%%% allout-layout: t
%%% erlang-indent-level: 2
%%% End:
