%%%=============================================================================
%%% @doc VBoxBody tests
%%% @copyright 2012 Filipe Cristovao
%%% @end
%%%=============================================================================

%%%_* Module declaration =======================================================
-module(vbox_body_tests).

%%%_* Exports ==================================================================

%%%_* Includes =================================================================

-include_lib("proper/include/proper.hrl").
-include_lib("eunit/include/eunit.hrl").
-include_lib("proper_utility.hrl").

%%%_* Constants definition =====================================================

%%%_* Types definition =========================================================

-type vbox_body() :: vbox_body:vbox_body().

%%%_* Code =====================================================================

property_test_() ->
  ?runProperTestsInEUnit.

prop_creation_works_with_any_type() ->
  ?FORALL(Value,
          any(),
          try vbox_body:new(Value) of
              _ -> true
          catch
            _ -> false
          end
         ).

prop_default_version_is_zero() ->
  ?FORALL(Value,
          any(),
          begin
            VBoxBody = vbox_body:new(Value),
            vbox_body:version(VBoxBody) =:= 0
          end
         ).

prop_version_is_consistent() ->
  ?FORALL({Value, Version},
          {any(), non_neg_integer()},
          begin
            VBoxBody = vbox_body:new(Version, Value),
            vbox_body:version(VBoxBody) =:= Version
          end).

prop_valid_is_vbox_body() ->
  proper:conjunction(
    [{returns_true_when_vbox_body,
      ?FORALL(Value,
              vbox_body(),
              vbox_body:is_vbox_body(Value))
     },
     {returns_false_when_not_vbox_body,
      ?FORALL(Value,
              any(),
              not vbox_body:is_vbox_body(Value))
     }]).

prop_value_is_consistent() ->
  ?FORALL(Value,
          any(),
          begin
            VBoxBody = vbox_body:new(Value),
            vbox_body:value(VBoxBody) =:= Value
          end
         ).

%%%_* Emacs ====================================================================
%%% Local Variables:
%%% allout-layout: t
%%% erlang-indent-level: 2
%%% End:














