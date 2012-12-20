%%%=============================================================================
%%% @doc TVar tests
%%% @copyright 2012 Filipe Cristovao
%%% @end
%%%=============================================================================

%%%_* Module declaration =======================================================
-module(tvar_tests).

%%%_* Exports ==================================================================

%%%_* Includes =================================================================

-include_lib("proper/include/proper.hrl").
-include_lib("eunit/include/eunit.hrl").
-include_lib("proper_utility.hrl").

%%%_* Constants definition =====================================================

%%%_* Types definition =========================================================

%%%_* Code =====================================================================

%% creation_test() ->
%%   tvar:new(0).

%% different_types_test() ->
%%   _TInt  = tvar:new(0),
%%   _TBool = tvar:new(false),
%%   _TList = tvar:new([]).

property_test_() ->
  ?runProperTestsInEUnit.

prop_creation_works_with_any_type() ->
  ?FORALL(Value,
          any(),
          try tvar:new(Value) of
              _ -> true
          catch
            _ -> false
          end
         ).

%%%_* Emacs ====================================================================
%%% Local Variables:
%%% allout-layout: t
%%% erlang-indent-level: 2
%%% End:
