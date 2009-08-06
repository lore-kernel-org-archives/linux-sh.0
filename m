From: Valentin R Sitsikov <valentin.sitdikov@siemens.com>
Date: Thu, 06 Aug 2009 09:03:47 +0000
Subject: sh7785 cache question
Message-Id: <4A7A9C73.1070000@siemens.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello All!

Sh-7785 hw manual section 5 (Caches), chapter 5.3 (Operation of 
Instructions for Operand Cache Manipulation.) says:
OCBI
OCBWB
OCBP

Formerly, this instruction was treated as an NOP if Rn indicated an 
address in a non-cacheable
area. In the case of the LSI with the SH-4A extended functions, the 
operand cache line indicated
by way = Rn[14:13] and entry = Rn[12:5] is affected.
This operation is only valid in privileged mode, and the instruction 
generates an
address error exception in user mode. In addition, TLB-related 
exceptions do not occur.
Do not execute this instruction with Rn[31:24] containing a value other 
than H'F4, i.e. a value that
indicates the memory-mapped array area, control register area, or a 
reserved area (H'F0 to H'F3,
H'F5 to H'FF).

So my question is why still all cache related code for the sh-7785 in 
these instructions have effective address
as operand instead of 0xF4XXXXXX ?

Also It is interesting if there any plans for remove associative write 
operation to memory mapped OC address array?
The manual says:
5.4       Memory-Mapped Associative Write Operation
Associative writing to the IC and OC address arrays may not be supported 
in future SuperH-
family products. The use of instructions ICBI, OCBI, OCBP, and OCBWB is 
recommended.
These instructions handle ITLB misses, and notify instruction TLB miss 
exceptions and data TLB
miss exceptions, thus providing a sure way of controlling the IC and OC. 
As a transitional
measure, the SH-4A generates address errors when this function is used. 
If compatibility with
previous products is a crucial consideration, on the other hand, the 
MMCAW bit in EXPMASK
(H'FF2F 0004) can be set to 1 to enable this function. However, 
instructions ICBI, OCBI, OCBP,
and OCBWB should be used to guarantee compatibility with future 
SuperH-family products.


Thanks in advance.

