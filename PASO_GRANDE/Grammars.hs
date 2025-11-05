{-# OPTIONS_GHC -w #-}
module Grammars where

import Lex (Token(..), lexer)
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.20.1.1

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11
	= HappyTerminal (Token)
	| HappyErrorToken Prelude.Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 t11

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,251) ([30720,1,0,32772,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,63864,65535,2039,6016,0,16384,0,0,0,0,64,0,0,512,0,0,6016,0,16384,30720,1,0,32772,23,0,64,376,0,1024,6016,0,16384,30720,1,0,32772,23,0,64,376,0,1024,6016,0,16384,30720,1,0,32772,23,0,64,376,0,1024,6016,0,16384,30720,1,0,32772,23,0,64,376,0,1024,6016,0,16384,30720,1,0,4,4,0,0,64,0,0,1024,0,0,16384,0,0,32768,23,0,64,376,0,1024,4096,0,0,30720,1,0,32772,23,0,64,376,0,1024,6016,0,16384,30720,1,0,32772,23,0,64,128,0,0,2048,0,0,32768,0,0,0,8,0,0,128,0,0,6016,0,16384,32768,0,0,0,16,0,0,376,0,1032,6016,0,16384,30720,1,0,32772,0,0,0,8,0,0,1024,0,0,16384,0,0,32768,23,0,64,376,0,1024,2048,0,0,30720,1,0,32772,23,0,64,376,0,1024,6016,0,16384,30720,1,0,32772,23,0,64,376,0,1024,2048,0,0,32768,0,0,0,8,0,0,376,0,1024,6016,0,16384,30720,1,0,32772,23,0,64,376,0,1024,2048,0,0,0,0,0,32768,23,0,64,0,0,0,0,0,0,0,0,0,32768,23,0,64,376,0,1024,6016,0,16384,30720,1,0,4,0,0,0,0,0,0,0,0,0,32768,0,0,32768,23,0,64,376,0,1024,6016,0,16384,30720,1,0,32772,23,0,64,376,0,1024,0,0,0,30720,1,0,32772,23,0,64,128,0,0,128,0,0,32768,0,0,32768,23,0,64,128,0,0,128,0,0,30720,1,0,32772,23,0,64,376,0,1024,6016,0,16384,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,512,0,0,2048,0,0,32768,0,0,0,0,0,0,376,0,1024,2048,0,0,30720,1,0,32772,23,0,64,376,0,1024,6016,0,16384,32768,0,0,0,8,0,0,128,0,0,2048,0,0,32768,0,0,0,8,0,0,128,0,0,2048,0,0,0,0,0,0,8,0,0,128,0,0,2048,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,2048,0,0,32768,0,0,32768,23,0,64,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","SASA","SASAList","ListElements","Bindings","Params","AppArgs","CondClauses","CondClause","var","int","bool","'('","')'","'['","']'","','","'+'","'-'","'*'","'/'","add1","sub1","sqrt","expt","'='","'<'","'>'","'<='","'>='","'!='","not","and","or","let","letstar","letrec","lambda","if0","if","cond","else","pair","fst","snd","head","tail","nullQ","empty","%eof"]
        bit_start = st Prelude.* 52
        bit_end = (st Prelude.+ 1) Prelude.* 52
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..51]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (12) = happyShift action_2
action_0 (13) = happyShift action_4
action_0 (14) = happyShift action_5
action_0 (15) = happyShift action_6
action_0 (17) = happyShift action_7
action_0 (51) = happyShift action_8
action_0 (4) = happyGoto action_3
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (12) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 (52) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 _ = happyReduce_2

action_5 _ = happyReduce_3

action_6 (12) = happyShift action_2
action_6 (13) = happyShift action_4
action_6 (14) = happyShift action_5
action_6 (15) = happyShift action_6
action_6 (17) = happyShift action_7
action_6 (20) = happyShift action_12
action_6 (21) = happyShift action_13
action_6 (22) = happyShift action_14
action_6 (23) = happyShift action_15
action_6 (24) = happyShift action_16
action_6 (25) = happyShift action_17
action_6 (26) = happyShift action_18
action_6 (27) = happyShift action_19
action_6 (28) = happyShift action_20
action_6 (29) = happyShift action_21
action_6 (30) = happyShift action_22
action_6 (31) = happyShift action_23
action_6 (32) = happyShift action_24
action_6 (33) = happyShift action_25
action_6 (34) = happyShift action_26
action_6 (35) = happyShift action_27
action_6 (36) = happyShift action_28
action_6 (37) = happyShift action_29
action_6 (38) = happyShift action_30
action_6 (39) = happyShift action_31
action_6 (40) = happyShift action_32
action_6 (41) = happyShift action_33
action_6 (42) = happyShift action_34
action_6 (43) = happyShift action_35
action_6 (45) = happyShift action_36
action_6 (46) = happyShift action_37
action_6 (47) = happyShift action_38
action_6 (48) = happyShift action_39
action_6 (49) = happyShift action_40
action_6 (50) = happyShift action_41
action_6 (51) = happyShift action_8
action_6 (4) = happyGoto action_11
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (12) = happyShift action_2
action_7 (13) = happyShift action_4
action_7 (14) = happyShift action_5
action_7 (15) = happyShift action_6
action_7 (17) = happyShift action_7
action_7 (51) = happyShift action_8
action_7 (4) = happyGoto action_9
action_7 (6) = happyGoto action_10
action_7 _ = happyReduce_39

action_8 _ = happyReduce_4

action_9 (19) = happyShift action_77
action_9 _ = happyReduce_40

action_10 (18) = happyShift action_76
action_10 _ = happyFail (happyExpListPerState 10)

action_11 (12) = happyShift action_2
action_11 (13) = happyShift action_4
action_11 (14) = happyShift action_5
action_11 (15) = happyShift action_6
action_11 (17) = happyShift action_7
action_11 (51) = happyShift action_8
action_11 (4) = happyGoto action_74
action_11 (9) = happyGoto action_75
action_11 _ = happyFail (happyExpListPerState 11)

action_12 (12) = happyShift action_2
action_12 (13) = happyShift action_4
action_12 (14) = happyShift action_5
action_12 (15) = happyShift action_6
action_12 (17) = happyShift action_7
action_12 (51) = happyShift action_8
action_12 (4) = happyGoto action_73
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (12) = happyShift action_2
action_13 (13) = happyShift action_4
action_13 (14) = happyShift action_5
action_13 (15) = happyShift action_6
action_13 (17) = happyShift action_7
action_13 (51) = happyShift action_8
action_13 (4) = happyGoto action_72
action_13 _ = happyFail (happyExpListPerState 13)

action_14 (12) = happyShift action_2
action_14 (13) = happyShift action_4
action_14 (14) = happyShift action_5
action_14 (15) = happyShift action_6
action_14 (17) = happyShift action_7
action_14 (51) = happyShift action_8
action_14 (4) = happyGoto action_71
action_14 _ = happyFail (happyExpListPerState 14)

action_15 (12) = happyShift action_2
action_15 (13) = happyShift action_4
action_15 (14) = happyShift action_5
action_15 (15) = happyShift action_6
action_15 (17) = happyShift action_7
action_15 (51) = happyShift action_8
action_15 (4) = happyGoto action_70
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (12) = happyShift action_2
action_16 (13) = happyShift action_4
action_16 (14) = happyShift action_5
action_16 (15) = happyShift action_6
action_16 (17) = happyShift action_7
action_16 (51) = happyShift action_8
action_16 (4) = happyGoto action_69
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (12) = happyShift action_2
action_17 (13) = happyShift action_4
action_17 (14) = happyShift action_5
action_17 (15) = happyShift action_6
action_17 (17) = happyShift action_7
action_17 (51) = happyShift action_8
action_17 (4) = happyGoto action_68
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (12) = happyShift action_2
action_18 (13) = happyShift action_4
action_18 (14) = happyShift action_5
action_18 (15) = happyShift action_6
action_18 (17) = happyShift action_7
action_18 (51) = happyShift action_8
action_18 (4) = happyGoto action_67
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (12) = happyShift action_2
action_19 (13) = happyShift action_4
action_19 (14) = happyShift action_5
action_19 (15) = happyShift action_6
action_19 (17) = happyShift action_7
action_19 (51) = happyShift action_8
action_19 (4) = happyGoto action_66
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (12) = happyShift action_2
action_20 (13) = happyShift action_4
action_20 (14) = happyShift action_5
action_20 (15) = happyShift action_6
action_20 (17) = happyShift action_7
action_20 (51) = happyShift action_8
action_20 (4) = happyGoto action_65
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (12) = happyShift action_2
action_21 (13) = happyShift action_4
action_21 (14) = happyShift action_5
action_21 (15) = happyShift action_6
action_21 (17) = happyShift action_7
action_21 (51) = happyShift action_8
action_21 (4) = happyGoto action_64
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (12) = happyShift action_2
action_22 (13) = happyShift action_4
action_22 (14) = happyShift action_5
action_22 (15) = happyShift action_6
action_22 (17) = happyShift action_7
action_22 (51) = happyShift action_8
action_22 (4) = happyGoto action_63
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (12) = happyShift action_2
action_23 (13) = happyShift action_4
action_23 (14) = happyShift action_5
action_23 (15) = happyShift action_6
action_23 (17) = happyShift action_7
action_23 (51) = happyShift action_8
action_23 (4) = happyGoto action_62
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (12) = happyShift action_2
action_24 (13) = happyShift action_4
action_24 (14) = happyShift action_5
action_24 (15) = happyShift action_6
action_24 (17) = happyShift action_7
action_24 (51) = happyShift action_8
action_24 (4) = happyGoto action_61
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (12) = happyShift action_2
action_25 (13) = happyShift action_4
action_25 (14) = happyShift action_5
action_25 (15) = happyShift action_6
action_25 (17) = happyShift action_7
action_25 (51) = happyShift action_8
action_25 (4) = happyGoto action_60
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (12) = happyShift action_2
action_26 (13) = happyShift action_4
action_26 (14) = happyShift action_5
action_26 (15) = happyShift action_6
action_26 (17) = happyShift action_7
action_26 (51) = happyShift action_8
action_26 (4) = happyGoto action_59
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (12) = happyShift action_2
action_27 (13) = happyShift action_4
action_27 (14) = happyShift action_5
action_27 (15) = happyShift action_6
action_27 (17) = happyShift action_7
action_27 (51) = happyShift action_8
action_27 (4) = happyGoto action_58
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (12) = happyShift action_2
action_28 (13) = happyShift action_4
action_28 (14) = happyShift action_5
action_28 (15) = happyShift action_6
action_28 (17) = happyShift action_7
action_28 (51) = happyShift action_8
action_28 (4) = happyGoto action_57
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (15) = happyShift action_56
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (15) = happyShift action_55
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (15) = happyShift action_54
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (15) = happyShift action_53
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (12) = happyShift action_2
action_33 (13) = happyShift action_4
action_33 (14) = happyShift action_5
action_33 (15) = happyShift action_6
action_33 (17) = happyShift action_7
action_33 (51) = happyShift action_8
action_33 (4) = happyGoto action_52
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (12) = happyShift action_2
action_34 (13) = happyShift action_4
action_34 (14) = happyShift action_5
action_34 (15) = happyShift action_6
action_34 (17) = happyShift action_7
action_34 (51) = happyShift action_8
action_34 (4) = happyGoto action_51
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (17) = happyShift action_50
action_35 (10) = happyGoto action_48
action_35 (11) = happyGoto action_49
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (12) = happyShift action_2
action_36 (13) = happyShift action_4
action_36 (14) = happyShift action_5
action_36 (15) = happyShift action_6
action_36 (17) = happyShift action_7
action_36 (51) = happyShift action_8
action_36 (4) = happyGoto action_47
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (12) = happyShift action_2
action_37 (13) = happyShift action_4
action_37 (14) = happyShift action_5
action_37 (15) = happyShift action_6
action_37 (17) = happyShift action_7
action_37 (51) = happyShift action_8
action_37 (4) = happyGoto action_46
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (12) = happyShift action_2
action_38 (13) = happyShift action_4
action_38 (14) = happyShift action_5
action_38 (15) = happyShift action_6
action_38 (17) = happyShift action_7
action_38 (51) = happyShift action_8
action_38 (4) = happyGoto action_45
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (12) = happyShift action_2
action_39 (13) = happyShift action_4
action_39 (14) = happyShift action_5
action_39 (15) = happyShift action_6
action_39 (17) = happyShift action_7
action_39 (51) = happyShift action_8
action_39 (4) = happyGoto action_44
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (12) = happyShift action_2
action_40 (13) = happyShift action_4
action_40 (14) = happyShift action_5
action_40 (15) = happyShift action_6
action_40 (17) = happyShift action_7
action_40 (51) = happyShift action_8
action_40 (4) = happyGoto action_43
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (12) = happyShift action_2
action_41 (13) = happyShift action_4
action_41 (14) = happyShift action_5
action_41 (15) = happyShift action_6
action_41 (17) = happyShift action_7
action_41 (51) = happyShift action_8
action_41 (4) = happyGoto action_42
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (16) = happyShift action_115
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (16) = happyShift action_114
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (16) = happyShift action_113
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (16) = happyShift action_112
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (16) = happyShift action_111
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (12) = happyShift action_2
action_47 (13) = happyShift action_4
action_47 (14) = happyShift action_5
action_47 (15) = happyShift action_6
action_47 (17) = happyShift action_7
action_47 (51) = happyShift action_8
action_47 (4) = happyGoto action_110
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (16) = happyShift action_109
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (17) = happyShift action_50
action_49 (10) = happyGoto action_108
action_49 (11) = happyGoto action_49
action_49 _ = happyReduce_49

action_50 (12) = happyShift action_2
action_50 (13) = happyShift action_4
action_50 (14) = happyShift action_5
action_50 (15) = happyShift action_6
action_50 (17) = happyShift action_7
action_50 (44) = happyShift action_107
action_50 (51) = happyShift action_8
action_50 (4) = happyGoto action_106
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (12) = happyShift action_2
action_51 (13) = happyShift action_4
action_51 (14) = happyShift action_5
action_51 (15) = happyShift action_6
action_51 (17) = happyShift action_7
action_51 (51) = happyShift action_8
action_51 (4) = happyGoto action_105
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (12) = happyShift action_2
action_52 (13) = happyShift action_4
action_52 (14) = happyShift action_5
action_52 (15) = happyShift action_6
action_52 (17) = happyShift action_7
action_52 (51) = happyShift action_8
action_52 (4) = happyGoto action_104
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (12) = happyShift action_103
action_53 (8) = happyGoto action_102
action_53 _ = happyReduce_44

action_54 (12) = happyShift action_101
action_54 _ = happyFail (happyExpListPerState 54)

action_55 (15) = happyShift action_99
action_55 (7) = happyGoto action_100
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (15) = happyShift action_99
action_56 (7) = happyGoto action_98
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (12) = happyShift action_2
action_57 (13) = happyShift action_4
action_57 (14) = happyShift action_5
action_57 (15) = happyShift action_6
action_57 (17) = happyShift action_7
action_57 (51) = happyShift action_8
action_57 (4) = happyGoto action_97
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (12) = happyShift action_2
action_58 (13) = happyShift action_4
action_58 (14) = happyShift action_5
action_58 (15) = happyShift action_6
action_58 (17) = happyShift action_7
action_58 (51) = happyShift action_8
action_58 (4) = happyGoto action_96
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (16) = happyShift action_95
action_59 _ = happyFail (happyExpListPerState 59)

action_60 (12) = happyShift action_2
action_60 (13) = happyShift action_4
action_60 (14) = happyShift action_5
action_60 (15) = happyShift action_6
action_60 (17) = happyShift action_7
action_60 (51) = happyShift action_8
action_60 (4) = happyGoto action_94
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (12) = happyShift action_2
action_61 (13) = happyShift action_4
action_61 (14) = happyShift action_5
action_61 (15) = happyShift action_6
action_61 (17) = happyShift action_7
action_61 (51) = happyShift action_8
action_61 (4) = happyGoto action_93
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (12) = happyShift action_2
action_62 (13) = happyShift action_4
action_62 (14) = happyShift action_5
action_62 (15) = happyShift action_6
action_62 (17) = happyShift action_7
action_62 (51) = happyShift action_8
action_62 (4) = happyGoto action_92
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (12) = happyShift action_2
action_63 (13) = happyShift action_4
action_63 (14) = happyShift action_5
action_63 (15) = happyShift action_6
action_63 (17) = happyShift action_7
action_63 (51) = happyShift action_8
action_63 (4) = happyGoto action_91
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (12) = happyShift action_2
action_64 (13) = happyShift action_4
action_64 (14) = happyShift action_5
action_64 (15) = happyShift action_6
action_64 (17) = happyShift action_7
action_64 (51) = happyShift action_8
action_64 (4) = happyGoto action_90
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (12) = happyShift action_2
action_65 (13) = happyShift action_4
action_65 (14) = happyShift action_5
action_65 (15) = happyShift action_6
action_65 (17) = happyShift action_7
action_65 (51) = happyShift action_8
action_65 (4) = happyGoto action_89
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (12) = happyShift action_2
action_66 (13) = happyShift action_4
action_66 (14) = happyShift action_5
action_66 (15) = happyShift action_6
action_66 (17) = happyShift action_7
action_66 (51) = happyShift action_8
action_66 (4) = happyGoto action_88
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (16) = happyShift action_87
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (16) = happyShift action_86
action_68 _ = happyFail (happyExpListPerState 68)

action_69 (16) = happyShift action_85
action_69 _ = happyFail (happyExpListPerState 69)

action_70 (12) = happyShift action_2
action_70 (13) = happyShift action_4
action_70 (14) = happyShift action_5
action_70 (15) = happyShift action_6
action_70 (17) = happyShift action_7
action_70 (51) = happyShift action_8
action_70 (4) = happyGoto action_84
action_70 _ = happyFail (happyExpListPerState 70)

action_71 (12) = happyShift action_2
action_71 (13) = happyShift action_4
action_71 (14) = happyShift action_5
action_71 (15) = happyShift action_6
action_71 (17) = happyShift action_7
action_71 (51) = happyShift action_8
action_71 (4) = happyGoto action_83
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (12) = happyShift action_2
action_72 (13) = happyShift action_4
action_72 (14) = happyShift action_5
action_72 (15) = happyShift action_6
action_72 (17) = happyShift action_7
action_72 (51) = happyShift action_8
action_72 (4) = happyGoto action_82
action_72 _ = happyFail (happyExpListPerState 72)

action_73 (12) = happyShift action_2
action_73 (13) = happyShift action_4
action_73 (14) = happyShift action_5
action_73 (15) = happyShift action_6
action_73 (17) = happyShift action_7
action_73 (51) = happyShift action_8
action_73 (4) = happyGoto action_81
action_73 _ = happyFail (happyExpListPerState 73)

action_74 (12) = happyShift action_2
action_74 (13) = happyShift action_4
action_74 (14) = happyShift action_5
action_74 (15) = happyShift action_6
action_74 (17) = happyShift action_7
action_74 (51) = happyShift action_8
action_74 (4) = happyGoto action_74
action_74 (9) = happyGoto action_80
action_74 _ = happyReduce_47

action_75 (16) = happyShift action_79
action_75 _ = happyFail (happyExpListPerState 75)

action_76 _ = happyReduce_25

action_77 (12) = happyShift action_2
action_77 (13) = happyShift action_4
action_77 (14) = happyShift action_5
action_77 (15) = happyShift action_6
action_77 (17) = happyShift action_7
action_77 (51) = happyShift action_8
action_77 (4) = happyGoto action_9
action_77 (6) = happyGoto action_78
action_77 _ = happyReduce_39

action_78 _ = happyReduce_41

action_79 _ = happyReduce_36

action_80 _ = happyReduce_48

action_81 (12) = happyShift action_2
action_81 (13) = happyShift action_4
action_81 (14) = happyShift action_5
action_81 (15) = happyShift action_6
action_81 (17) = happyShift action_7
action_81 (51) = happyShift action_8
action_81 (4) = happyGoto action_127
action_81 (5) = happyGoto action_140
action_81 _ = happyReduce_37

action_82 (12) = happyShift action_2
action_82 (13) = happyShift action_4
action_82 (14) = happyShift action_5
action_82 (15) = happyShift action_6
action_82 (17) = happyShift action_7
action_82 (51) = happyShift action_8
action_82 (4) = happyGoto action_127
action_82 (5) = happyGoto action_139
action_82 _ = happyReduce_37

action_83 (12) = happyShift action_2
action_83 (13) = happyShift action_4
action_83 (14) = happyShift action_5
action_83 (15) = happyShift action_6
action_83 (17) = happyShift action_7
action_83 (51) = happyShift action_8
action_83 (4) = happyGoto action_127
action_83 (5) = happyGoto action_138
action_83 _ = happyReduce_37

action_84 (12) = happyShift action_2
action_84 (13) = happyShift action_4
action_84 (14) = happyShift action_5
action_84 (15) = happyShift action_6
action_84 (17) = happyShift action_7
action_84 (51) = happyShift action_8
action_84 (4) = happyGoto action_127
action_84 (5) = happyGoto action_137
action_84 _ = happyReduce_37

action_85 _ = happyReduce_9

action_86 _ = happyReduce_10

action_87 _ = happyReduce_11

action_88 (16) = happyShift action_136
action_88 _ = happyFail (happyExpListPerState 88)

action_89 (12) = happyShift action_2
action_89 (13) = happyShift action_4
action_89 (14) = happyShift action_5
action_89 (15) = happyShift action_6
action_89 (17) = happyShift action_7
action_89 (51) = happyShift action_8
action_89 (4) = happyGoto action_127
action_89 (5) = happyGoto action_135
action_89 _ = happyReduce_37

action_90 (12) = happyShift action_2
action_90 (13) = happyShift action_4
action_90 (14) = happyShift action_5
action_90 (15) = happyShift action_6
action_90 (17) = happyShift action_7
action_90 (51) = happyShift action_8
action_90 (4) = happyGoto action_127
action_90 (5) = happyGoto action_134
action_90 _ = happyReduce_37

action_91 (12) = happyShift action_2
action_91 (13) = happyShift action_4
action_91 (14) = happyShift action_5
action_91 (15) = happyShift action_6
action_91 (17) = happyShift action_7
action_91 (51) = happyShift action_8
action_91 (4) = happyGoto action_127
action_91 (5) = happyGoto action_133
action_91 _ = happyReduce_37

action_92 (12) = happyShift action_2
action_92 (13) = happyShift action_4
action_92 (14) = happyShift action_5
action_92 (15) = happyShift action_6
action_92 (17) = happyShift action_7
action_92 (51) = happyShift action_8
action_92 (4) = happyGoto action_127
action_92 (5) = happyGoto action_132
action_92 _ = happyReduce_37

action_93 (12) = happyShift action_2
action_93 (13) = happyShift action_4
action_93 (14) = happyShift action_5
action_93 (15) = happyShift action_6
action_93 (17) = happyShift action_7
action_93 (51) = happyShift action_8
action_93 (4) = happyGoto action_127
action_93 (5) = happyGoto action_131
action_93 _ = happyReduce_37

action_94 (12) = happyShift action_2
action_94 (13) = happyShift action_4
action_94 (14) = happyShift action_5
action_94 (15) = happyShift action_6
action_94 (17) = happyShift action_7
action_94 (51) = happyShift action_8
action_94 (4) = happyGoto action_127
action_94 (5) = happyGoto action_130
action_94 _ = happyReduce_37

action_95 _ = happyReduce_19

action_96 (12) = happyShift action_2
action_96 (13) = happyShift action_4
action_96 (14) = happyShift action_5
action_96 (15) = happyShift action_6
action_96 (17) = happyShift action_7
action_96 (51) = happyShift action_8
action_96 (4) = happyGoto action_127
action_96 (5) = happyGoto action_129
action_96 _ = happyReduce_37

action_97 (12) = happyShift action_2
action_97 (13) = happyShift action_4
action_97 (14) = happyShift action_5
action_97 (15) = happyShift action_6
action_97 (17) = happyShift action_7
action_97 (51) = happyShift action_8
action_97 (4) = happyGoto action_127
action_97 (5) = happyGoto action_128
action_97 _ = happyReduce_37

action_98 (16) = happyShift action_126
action_98 _ = happyFail (happyExpListPerState 98)

action_99 (12) = happyShift action_125
action_99 _ = happyFail (happyExpListPerState 99)

action_100 (16) = happyShift action_124
action_100 _ = happyFail (happyExpListPerState 100)

action_101 (12) = happyShift action_2
action_101 (13) = happyShift action_4
action_101 (14) = happyShift action_5
action_101 (15) = happyShift action_6
action_101 (17) = happyShift action_7
action_101 (51) = happyShift action_8
action_101 (4) = happyGoto action_123
action_101 _ = happyFail (happyExpListPerState 101)

action_102 (16) = happyShift action_122
action_102 _ = happyFail (happyExpListPerState 102)

action_103 (12) = happyShift action_103
action_103 (16) = happyReduce_45
action_103 (8) = happyGoto action_121
action_103 _ = happyReduce_45

action_104 (12) = happyShift action_2
action_104 (13) = happyShift action_4
action_104 (14) = happyShift action_5
action_104 (15) = happyShift action_6
action_104 (17) = happyShift action_7
action_104 (51) = happyShift action_8
action_104 (4) = happyGoto action_120
action_104 _ = happyFail (happyExpListPerState 104)

action_105 (12) = happyShift action_2
action_105 (13) = happyShift action_4
action_105 (14) = happyShift action_5
action_105 (15) = happyShift action_6
action_105 (17) = happyShift action_7
action_105 (51) = happyShift action_8
action_105 (4) = happyGoto action_119
action_105 _ = happyFail (happyExpListPerState 105)

action_106 (12) = happyShift action_2
action_106 (13) = happyShift action_4
action_106 (14) = happyShift action_5
action_106 (15) = happyShift action_6
action_106 (17) = happyShift action_7
action_106 (51) = happyShift action_8
action_106 (4) = happyGoto action_118
action_106 _ = happyFail (happyExpListPerState 106)

action_107 (12) = happyShift action_2
action_107 (13) = happyShift action_4
action_107 (14) = happyShift action_5
action_107 (15) = happyShift action_6
action_107 (17) = happyShift action_7
action_107 (51) = happyShift action_8
action_107 (4) = happyGoto action_117
action_107 _ = happyFail (happyExpListPerState 107)

action_108 _ = happyReduce_50

action_109 _ = happyReduce_34

action_110 (16) = happyShift action_116
action_110 _ = happyFail (happyExpListPerState 110)

action_111 _ = happyReduce_23

action_112 _ = happyReduce_24

action_113 _ = happyReduce_26

action_114 _ = happyReduce_27

action_115 _ = happyReduce_28

action_116 _ = happyReduce_22

action_117 (18) = happyShift action_162
action_117 _ = happyFail (happyExpListPerState 117)

action_118 (18) = happyShift action_161
action_118 _ = happyFail (happyExpListPerState 118)

action_119 (16) = happyShift action_160
action_119 _ = happyFail (happyExpListPerState 119)

action_120 (16) = happyShift action_159
action_120 _ = happyFail (happyExpListPerState 120)

action_121 _ = happyReduce_46

action_122 (12) = happyShift action_2
action_122 (13) = happyShift action_4
action_122 (14) = happyShift action_5
action_122 (15) = happyShift action_6
action_122 (17) = happyShift action_7
action_122 (51) = happyShift action_8
action_122 (4) = happyGoto action_158
action_122 _ = happyFail (happyExpListPerState 122)

action_123 (16) = happyShift action_157
action_123 _ = happyFail (happyExpListPerState 123)

action_124 (12) = happyShift action_2
action_124 (13) = happyShift action_4
action_124 (14) = happyShift action_5
action_124 (15) = happyShift action_6
action_124 (17) = happyShift action_7
action_124 (51) = happyShift action_8
action_124 (4) = happyGoto action_156
action_124 _ = happyFail (happyExpListPerState 124)

action_125 (12) = happyShift action_2
action_125 (13) = happyShift action_4
action_125 (14) = happyShift action_5
action_125 (15) = happyShift action_6
action_125 (17) = happyShift action_7
action_125 (51) = happyShift action_8
action_125 (4) = happyGoto action_155
action_125 _ = happyFail (happyExpListPerState 125)

action_126 (12) = happyShift action_2
action_126 (13) = happyShift action_4
action_126 (14) = happyShift action_5
action_126 (15) = happyShift action_6
action_126 (17) = happyShift action_7
action_126 (51) = happyShift action_8
action_126 (4) = happyGoto action_154
action_126 _ = happyFail (happyExpListPerState 126)

action_127 (12) = happyShift action_2
action_127 (13) = happyShift action_4
action_127 (14) = happyShift action_5
action_127 (15) = happyShift action_6
action_127 (17) = happyShift action_7
action_127 (51) = happyShift action_8
action_127 (4) = happyGoto action_127
action_127 (5) = happyGoto action_153
action_127 _ = happyReduce_37

action_128 (16) = happyShift action_152
action_128 _ = happyFail (happyExpListPerState 128)

action_129 (16) = happyShift action_151
action_129 _ = happyFail (happyExpListPerState 129)

action_130 (16) = happyShift action_150
action_130 _ = happyFail (happyExpListPerState 130)

action_131 (16) = happyShift action_149
action_131 _ = happyFail (happyExpListPerState 131)

action_132 (16) = happyShift action_148
action_132 _ = happyFail (happyExpListPerState 132)

action_133 (16) = happyShift action_147
action_133 _ = happyFail (happyExpListPerState 133)

action_134 (16) = happyShift action_146
action_134 _ = happyFail (happyExpListPerState 134)

action_135 (16) = happyShift action_145
action_135 _ = happyFail (happyExpListPerState 135)

action_136 _ = happyReduce_12

action_137 (16) = happyShift action_144
action_137 _ = happyFail (happyExpListPerState 137)

action_138 (16) = happyShift action_143
action_138 _ = happyFail (happyExpListPerState 138)

action_139 (16) = happyShift action_142
action_139 _ = happyFail (happyExpListPerState 139)

action_140 (16) = happyShift action_141
action_140 _ = happyFail (happyExpListPerState 140)

action_141 _ = happyReduce_5

action_142 _ = happyReduce_6

action_143 _ = happyReduce_7

action_144 _ = happyReduce_8

action_145 _ = happyReduce_13

action_146 _ = happyReduce_14

action_147 _ = happyReduce_15

action_148 _ = happyReduce_16

action_149 _ = happyReduce_17

action_150 _ = happyReduce_18

action_151 _ = happyReduce_20

action_152 _ = happyReduce_21

action_153 _ = happyReduce_38

action_154 (16) = happyShift action_167
action_154 _ = happyFail (happyExpListPerState 154)

action_155 (16) = happyShift action_166
action_155 _ = happyFail (happyExpListPerState 155)

action_156 (16) = happyShift action_165
action_156 _ = happyFail (happyExpListPerState 156)

action_157 (12) = happyShift action_2
action_157 (13) = happyShift action_4
action_157 (14) = happyShift action_5
action_157 (15) = happyShift action_6
action_157 (17) = happyShift action_7
action_157 (51) = happyShift action_8
action_157 (4) = happyGoto action_164
action_157 _ = happyFail (happyExpListPerState 157)

action_158 (16) = happyShift action_163
action_158 _ = happyFail (happyExpListPerState 158)

action_159 _ = happyReduce_32

action_160 _ = happyReduce_33

action_161 _ = happyReduce_51

action_162 _ = happyReduce_52

action_163 _ = happyReduce_35

action_164 (16) = happyShift action_169
action_164 _ = happyFail (happyExpListPerState 164)

action_165 _ = happyReduce_30

action_166 (15) = happyShift action_99
action_166 (7) = happyGoto action_168
action_166 _ = happyReduce_42

action_167 _ = happyReduce_29

action_168 _ = happyReduce_43

action_169 _ = happyReduce_31

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyTerminal (TokenId happy_var_1))
	 =  HappyAbsSyn4
		 (IdS happy_var_1
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  4 happyReduction_2
happyReduction_2 (HappyTerminal (TokenNum happy_var_1))
	 =  HappyAbsSyn4
		 (NumS happy_var_1
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  4 happyReduction_3
happyReduction_3 (HappyTerminal (TokenBool happy_var_1))
	 =  HappyAbsSyn4
		 (BooleanS happy_var_1
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1  4 happyReduction_4
happyReduction_4 _
	 =  HappyAbsSyn4
		 (EmptyS
	)

happyReduce_5 = happyReduce 6 4 happyReduction_5
happyReduction_5 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_5) `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (AddS (happy_var_3 : happy_var_4 : happy_var_5)
	) `HappyStk` happyRest

happyReduce_6 = happyReduce 6 4 happyReduction_6
happyReduction_6 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_5) `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (SubS (happy_var_3 : happy_var_4 : happy_var_5)
	) `HappyStk` happyRest

happyReduce_7 = happyReduce 6 4 happyReduction_7
happyReduction_7 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_5) `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (MulS (happy_var_3 : happy_var_4 : happy_var_5)
	) `HappyStk` happyRest

happyReduce_8 = happyReduce 6 4 happyReduction_8
happyReduction_8 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_5) `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (DivS (happy_var_3 : happy_var_4 : happy_var_5)
	) `HappyStk` happyRest

happyReduce_9 = happyReduce 4 4 happyReduction_9
happyReduction_9 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Add1S happy_var_3
	) `HappyStk` happyRest

