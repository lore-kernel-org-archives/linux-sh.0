From: Adrian Bunk <bunk@kernel.org>
Date: Fri, 22 Aug 2008 15:20:40 +0000
Subject: sh64 put_user() breakage
Message-Id: <20080822152040.GC26762@cs181140183.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Commit 42fd3b142d8867f5b58d6fb75592cd20fd654c1b
(sh: Initial consolidation of the _32/_64 uaccess split.)
causes the following build error:

<--  snip  -->

...
  CC      arch/sh/kernel/ptrace_64.o
cc1: warnings being treated as errors
arch/sh/kernel/ptrace_64.c: In function 'arch_ptrace':
arch/sh/kernel/ptrace_64.c:162: error: passing argument 1 of '__put_user_asm_b' makes pointer from integer without a cast
arch/sh/kernel/ptrace_64.c:162: error: passing argument 2 of '__put_user_asm_b' makes integer from pointer without a cast
arch/sh/kernel/ptrace_64.c:162: error: passing argument 1 of '__put_user_asm_w' makes pointer from integer without a cast
arch/sh/kernel/ptrace_64.c:162: error: passing argument 2 of '__put_user_asm_w' makes integer from pointer without a cast
arch/sh/kernel/ptrace_64.c:162: error: passing argument 1 of '__put_user_asm_l' makes pointer from integer without a cast
arch/sh/kernel/ptrace_64.c:162: error: passing argument 2 of '__put_user_asm_l' makes integer from pointer without a cast
arch/sh/kernel/ptrace_64.c:162: error: passing argument 1 of '__put_user_asm_q' makes pointer from integer without a cast
arch/sh/kernel/ptrace_64.c:162: error: passing argument 2 of '__put_user_asm_q' makes integer from pointer without a cast
make[2]: *** [arch/sh/kernel/ptrace_64.o] Error 1

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


