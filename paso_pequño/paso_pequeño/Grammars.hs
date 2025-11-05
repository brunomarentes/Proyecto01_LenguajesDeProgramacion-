{-# OPTIONS_GHC -w #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MagicHash #-}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE PatternGuards #-}
{-# LANGUAGE NoStrictData #-}
#if __GLASGOW_HASKELL__ >= 710
{-# LANGUAGE PartialTypeSignatures #-}
#endif
module Grammars where

import Lex
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import qualified GHC.Exts as Happy_GHC_Exts
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 2.0.2

data HappyAbsSyn 
        = HappyTerminal (Token)
        | HappyErrorToken Prelude.Int
        | HappyAbsSyn4 (SASA)
        | HappyAbsSyn6 ([SASA])
        | HappyAbsSyn8 ([String])
        | HappyAbsSyn9 ([(String, SASA)])
        | HappyAbsSyn10 ([(SASA, SASA)])

happyExpList :: HappyAddr
happyExpList = HappyA# "\x00\x14\x00\x00\x00\x3c\x00\x0a\x00\x00\x00\x1e\x00\x00\x00\x00\x00\x00\x80\xfa\xff\xff\xfb\x07\x40\x01\x00\x00\xc0\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\x06\x00\x00\x80\x07\x40\x01\x00\x00\xc0\x03\xe0\x00\x00\x00\xe0\x01\x50\x00\x00\x00\xf0\x00\x28\x00\x00\x00\x78\x00\x14\x00\x00\x00\x3c\x00\x0a\x00\x00\x00\x1e\x00\x05\x00\x00\x00\x0f\x80\x02\x00\x00\x80\x07\x40\x01\x00\x00\xc0\x03\xa0\x00\x00\x00\xe0\x01\x50\x00\x00\x00\xf0\x00\x28\x00\x00\x00\x78\x00\x14\x00\x00\x00\x3c\x00\x0a\x00\x00\x00\x1e\x00\x05\x00\x00\x00\x0f\x80\x02\x00\x00\x80\x07\x40\x01\x00\x00\xc0\x03\xa0\x00\x00\x00\xe0\x01\x50\x00\x00\x00\xf0\x00\x28\x00\x00\x00\x78\x00\x14\x00\x00\x00\x3c\x00\x0a\x00\x00\x00\x1e\x00\x05\x00\x00\x00\x0f\x80\x02\x00\x00\x80\x07\x40\x00\x00\x00\x00\x00\x20\x00\x00\x00\x00\x00\x10\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x00\x01\x00\x00\x00\x00\x80\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x60\x00\x00\x00\x00\x00\x50\x00\x00\x00\xf0\x00\x28\x00\x00\x00\x78\x00\x14\x00\x00\x00\x3c\x00\x04\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x80\x02\x00\x00\x80\x07\x80\x00\x00\x00\x00\x00\xe0\x00\x00\x00\xe0\x01\x70\x00\x00\x00\xf0\x00\x38\x00\x00\x00\x78\x00\x1c\x00\x00\x00\x3c\x00\x0e\x00\x00\x00\x1e\x00\x07\x00\x00\x00\x0f\x80\x03\x00\x00\x80\x07\xc0\x01\x00\x00\xc0\x03\xa0\x00\x00\x00\xe0\x01\x20\x00\x00\x00\x00\x00\x10\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x0e\x00\x00\x00\x1e\x00\x07\x00\x00\x00\x0f\x80\x03\x00\x00\x80\x07\xc0\x01\x00\x00\xc0\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x50\x00\x00\x00\xf0\x00\x28\x00\x00\x00\x78\x00\x14\x00\x00\x00\x3c\x00\x0a\x00\x00\x00\x1e\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x60\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\x00\x18\x00\x00\x00\x00\x00\x14\x00\x00\x00\x3c\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x80\x02\x00\x00\x80\x07\x40\x01\x00\x00\xc0\x03\xa0\x00\x00\x00\xe0\x01\x50\x00\x00\x00\xf0\x00\x00\x00\x00\x00\x00\x00\x14\x00\x00\x00\x3c\x00\x04\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x80\x00\x00\x00\x00\x00\x40\x00\x00\x00\x00\x00\x50\x00\x00\x00\xf0\x00\x28\x00\x00\x00\x78\x00\x08\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","Program","Expr","AppExpr","ExprList","IdList","BindingList","CondClauses","'('","')'","'['","']'","'+'","'-'","'*'","'/'","add1","sub1","sqrt","expt","'='","'<'","'>'","'<='","'>='","'!='","and","or","not","pair","fst","snd","if","if0","cond","'=>'","lambda","let","let_star","letrec","nil","num","bool","id","%eof"]
        bit_start = st               Prelude.* 47
        bit_end   = (st Prelude.+ 1) Prelude.* 47
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..46]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

happyActOffsets :: HappyAddr
happyActOffsets = HappyA# "\x7d\x00\x00\x00\x7d\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x7d\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xdc\xff\xff\xff\x00\x00\x00\x00\x25\x00\x00\x00\x7d\x00\x00\x00\x29\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x02\x00\x00\x00\x1c\x00\x00\x00\x2c\x00\x00\x00\x30\x00\x00\x00\x34\x00\x00\x00\x15\x00\x00\x00\x3c\x00\x00\x00\x3c\x00\x00\x00\x1d\x00\x00\x00\xb5\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x43\x00\x00\x00\x67\x00\x00\x00\x7d\x00\x00\x00\x6b\x00\x00\x00\x2d\x00\x00\x00\x31\x00\x00\x00\x35\x00\x00\x00\x39\x00\x00\x00\x3d\x00\x00\x00\x41\x00\x00\x00\x65\x00\x00\x00\x69\x00\x00\x00\x7d\x00\x00\x00\x6f\x00\x00\x00\x73\x00\x00\x00\x77\x00\x00\x00\x6d\x00\x00\x00\x71\x00\x00\x00\x75\x00\x00\x00\x79\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x83\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xbe\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x00\x00\x00\x00\x03\x00\x00\x00\x00\x00\x00\x00\xb7\x00\x00\x00\x9d\x00\x00\x00\xb9\x00\x00\x00\x7d\x00\x00\x00\xc0\x00\x00\x00\x9f\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\x00\x00\x00\x00\x7d\x00\x00\x00\xc2\x00\x00\x00\xc3\x00\x00\x00\xc4\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xc5\x00\x00\x00\xc6\x00\x00\x00\xc7\x00\x00\x00\xc8\x00\x00\x00\xc9\x00\x00\x00\x7d\x00\x00\x00\x7d\x00\x00\x00\xca\x00\x00\x00\xcb\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyGotoOffsets :: HappyAddr
happyGotoOffsets = HappyA# "\xbc\x00\x00\x00\xcd\x00\x00\x00\x00\x00\x00\x00\xbd\x00\x00\x00\x7c\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xce\x00\x00\x00\xcf\x00\x00\x00\xd0\x00\x00\x00\x80\x00\x00\x00\x81\x00\x00\x00\xa1\x00\x00\x00\xa2\x00\x00\x00\xd1\x00\x00\x00\xd2\x00\x00\x00\xd3\x00\x00\x00\xd4\x00\x00\x00\xa5\x00\x00\x00\xa6\x00\x00\x00\xa9\x00\x00\x00\xaa\x00\x00\x00\xad\x00\x00\x00\xae\x00\x00\x00\xb1\x00\x00\x00\xb2\x00\x00\x00\xd5\x00\x00\x00\xd6\x00\x00\x00\xd7\x00\x00\x00\xd8\x00\x00\x00\xd9\x00\x00\x00\xda\x00\x00\x00\xdb\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xdd\x00\x00\x00\xde\x00\x00\x00\xdc\x00\x00\x00\x00\x00\x00\x00\xe3\x00\x00\x00\xe4\x00\x00\x00\xe5\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe6\x00\x00\x00\x00\x00\x00\x00\xe7\x00\x00\x00\xe7\x00\x00\x00\xe7\x00\x00\x00\xe7\x00\x00\x00\xe7\x00\x00\x00\xe7\x00\x00\x00\xe7\x00\x00\x00\xe7\x00\x00\x00\xe8\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe9\x00\x00\x00\xe9\x00\x00\x00\xe9\x00\x00\x00\xe9\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xea\x00\x00\x00\xeb\x00\x00\x00\xec\x00\x00\x00\xed\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xee\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xef\x00\x00\x00\xf0\x00\x00\x00\xf1\x00\x00\x00\xf2\x00\x00\x00\x00\x00\x00\x00\xf3\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf4\x00\x00\x00\xf5\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyAdjustOffset :: Happy_GHC_Exts.Int# -> Happy_GHC_Exts.Int#
happyAdjustOffset off = off

happyDefActions :: HappyAddr
happyDefActions = HappyA# "\x00\x00\x00\x00\x00\x00\x00\x00\xfe\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\xfb\xff\xff\xff\xfd\xff\xff\xff\xfc\xff\xff\xff\xfa\xff\xff\xff\x00\x00\x00\x00\xda\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xdb\xff\xff\xff\xdd\xff\xff\xff\xdc\xff\xff\xff\xd9\xff\xff\xff\xe5\xff\xff\xff\xf9\xff\xff\xff\xf8\xff\xff\xff\xf7\xff\xff\xff\xf6\xff\xff\xff\xf5\xff\xff\xff\xf4\xff\xff\xff\xf3\xff\xff\xff\x00\x00\x00\x00\xf1\xff\xff\xff\xf0\xff\xff\xff\xef\xff\xff\xff\xee\xff\xff\xff\xed\xff\xff\xff\xec\xff\xff\xff\xeb\xff\xff\xff\xea\xff\xff\xff\xe9\xff\xff\xff\x00\x00\x00\x00\xe7\xff\xff\xff\xe6\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe2\xff\xff\xff\x00\x00\x00\x00\xd8\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd7\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe8\xff\xff\xff\xf2\xff\xff\xff\xe4\xff\xff\xff\xe3\xff\xff\xff\xd4\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xdf\xff\xff\xff\xd6\xff\xff\xff\xe0\xff\xff\xff\xe1\xff\xff\xff\xd3\xff\xff\xff\xd5\xff\xff\xff\xde\xff\xff\xff"#

happyCheck :: HappyAddr
happyCheck = HappyA# "\xff\xff\xff\xff\x25\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x03\x00\x00\x00\x02\x00\x00\x00\x05\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x0a\x00\x00\x00\x0b\x00\x00\x00\x0c\x00\x00\x00\x0d\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\x13\x00\x00\x00\x14\x00\x00\x00\x15\x00\x00\x00\x16\x00\x00\x00\x17\x00\x00\x00\x18\x00\x00\x00\x19\x00\x00\x00\x1a\x00\x00\x00\x1b\x00\x00\x00\x01\x00\x00\x00\x1d\x00\x00\x00\x1e\x00\x00\x00\x1f\x00\x00\x00\x20\x00\x00\x00\x21\x00\x00\x00\x22\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x01\x00\x00\x00\x24\x00\x00\x00\x03\x00\x00\x00\x04\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x24\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x24\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x02\x00\x00\x00\x21\x00\x00\x00\x22\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x21\x00\x00\x00\x22\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x21\x00\x00\x00\x22\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x21\x00\x00\x00\x22\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x21\x00\x00\x00\x22\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x21\x00\x00\x00\x22\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x21\x00\x00\x00\x22\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x21\x00\x00\x00\x22\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x02\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x02\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x02\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x02\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x02\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x03\x00\x00\x00\x03\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x03\x00\x00\x00\x03\x00\x00\x00\x02\x00\x00\x00\x21\x00\x00\x00\x22\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x21\x00\x00\x00\x22\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x21\x00\x00\x00\x22\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x21\x00\x00\x00\x22\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x21\x00\x00\x00\x22\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x21\x00\x00\x00\x22\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x21\x00\x00\x00\x22\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x03\x00\x00\x00\x03\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x03\x00\x00\x00\x03\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x03\x00\x00\x00\x03\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x03\x00\x00\x00\x03\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x03\x00\x00\x00\x03\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x02\x00\x00\x00\x24\x00\x00\x00\x02\x00\x00\x00\x24\x00\x00\x00\x02\x00\x00\x00\x02\x00\x00\x00\x02\x00\x00\x00\x02\x00\x00\x00\x02\x00\x00\x00\x02\x00\x00\x00\x02\x00\x00\x00\x02\x00\x00\x00\x02\x00\x00\x00\x02\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x04\x00\x00\x00\x06\x00\x00\x00\x05\x00\x00\x00\x05\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff"#

happyTable :: HappyAddr
happyTable = HappyA# "\x00\x00\x00\x00\xff\xff\xff\xff\x04\x00\x00\x00\x2f\x00\x00\x00\x05\x00\x00\x00\x6f\x00\x00\x00\x0f\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\x13\x00\x00\x00\x14\x00\x00\x00\x15\x00\x00\x00\x16\x00\x00\x00\x17\x00\x00\x00\x18\x00\x00\x00\x19\x00\x00\x00\x1a\x00\x00\x00\x1b\x00\x00\x00\x1c\x00\x00\x00\x1d\x00\x00\x00\x1e\x00\x00\x00\x1f\x00\x00\x00\x20\x00\x00\x00\x21\x00\x00\x00\x22\x00\x00\x00\x23\x00\x00\x00\x24\x00\x00\x00\x25\x00\x00\x00\x2d\x00\x00\x00\x26\x00\x00\x00\x27\x00\x00\x00\x28\x00\x00\x00\x29\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x04\x00\x00\x00\x70\x00\x00\x00\x05\x00\x00\x00\x4a\x00\x00\x00\x04\x00\x00\x00\x47\x00\x00\x00\x05\x00\x00\x00\x2c\x00\x00\x00\x04\x00\x00\x00\x5a\x00\x00\x00\x05\x00\x00\x00\x2b\x00\x00\x00\x04\x00\x00\x00\x59\x00\x00\x00\x05\x00\x00\x00\x2a\x00\x00\x00\x04\x00\x00\x00\x58\x00\x00\x00\x05\x00\x00\x00\x69\x00\x00\x00\x04\x00\x00\x00\x57\x00\x00\x00\x05\x00\x00\x00\x67\x00\x00\x00\x04\x00\x00\x00\x56\x00\x00\x00\x05\x00\x00\x00\x65\x00\x00\x00\x04\x00\x00\x00\x55\x00\x00\x00\x05\x00\x00\x00\x5e\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x04\x00\x00\x00\x54\x00\x00\x00\x05\x00\x00\x00\x5d\x00\x00\x00\x04\x00\x00\x00\x53\x00\x00\x00\x05\x00\x00\x00\x5b\x00\x00\x00\x04\x00\x00\x00\x4e\x00\x00\x00\x05\x00\x00\x00\x51\x00\x00\x00\x04\x00\x00\x00\x4d\x00\x00\x00\x05\x00\x00\x00\x50\x00\x00\x00\x04\x00\x00\x00\x4c\x00\x00\x00\x05\x00\x00\x00\x4f\x00\x00\x00\x04\x00\x00\x00\x4b\x00\x00\x00\x05\x00\x00\x00\x0a\x00\x00\x00\x04\x00\x00\x00\x0b\x00\x00\x00\x05\x00\x00\x00\x0a\x00\x00\x00\x0a\x00\x00\x00\x44\x00\x00\x00\x43\x00\x00\x00\x76\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x0a\x00\x00\x00\x0a\x00\x00\x00\x42\x00\x00\x00\x41\x00\x00\x00\x0a\x00\x00\x00\x0a\x00\x00\x00\x3c\x00\x00\x00\x3b\x00\x00\x00\x0a\x00\x00\x00\x0a\x00\x00\x00\x3a\x00\x00\x00\x39\x00\x00\x00\x0a\x00\x00\x00\x0a\x00\x00\x00\x38\x00\x00\x00\x37\x00\x00\x00\x0a\x00\x00\x00\x0a\x00\x00\x00\x36\x00\x00\x00\x35\x00\x00\x00\x62\x00\x00\x00\x63\x00\x00\x00\x6b\x00\x00\x00\x6e\x00\x00\x00\x6b\x00\x00\x00\x6c\x00\x00\x00\x09\x00\x00\x00\x02\x00\x00\x00\x0c\x00\x00\x00\x0d\x00\x00\x00\x75\x00\x00\x00\x6d\x00\x00\x00\x80\x00\x00\x00\x7f\x00\x00\x00\x79\x00\x00\x00\x78\x00\x00\x00\x77\x00\x00\x00\x87\x00\x00\x00\x86\x00\x00\x00\x85\x00\x00\x00\x84\x00\x00\x00\x83\x00\x00\x00\x89\x00\x00\x00\x88\x00\x00\x00\x02\x00\x00\x00\x48\x00\x00\x00\x47\x00\x00\x00\x45\x00\x00\x00\x40\x00\x00\x00\x3f\x00\x00\x00\x3e\x00\x00\x00\x3d\x00\x00\x00\x34\x00\x00\x00\x33\x00\x00\x00\x32\x00\x00\x00\x31\x00\x00\x00\x30\x00\x00\x00\x2f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x63\x00\x00\x00\x2d\x00\x00\x00\x67\x00\x00\x00\x65\x00\x00\x00\x60\x00\x00\x00\x5f\x00\x00\x00\x5e\x00\x00\x00\x5b\x00\x00\x00\x48\x00\x00\x00\x51\x00\x00\x00\x48\x00\x00\x00\x73\x00\x00\x00\x72\x00\x00\x00\x71\x00\x00\x00\x70\x00\x00\x00\x69\x00\x00\x00\x7d\x00\x00\x00\x7c\x00\x00\x00\x7b\x00\x00\x00\x7a\x00\x00\x00\x79\x00\x00\x00\x81\x00\x00\x00\x80\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyReduceArr = Happy_Data_Array.array (1, 44) [
        (1 , happyReduce_1),
        (2 , happyReduce_2),
        (3 , happyReduce_3),
        (4 , happyReduce_4),
        (5 , happyReduce_5),
        (6 , happyReduce_6),
        (7 , happyReduce_7),
        (8 , happyReduce_8),
        (9 , happyReduce_9),
        (10 , happyReduce_10),
        (11 , happyReduce_11),
        (12 , happyReduce_12),
        (13 , happyReduce_13),
        (14 , happyReduce_14),
        (15 , happyReduce_15),
        (16 , happyReduce_16),
        (17 , happyReduce_17),
        (18 , happyReduce_18),
        (19 , happyReduce_19),
        (20 , happyReduce_20),
        (21 , happyReduce_21),
        (22 , happyReduce_22),
        (23 , happyReduce_23),
        (24 , happyReduce_24),
        (25 , happyReduce_25),
        (26 , happyReduce_26),
        (27 , happyReduce_27),
        (28 , happyReduce_28),
        (29 , happyReduce_29),
        (30 , happyReduce_30),
        (31 , happyReduce_31),
        (32 , happyReduce_32),
        (33 , happyReduce_33),
        (34 , happyReduce_34),
        (35 , happyReduce_35),
        (36 , happyReduce_36),
        (37 , happyReduce_37),
        (38 , happyReduce_38),
        (39 , happyReduce_39),
        (40 , happyReduce_40),
        (41 , happyReduce_41),
        (42 , happyReduce_42),
        (43 , happyReduce_43),
        (44 , happyReduce_44)
        ]

happy_n_terms = 38 :: Prelude.Int
happy_n_nonterms = 7 :: Prelude.Int

happyReduce_1 = happySpecReduce_1  0# happyReduction_1
happyReduction_1 (HappyAbsSyn4  happy_var_1)
         =  HappyAbsSyn4
                 (happy_var_1
        )
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  1# happyReduction_2
happyReduction_2 (HappyTerminal (TokenNum happy_var_1))
         =  HappyAbsSyn4
                 (SNum happy_var_1
        )
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  1# happyReduction_3
happyReduction_3 (HappyTerminal (TokenBool happy_var_1))
         =  HappyAbsSyn4
                 (SBoolean happy_var_1
        )
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1  1# happyReduction_4
happyReduction_4 _
         =  HappyAbsSyn4
                 (SNil
        )

happyReduce_5 = happySpecReduce_1  1# happyReduction_5
happyReduction_5 (HappyTerminal (TokenId happy_var_1))
         =  HappyAbsSyn4
                 (SId happy_var_1
        )
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happyReduce 4# 1# happyReduction_6
happyReduction_6 (_ `HappyStk`
        (HappyAbsSyn6  happy_var_3) `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn4
                 (SAdd happy_var_3
        ) `HappyStk` happyRest

happyReduce_7 = happyReduce 4# 1# happyReduction_7
happyReduction_7 (_ `HappyStk`
        (HappyAbsSyn6  happy_var_3) `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn4
                 (SSub happy_var_3
        ) `HappyStk` happyRest

happyReduce_8 = happyReduce 4# 1# happyReduction_8
happyReduction_8 (_ `HappyStk`
        (HappyAbsSyn6  happy_var_3) `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn4
                 (SMul happy_var_3
        ) `HappyStk` happyRest

happyReduce_9 = happyReduce 4# 1# happyReduction_9
happyReduction_9 (_ `HappyStk`
        (HappyAbsSyn6  happy_var_3) `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn4
                 (SDiv happy_var_3
        ) `HappyStk` happyRest

happyReduce_10 = happyReduce 4# 1# happyReduction_10
happyReduction_10 (_ `HappyStk`
        (HappyAbsSyn4  happy_var_3) `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn4
                 (SAdd1 happy_var_3
        ) `HappyStk` happyRest

happyReduce_11 = happyReduce 4# 1# happyReduction_11
happyReduction_11 (_ `HappyStk`
        (HappyAbsSyn4  happy_var_3) `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn4
                 (SSub1 happy_var_3
        ) `HappyStk` happyRest

happyReduce_12 = happyReduce 4# 1# happyReduction_12
happyReduction_12 (_ `HappyStk`
        (HappyAbsSyn4  happy_var_3) `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn4
                 (SSqrt happy_var_3
        ) `HappyStk` happyRest

happyReduce_13 = happyReduce 5# 1# happyReduction_13
happyReduction_13 (_ `HappyStk`
        (HappyAbsSyn4  happy_var_4) `HappyStk`
        (HappyAbsSyn4  happy_var_3) `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn4
                 (SExpt happy_var_3 happy_var_4
        ) `HappyStk` happyRest

happyReduce_14 = happyReduce 4# 1# happyReduction_14
happyReduction_14 (_ `HappyStk`
        (HappyAbsSyn6  happy_var_3) `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn4
                 (SEq happy_var_3
        ) `HappyStk` happyRest

happyReduce_15 = happyReduce 4# 1# happyReduction_15
happyReduction_15 (_ `HappyStk`
        (HappyAbsSyn6  happy_var_3) `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn4
                 (SLt happy_var_3
        ) `HappyStk` happyRest

happyReduce_16 = happyReduce 4# 1# happyReduction_16
happyReduction_16 (_ `HappyStk`
        (HappyAbsSyn6  happy_var_3) `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn4
                 (SGt happy_var_3
        ) `HappyStk` happyRest

happyReduce_17 = happyReduce 4# 1# happyReduction_17
happyReduction_17 (_ `HappyStk`
        (HappyAbsSyn6  happy_var_3) `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn4
                 (SLte happy_var_3
        ) `HappyStk` happyRest

happyReduce_18 = happyReduce 4# 1# happyReduction_18
happyReduction_18 (_ `HappyStk`
        (HappyAbsSyn6  happy_var_3) `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn4
                 (SGte happy_var_3
        ) `HappyStk` happyRest

happyReduce_19 = happyReduce 4# 1# happyReduction_19
happyReduction_19 (_ `HappyStk`
        (HappyAbsSyn6  happy_var_3) `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn4
                 (SNeq happy_var_3
        ) `HappyStk` happyRest

happyReduce_20 = happyReduce 4# 1# happyReduction_20
happyReduction_20 (_ `HappyStk`
        (HappyAbsSyn6  happy_var_3) `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn4
                 (SAnd happy_var_3
        ) `HappyStk` happyRest

happyReduce_21 = happyReduce 4# 1# happyReduction_21
happyReduction_21 (_ `HappyStk`
        (HappyAbsSyn6  happy_var_3) `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn4
                 (SOr happy_var_3
        ) `HappyStk` happyRest

happyReduce_22 = happyReduce 4# 1# happyReduction_22
happyReduction_22 (_ `HappyStk`
        (HappyAbsSyn4  happy_var_3) `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn4
                 (SNot happy_var_3
        ) `HappyStk` happyRest

happyReduce_23 = happyReduce 5# 1# happyReduction_23
happyReduction_23 (_ `HappyStk`
        (HappyAbsSyn4  happy_var_4) `HappyStk`
        (HappyAbsSyn4  happy_var_3) `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn4
                 (SPair happy_var_3 happy_var_4
        ) `HappyStk` happyRest

happyReduce_24 = happyReduce 4# 1# happyReduction_24
happyReduction_24 (_ `HappyStk`
        (HappyAbsSyn4  happy_var_3) `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn4
                 (SFst happy_var_3
        ) `HappyStk` happyRest

happyReduce_25 = happyReduce 4# 1# happyReduction_25
happyReduction_25 (_ `HappyStk`
        (HappyAbsSyn4  happy_var_3) `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn4
                 (SSnd happy_var_3
        ) `HappyStk` happyRest

happyReduce_26 = happySpecReduce_3  1# happyReduction_26
happyReduction_26 _
        (HappyAbsSyn6  happy_var_2)
        _
         =  HappyAbsSyn4
                 (SList happy_var_2
        )
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happyReduce 6# 1# happyReduction_27
happyReduction_27 (_ `HappyStk`
        (HappyAbsSyn4  happy_var_5) `HappyStk`
        (HappyAbsSyn4  happy_var_4) `HappyStk`
        (HappyAbsSyn4  happy_var_3) `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn4
                 (SIf happy_var_3 happy_var_4 happy_var_5
        ) `HappyStk` happyRest

happyReduce_28 = happyReduce 6# 1# happyReduction_28
happyReduction_28 (_ `HappyStk`
        (HappyAbsSyn4  happy_var_5) `HappyStk`
        (HappyAbsSyn4  happy_var_4) `HappyStk`
        (HappyAbsSyn4  happy_var_3) `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn4
                 (SIf0 happy_var_3 happy_var_4 happy_var_5
        ) `HappyStk` happyRest

happyReduce_29 = happyReduce 4# 1# happyReduction_29
happyReduction_29 (_ `HappyStk`
        (HappyAbsSyn10  happy_var_3) `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn4
                 (SCond happy_var_3
        ) `HappyStk` happyRest

happyReduce_30 = happyReduce 7# 1# happyReduction_30
happyReduction_30 (_ `HappyStk`
        (HappyAbsSyn4  happy_var_6) `HappyStk`
        _ `HappyStk`
        (HappyAbsSyn8  happy_var_4) `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn4
                 (SLambda happy_var_4 happy_var_6
        ) `HappyStk` happyRest

happyReduce_31 = happyReduce 7# 1# happyReduction_31
happyReduction_31 (_ `HappyStk`
        (HappyAbsSyn4  happy_var_6) `HappyStk`
        _ `HappyStk`
        (HappyAbsSyn9  happy_var_4) `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn4
                 (SLet happy_var_4 happy_var_6
        ) `HappyStk` happyRest

happyReduce_32 = happyReduce 7# 1# happyReduction_32
happyReduction_32 (_ `HappyStk`
        (HappyAbsSyn4  happy_var_6) `HappyStk`
        _ `HappyStk`
        (HappyAbsSyn9  happy_var_4) `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn4
                 (SLetStar happy_var_4 happy_var_6
        ) `HappyStk` happyRest

happyReduce_33 = happyReduce 8# 1# happyReduction_33
happyReduction_33 (_ `HappyStk`
        (HappyAbsSyn4  happy_var_7) `HappyStk`
        _ `HappyStk`
        (HappyAbsSyn4  happy_var_5) `HappyStk`
        (HappyTerminal (TokenId happy_var_4)) `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn4
                 (SLetrec happy_var_4 happy_var_5 happy_var_7
        ) `HappyStk` happyRest

happyReduce_34 = happySpecReduce_3  1# happyReduction_34
happyReduction_34 _
        (HappyAbsSyn6  happy_var_2)
        _
         =  HappyAbsSyn4
                 (SApp (head happy_var_2) (tail happy_var_2)
        )
happyReduction_34 _ _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_2  2# happyReduction_35
happyReduction_35 (HappyAbsSyn4  happy_var_2)
        (HappyAbsSyn4  happy_var_1)
         =  HappyAbsSyn6
                 ([happy_var_1, happy_var_2]
        )
happyReduction_35 _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_2  2# happyReduction_36
happyReduction_36 (HappyAbsSyn4  happy_var_2)
        (HappyAbsSyn6  happy_var_1)
         =  HappyAbsSyn6
                 (happy_var_1 ++ [happy_var_2]
        )
happyReduction_36 _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_1  3# happyReduction_37
happyReduction_37 (HappyAbsSyn4  happy_var_1)
         =  HappyAbsSyn6
                 ([happy_var_1]
        )
happyReduction_37 _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_2  3# happyReduction_38
happyReduction_38 (HappyAbsSyn4  happy_var_2)
        (HappyAbsSyn6  happy_var_1)
         =  HappyAbsSyn6
                 (happy_var_1 ++ [happy_var_2]
        )
happyReduction_38 _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_1  4# happyReduction_39
happyReduction_39 (HappyTerminal (TokenId happy_var_1))
         =  HappyAbsSyn8
                 ([happy_var_1]
        )
happyReduction_39 _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_2  4# happyReduction_40
happyReduction_40 (HappyTerminal (TokenId happy_var_2))
        (HappyAbsSyn8  happy_var_1)
         =  HappyAbsSyn8
                 (happy_var_1 ++ [happy_var_2]
        )
happyReduction_40 _ _  = notHappyAtAll 

happyReduce_41 = happyReduce 4# 5# happyReduction_41
happyReduction_41 (_ `HappyStk`
        (HappyAbsSyn4  happy_var_3) `HappyStk`
        (HappyTerminal (TokenId happy_var_2)) `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn9
                 ([(happy_var_2, happy_var_3)]
        ) `HappyStk` happyRest

happyReduce_42 = happyReduce 5# 5# happyReduction_42
happyReduction_42 (_ `HappyStk`
        (HappyAbsSyn4  happy_var_4) `HappyStk`
        (HappyTerminal (TokenId happy_var_3)) `HappyStk`
        _ `HappyStk`
        (HappyAbsSyn9  happy_var_1) `HappyStk`
        happyRest)
         = HappyAbsSyn9
                 (happy_var_1 ++ [(happy_var_3, happy_var_4)]
        ) `HappyStk` happyRest

happyReduce_43 = happyReduce 4# 6# happyReduction_43
happyReduction_43 (_ `HappyStk`
        (HappyAbsSyn4  happy_var_3) `HappyStk`
        (HappyAbsSyn4  happy_var_2) `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn10
                 ([(happy_var_2, happy_var_3)]
        ) `HappyStk` happyRest

happyReduce_44 = happyReduce 5# 6# happyReduction_44
happyReduction_44 (_ `HappyStk`
        (HappyAbsSyn4  happy_var_4) `HappyStk`
        (HappyAbsSyn4  happy_var_3) `HappyStk`
        _ `HappyStk`
        (HappyAbsSyn10  happy_var_1) `HappyStk`
        happyRest)
         = HappyAbsSyn10
                 (happy_var_1 ++ [(happy_var_3, happy_var_4)]
        ) `HappyStk` happyRest

happyNewToken action sts stk [] =
        happyDoAction 37# notHappyAtAll action sts stk []

happyNewToken action sts stk (tk:tks) =
        let cont i = happyDoAction i tk action sts stk tks in
        case tk of {
        TokenLParen -> cont 1#;
        TokenRParen -> cont 2#;
        TokenLBracket -> cont 3#;
        TokenRBracket -> cont 4#;
        TokenAdd -> cont 5#;
        TokenSub -> cont 6#;
        TokenMul -> cont 7#;
        TokenDiv -> cont 8#;
        TokenAdd1 -> cont 9#;
        TokenSub1 -> cont 10#;
        TokenSqrt -> cont 11#;
        TokenExpt -> cont 12#;
        TokenEq -> cont 13#;
        TokenLt -> cont 14#;
        TokenGt -> cont 15#;
        TokenLte -> cont 16#;
        TokenGte -> cont 17#;
        TokenNeq -> cont 18#;
        TokenAnd -> cont 19#;
        TokenOr -> cont 20#;
        TokenNot -> cont 21#;
        TokenPair -> cont 22#;
        TokenFst -> cont 23#;
        TokenSnd -> cont 24#;
        TokenIf -> cont 25#;
        TokenIf0 -> cont 26#;
        TokenCond -> cont 27#;
        TokenArrow -> cont 28#;
        TokenLambda -> cont 29#;
        TokenLet -> cont 30#;
        TokenLetStar -> cont 31#;
        TokenLetrec -> cont 32#;
        TokenNil -> cont 33#;
        TokenNum happy_dollar_dollar -> cont 34#;
        TokenBool happy_dollar_dollar -> cont 35#;
        TokenId happy_dollar_dollar -> cont 36#;
        _ -> happyError' ((tk:tks), [])
        }

happyError_ explist 37# tk tks = happyError' (tks, explist)
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
 happySomeParser = happyThen (happyParse 0# tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


-- ============================================================
-- SINTAXIS DE SUPERFICIE (SASA)
-- ============================================================

data SASA
  = SNum Int
  | SBoolean Bool
  | SNil
  | SId String
  -- Operadores aritméticos variádicos
  | SAdd [SASA]
  | SSub [SASA]
  | SMul [SASA]
  | SDiv [SASA]
  | SAdd1 SASA
  | SSub1 SASA
  | SSqrt SASA
  | SExpt SASA SASA
  -- Predicados variádicos
  | SEq [SASA]
  | SLt [SASA]
  | SGt [SASA]
  | SLte [SASA]
  | SGte [SASA]
  | SNeq [SASA]
  -- Operadores lógicos
  | SAnd [SASA]
  | SOr [SASA]
  | SNot SASA
  -- Pares y listas
  | SPair SASA SASA
  | SFst SASA
  | SSnd SASA
  | SList [SASA]
  -- Condicionales
  | SIf SASA SASA SASA
  | SIf0 SASA SASA SASA
  | SCond [(SASA, SASA)]
  -- Funciones
  | SLambda [String] SASA
  | SApp SASA [SASA]
  -- Vinculación
  | SLet [(String, SASA)] SASA
  | SLetStar [(String, SASA)] SASA
  | SLetrec String SASA SASA
  deriving (Show, Eq)

parseError :: [Token] -> a
parseError tokens = error $ "Parse error: " ++ show tokens
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $

#if !defined(__GLASGOW_HASKELL__)
#  error This code isn't being built with GHC.
#endif

-- Get WORDS_BIGENDIAN (if defined)
#include "MachDeps.h"

-- Do not remove this comment. Required to fix CPP parsing when using GCC and a clang-compiled alex.
#if __GLASGOW_HASKELL__ > 706
#  define LT(n,m) ((Happy_GHC_Exts.tagToEnum# (n Happy_GHC_Exts.<# m)) :: Prelude.Bool)
#  define GTE(n,m) ((Happy_GHC_Exts.tagToEnum# (n Happy_GHC_Exts.>=# m)) :: Prelude.Bool)
#  define EQ(n,m) ((Happy_GHC_Exts.tagToEnum# (n Happy_GHC_Exts.==# m)) :: Prelude.Bool)
#else
#  define LT(n,m) (n Happy_GHC_Exts.<# m)
#  define GTE(n,m) (n Happy_GHC_Exts.>=# m)
#  define EQ(n,m) (n Happy_GHC_Exts.==# m)
#endif
#define PLUS(n,m) (n Happy_GHC_Exts.+# m)
#define MINUS(n,m) (n Happy_GHC_Exts.-# m)
#define TIMES(n,m) (n Happy_GHC_Exts.*# m)
#define NEGATE(n) (Happy_GHC_Exts.negateInt# (n))

type Happy_Int = Happy_GHC_Exts.Int#
data Happy_IntList = HappyCons Happy_Int Happy_IntList

#define ERROR_TOK 0#

#if defined(HAPPY_COERCE)
#  define GET_ERROR_TOKEN(x)  (case Happy_GHC_Exts.unsafeCoerce# x of { (Happy_GHC_Exts.I# i) -> i })
#  define MK_ERROR_TOKEN(i)   (Happy_GHC_Exts.unsafeCoerce# (Happy_GHC_Exts.I# i))
#  define MK_TOKEN(x)         (happyInTok (x))
#else
#  define GET_ERROR_TOKEN(x)  (case x of { HappyErrorToken (Happy_GHC_Exts.I# i) -> i })
#  define MK_ERROR_TOKEN(i)   (HappyErrorToken (Happy_GHC_Exts.I# i))
#  define MK_TOKEN(x)         (HappyTerminal (x))
#endif

#if defined(HAPPY_DEBUG)
#  define DEBUG_TRACE(s)    (happyTrace (s)) $
happyTrace string expr = Happy_System_IO_Unsafe.unsafePerformIO $ do
    Happy_System_IO.hPutStr Happy_System_IO.stderr string
    return expr
#else
#  define DEBUG_TRACE(s)    {- nothing -}
#endif

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
happyAccept ERROR_TOK tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) =
        (happyTcHack j (happyTcHack st)) (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

happyDoAction i tk st =
  DEBUG_TRACE("state: " ++ show (Happy_GHC_Exts.I# st) ++
              ",\ttoken: " ++ show (Happy_GHC_Exts.I# i) ++
              ",\taction: ")
  case happyDecodeAction (happyNextAction i st) of
    HappyFail             -> DEBUG_TRACE("failing.\n")
                             happyFail (happyExpListPerState (Happy_GHC_Exts.I# st)) i tk st
    HappyAccept           -> DEBUG_TRACE("accept.\n")
                             happyAccept i tk st
    HappyReduce rule      -> DEBUG_TRACE("reduce (rule " ++ show (Happy_GHC_Exts.I# rule) ++ ")")
                             (happyReduceArr Happy_Data_Array.! (Happy_GHC_Exts.I# rule)) i tk st
    HappyShift  new_state -> DEBUG_TRACE("shift, enter state " ++ show (Happy_GHC_Exts.I# new_state) ++ "\n")
                             happyShift new_state i tk st

{-# INLINE happyNextAction #-}
happyNextAction i st = case happyIndexActionTable i st of
  Just (Happy_GHC_Exts.I# act) -> act
  Nothing                      -> happyIndexOffAddr happyDefActions st

{-# INLINE happyIndexActionTable #-}
happyIndexActionTable i st
  | GTE(off, 0#), EQ(happyIndexOffAddr happyCheck off, i)
  = Prelude.Just (Happy_GHC_Exts.I# (happyIndexOffAddr happyTable off))
  | otherwise
  = Prelude.Nothing
  where
    off = PLUS(happyIndexOffAddr happyActOffsets st, i)

data HappyAction
  = HappyFail
  | HappyAccept
  | HappyReduce Happy_Int -- rule number
  | HappyShift Happy_Int  -- new state

{-# INLINE happyDecodeAction #-}
happyDecodeAction :: Happy_Int -> HappyAction
happyDecodeAction  0#                        = HappyFail
happyDecodeAction -1#                        = HappyAccept
happyDecodeAction action | LT(action, 0#)    = HappyReduce NEGATE(PLUS(action, 1#))
                         | otherwise         = HappyShift MINUS(action, 1#)

{-# INLINE happyIndexGotoTable #-}
happyIndexGotoTable nt st = happyIndexOffAddr happyTable off
  where
    off = PLUS(happyIndexOffAddr happyGotoOffsets st, nt)

{-# INLINE happyIndexOffAddr #-}
happyIndexOffAddr :: HappyAddr -> Happy_Int -> Happy_Int
happyIndexOffAddr (HappyA# arr) off =
#if __GLASGOW_HASKELL__ >= 901
  Happy_GHC_Exts.int32ToInt# -- qualified import because it doesn't exist on older GHC's
#endif
#ifdef WORDS_BIGENDIAN
  -- The CI of `alex` tests this code path
  (Happy_GHC_Exts.word32ToInt32# (Happy_GHC_Exts.wordToWord32# (Happy_GHC_Exts.byteSwap32# (Happy_GHC_Exts.word32ToWord# (Happy_GHC_Exts.int32ToWord32#
#endif
  (Happy_GHC_Exts.indexInt32OffAddr# arr off)
#ifdef WORDS_BIGENDIAN
  )))))
#endif

{-# INLINE happyLt #-}
happyLt x y = LT(x,y)

readArrayBit arr bit =
    Bits.testBit (Happy_GHC_Exts.I# (happyIndexOffAddr arr ((unbox_int bit) `Happy_GHC_Exts.iShiftRA#` 5#))) (bit `Prelude.mod` 32)
  where unbox_int (Happy_GHC_Exts.I# x) = x

data HappyAddr = HappyA# Happy_GHC_Exts.Addr#

-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state ERROR_TOK tk st sts stk@(x `HappyStk` _) =
     let i = GET_ERROR_TOKEN(x) in
-- trace "shifting the error token" $
     happyDoAction i tk new_state (HappyCons st sts) stk

happyShift new_state i tk st sts stk =
     happyNewToken new_state (HappyCons st sts) (MK_TOKEN(tk) `HappyStk` stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn ERROR_TOK tk st sts stk
     = happyFail [] ERROR_TOK tk st sts stk
happySpecReduce_0 nt fn j tk st sts stk
     = happyGoto nt j tk st (HappyCons st sts) (fn `HappyStk` stk)

happySpecReduce_1 i fn ERROR_TOK tk st sts stk
     = happyFail [] ERROR_TOK tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(HappyCons st _) (v1 `HappyStk` stk')
     = let r = fn v1 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn ERROR_TOK tk st sts stk
     = happyFail [] ERROR_TOK tk st sts stk
happySpecReduce_2 nt fn j tk _
  (HappyCons _ sts@(HappyCons st _))
  (v1 `HappyStk` v2 `HappyStk` stk')
     = let r = fn v1 v2 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn ERROR_TOK tk st sts stk
     = happyFail [] ERROR_TOK tk st sts stk
happySpecReduce_3 nt fn j tk _
  (HappyCons _ (HappyCons _ sts@(HappyCons st _)))
  (v1 `HappyStk` v2 `HappyStk` v3 `HappyStk` stk')
     = let r = fn v1 v2 v3 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn ERROR_TOK tk st sts stk
     = happyFail [] ERROR_TOK tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop MINUS(k,(1# :: Happy_Int)) sts of
         sts1@(HappyCons st1 _) ->
                let r = fn stk in -- it doesn't hurt to always seq here...
                happyDoSeq r (happyGoto nt j tk st1 sts1 r)

happyMonadReduce k nt fn ERROR_TOK tk st sts stk
     = happyFail [] ERROR_TOK tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k (HappyCons st sts) of
        sts1@(HappyCons st1 _) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk)
                     (\r -> happyGoto nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn ERROR_TOK tk st sts stk
     = happyFail [] ERROR_TOK tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k (HappyCons st sts) of
        sts1@(HappyCons st1 _) ->
          let drop_stk = happyDropStk k stk
              off = happyAdjustOffset (happyIndexOffAddr happyGotoOffsets st1)
              off_i = PLUS(off, nt)
              new_state = happyIndexOffAddr happyTable off_i
          in
            happyThen1 (fn stk tk)
                       (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop 0# l               = l
happyDrop n  (HappyCons _ t) = happyDrop MINUS(n,(1# :: Happy_Int)) t

happyDropStk 0# l                 = l
happyDropStk n  (x `HappyStk` xs) = happyDropStk MINUS(n,(1#::Happy_Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

happyGoto nt j tk st =
   DEBUG_TRACE(", goto state " ++ show (Happy_GHC_Exts.I# new_state) ++ "\n")
   happyDoAction j tk new_state
  where new_state = happyIndexGotoTable nt st

-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist ERROR_TOK tk old_st _ stk@(x `HappyStk` _) =
     let i = GET_ERROR_TOKEN(x) in
--      trace "failing" $
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st (HappyCons action sts)
                               (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        happyDoAction ERROR_TOK tk action sts (saved_tok`HappyStk`stk)
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk action sts stk =
-- trace "entering error recovery" $
        happyDoAction ERROR_TOK tk action sts (MK_ERROR_TOKEN(i) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = Prelude.error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions

happyTcHack :: Happy_Int -> a -> a
happyTcHack x y = y
{-# INLINE happyTcHack #-}

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

{-# NOINLINE happyDoAction #-}
{-# NOINLINE happyTable #-}
{-# NOINLINE happyCheck #-}
{-# NOINLINE happyActOffsets #-}
{-# NOINLINE happyGotoOffsets #-}
{-# NOINLINE happyDefActions #-}

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