happyReduce_10 = happyReduce 4 4 happyReduction_10
happyReduction_10 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Sub1S happy_var_3
	) `HappyStk` happyRest

happyReduce_11 = happyReduce 4 4 happyReduction_11
happyReduction_11 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (SqrtS happy_var_3
	) `HappyStk` happyRest

happyReduce_12 = happyReduce 5 4 happyReduction_12
happyReduction_12 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (ExptS happy_var_3 happy_var_4
	) `HappyStk` happyRest

happyReduce_13 = happyReduce 6 4 happyReduction_13
happyReduction_13 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_5) `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (EqS (happy_var_3 : happy_var_4 : happy_var_5)
	) `HappyStk` happyRest

happyReduce_14 = happyReduce 6 4 happyReduction_14
happyReduction_14 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_5) `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (LtS (happy_var_3 : happy_var_4 : happy_var_5)
	) `HappyStk` happyRest

happyReduce_15 = happyReduce 6 4 happyReduction_15
happyReduction_15 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_5) `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (GtS (happy_var_3 : happy_var_4 : happy_var_5)
	) `HappyStk` happyRest

happyReduce_16 = happyReduce 6 4 happyReduction_16
happyReduction_16 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_5) `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (LteS (happy_var_3 : happy_var_4 : happy_var_5)
	) `HappyStk` happyRest

happyReduce_17 = happyReduce 6 4 happyReduction_17
happyReduction_17 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_5) `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (GteS (happy_var_3 : happy_var_4 : happy_var_5)
	) `HappyStk` happyRest

happyReduce_18 = happyReduce 6 4 happyReduction_18
happyReduction_18 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_5) `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (NeqS (happy_var_3 : happy_var_4 : happy_var_5)
	) `HappyStk` happyRest

happyReduce_19 = happyReduce 4 4 happyReduction_19
happyReduction_19 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (NotS happy_var_3
	) `HappyStk` happyRest

happyReduce_20 = happyReduce 6 4 happyReduction_20
happyReduction_20 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_5) `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (AndS (happy_var_3 : happy_var_4 : happy_var_5)
	) `HappyStk` happyRest

happyReduce_21 = happyReduce 6 4 happyReduction_21
happyReduction_21 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_5) `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (OrS (happy_var_3 : happy_var_4 : happy_var_5)
	) `HappyStk` happyRest

happyReduce_22 = happyReduce 5 4 happyReduction_22
happyReduction_22 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (PairS happy_var_3 happy_var_4
	) `HappyStk` happyRest

happyReduce_23 = happyReduce 4 4 happyReduction_23
happyReduction_23 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (FstS happy_var_3
	) `HappyStk` happyRest

happyReduce_24 = happyReduce 4 4 happyReduction_24
happyReduction_24 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (SndS happy_var_3
	) `HappyStk` happyRest

happyReduce_25 = happySpecReduce_3  4 happyReduction_25
happyReduction_25 _
	(HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (ListS happy_var_2
	)
happyReduction_25 _ _ _  = notHappyAtAll 

happyReduce_26 = happyReduce 4 4 happyReduction_26
happyReduction_26 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (HeadS happy_var_3
	) `HappyStk` happyRest

happyReduce_27 = happyReduce 4 4 happyReduction_27
happyReduction_27 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (TailS happy_var_3
	) `HappyStk` happyRest

happyReduce_28 = happyReduce 4 4 happyReduction_28
happyReduction_28 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (NullQS happy_var_3
	) `HappyStk` happyRest

happyReduce_29 = happyReduce 7 4 happyReduction_29
happyReduction_29 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (LetS happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_30 = happyReduce 7 4 happyReduction_30
happyReduction_30 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (LetStarS happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_31 = happyReduce 8 4 happyReduction_31
happyReduction_31 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_5) `HappyStk`
	(HappyTerminal (TokenId happy_var_4)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (LetRecS happy_var_4 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_32 = happyReduce 6 4 happyReduction_32
happyReduction_32 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_5) `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (If0S happy_var_3 happy_var_4 happy_var_5
	) `HappyStk` happyRest

happyReduce_33 = happyReduce 6 4 happyReduction_33
happyReduction_33 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_5) `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (IfS happy_var_3 happy_var_4 happy_var_5
	) `HappyStk` happyRest

happyReduce_34 = happyReduce 4 4 happyReduction_34
happyReduction_34 (_ `HappyStk`
	(HappyAbsSyn10  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (CondS happy_var_3
	) `HappyStk` happyRest

happyReduce_35 = happyReduce 7 4 happyReduction_35
happyReduction_35 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (LambdaS happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_36 = happyReduce 4 4 happyReduction_36
happyReduction_36 (_ `HappyStk`
	(HappyAbsSyn9  happy_var_3) `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (AppS happy_var_2 happy_var_3
	) `HappyStk` happyRest

happyReduce_37 = happySpecReduce_0  5 happyReduction_37
happyReduction_37  =  HappyAbsSyn5
		 ([]
	)

happyReduce_38 = happySpecReduce_2  5 happyReduction_38
happyReduction_38 (HappyAbsSyn5  happy_var_2)
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1 : happy_var_2
	)
happyReduction_38 _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_0  6 happyReduction_39
happyReduction_39  =  HappyAbsSyn6
		 ([]
	)

happyReduce_40 = happySpecReduce_1  6 happyReduction_40
happyReduction_40 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn6
		 ([happy_var_1]
	)
happyReduction_40 _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_3  6 happyReduction_41
happyReduction_41 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1 : happy_var_3
	)
happyReduction_41 _ _ _  = notHappyAtAll 

happyReduce_42 = happyReduce 4 7 happyReduction_42
happyReduction_42 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 ([(happy_var_2, happy_var_3)]
	) `HappyStk` happyRest

happyReduce_43 = happyReduce 5 7 happyReduction_43
happyReduction_43 ((HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 ((happy_var_2, happy_var_3) : happy_var_5
	) `HappyStk` happyRest

happyReduce_44 = happySpecReduce_0  8 happyReduction_44
happyReduction_44  =  HappyAbsSyn8
		 ([]
	)

happyReduce_45 = happySpecReduce_1  8 happyReduction_45
happyReduction_45 (HappyTerminal (TokenId happy_var_1))
	 =  HappyAbsSyn8
		 ([happy_var_1]
	)
happyReduction_45 _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_2  8 happyReduction_46
happyReduction_46 (HappyAbsSyn8  happy_var_2)
	(HappyTerminal (TokenId happy_var_1))
	 =  HappyAbsSyn8
		 (happy_var_1 : happy_var_2
	)
happyReduction_46 _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_1  9 happyReduction_47
happyReduction_47 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn9
		 ([happy_var_1]
	)
happyReduction_47 _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_2  9 happyReduction_48
happyReduction_48 (HappyAbsSyn9  happy_var_2)
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_1 : happy_var_2
	)
happyReduction_48 _ _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_1  10 happyReduction_49
happyReduction_49 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn10
		 ([happy_var_1]
	)
happyReduction_49 _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_2  10 happyReduction_50
happyReduction_50 (HappyAbsSyn10  happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_1 : happy_var_2
	)
happyReduction_50 _ _  = notHappyAtAll 

happyReduce_51 = happyReduce 4 11 happyReduction_51
happyReduction_51 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (ClauseS happy_var_2 happy_var_3
	) `HappyStk` happyRest

happyReduce_52 = happyReduce 4 11 happyReduction_52
happyReduction_52 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (ElseS happy_var_3
	) `HappyStk` happyRest

happyNewToken action sts stk [] =
	action 52 52 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenId happy_dollar_dollar -> cont 12;
	TokenNum happy_dollar_dollar -> cont 13;
	TokenBool happy_dollar_dollar -> cont 14;
	TokenPA -> cont 15;
	TokenPC -> cont 16;
	TokenCL -> cont 17;
	TokenCR -> cont 18;
	TokenComma -> cont 19;
	TokenSuma -> cont 20;
	TokenResta -> cont 21;
	TokenMul -> cont 22;
	TokenDiv -> cont 23;
	TokenAdd1 -> cont 24;
	TokenSub1 -> cont 25;
	TokenSqrt -> cont 26;
	TokenExpt -> cont 27;
	TokenEQ -> cont 28;
	TokenLT -> cont 29;
	TokenGT -> cont 30;
	TokenLTE -> cont 31;
	TokenGTE -> cont 32;
	TokenNEQ -> cont 33;
	TokenNot -> cont 34;
	TokenAnd -> cont 35;
	TokenOr -> cont 36;
	TokenLet -> cont 37;
	TokenLetStar -> cont 38;
	TokenLetRec -> cont 39;
	TokenLambda -> cont 40;
	TokenIf0 -> cont 41;
	TokenIf -> cont 42;
	TokenCond -> cont 43;
	TokenElse -> cont 44;
	TokenPair -> cont 45;
	TokenFst -> cont 46;
	TokenSnd -> cont 47;
	TokenHead -> cont 48;
	TokenTail -> cont 49;
	TokenNullQ -> cont 50;
	TokenEmpty -> cont 51;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 52 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Prelude.Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Prelude.Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (Prelude.>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (Prelude.return)
happyThen1 m k tks = (Prelude.>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (Prelude.return) a
happyError' :: () => ([(Token)], [Prelude.String]) -> HappyIdentity a
happyError' = HappyIdentity Prelude.. (\(tokens, _) -> parseError tokens)
parse tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [Token] -> a
parseError tokens = error $ "Parse error at: " ++ show (take 10 tokens)

data SASA 
  = IdS String
  | NumS Int
  | BooleanS Bool
  | EmptyS
  
  -- Operadores aritméticos variádicos
  | AddS [SASA]
  | SubS [SASA]
  | MulS [SASA]
  | DivS [SASA]
  
  -- Operadores aritméticos unarios/binarios
  | Add1S SASA
  | Sub1S SASA
  | SqrtS SASA
  | ExptS SASA SASA
  
  -- Comparadores variádicos
  | EqS [SASA]
  | LtS [SASA]
  | GtS [SASA]
  | LteS [SASA]
  | GteS [SASA]
  | NeqS [SASA]
  
  -- Lógicos
  | NotS SASA
  | AndS [SASA]
  | OrS [SASA]

  -- Pares
  | PairS SASA SASA
  | FstS SASA
  | SndS SASA
  
  -- Listas
  | ListS [SASA]
  | HeadS SASA
  | TailS SASA
  | NullQS SASA
  
  -- Bindings
  | LetS [(String, SASA)] SASA
  | LetStarS [(String, SASA)] SASA
  | LetRecS String SASA SASA
  
  -- Condicionales
  | If0S SASA SASA SASA
  | IfS SASA SASA SASA
  | CondS [CondClause]
  
  -- Funciones
  | LambdaS [String] SASA
  | AppS SASA [SASA]
  
  deriving (Show, Eq)

-- Cláusulas de cond
data CondClause
  = ClauseS SASA SASA  
  | ElseS SASA         
  deriving (Show, Eq)
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $










































data Happy_IntList = HappyCons Prelude.Int Happy_IntList








































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action









































indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x Prelude.< y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `Prelude.div` 16)) (bit `Prelude.mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Prelude.Int ->                    -- token number
         Prelude.Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k Prelude.- ((1) :: Prelude.Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Prelude.Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n Prelude.- ((1) :: Prelude.Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n Prelude.- ((1)::Prelude.Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st CONS(HAPPYSTATE(action),sts) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        DO_ACTION(action,ERROR_TOK,tk,sts,(saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ((HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = Prelude.error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `Prelude.seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
