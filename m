From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 26 Aug 2016 12:55:39 +0000
Subject: Re: [kbuild-all] [peterz-queue:locking/rfc 3/5] arch/sh/include/asm/atomic-llsc.h:76:38: note: in ex
Message-Id: <20160826125539.GN10121@twins.programming.kicks-ass.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20160826114225.hloesk72zqvajrmj@wfg-t540p.sh.intel.com>
In-Reply-To: <20160826114225.hloesk72zqvajrmj@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

On Fri, Aug 26, 2016 at 08:31:53PM +0800, Fengguang Wu wrote:
> On Fri, Aug 26, 2016 at 07:42:25PM +0800, Fengguang Wu wrote:

> It's this atomic_long_fetch_and() that triggered the error.
> It builds fine if line 505 is commented out.
> 
> 503         owner = atomic_long_read(&lock->owner);
> 504         if (!(owner & MUTEX_FLAG_HANDOFF))
> 505                 owner = atomic_long_fetch_and(MUTEX_FLAGS,
> &lock->owner);
> ~~~~~~~~~~~~~~~~~~~~~
> 
> Cheers,
> Fengguang
> 
> >./arch/sh/include/asm/atomic-llsc.h:56:2: error: can’t find a register in class ‘R0_REGS’ while reloading ‘asm’
> > __asm__ __volatile__ (      \
> > ^
> >./arch/sh/include/asm/atomic-llsc.h:76:38: note: in expansion of macro ‘ATOMIC_FETCH_OP’
> >#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_FETCH_OP(op)
> >                                     ^~~~~~~~~~~~~~~
> >./arch/sh/include/asm/atomic-llsc.h:78:1: note: in expansion of macro ‘ATOMIC_OPS’
> >ATOMIC_OPS(and)
> >^~~~~~~~~~
> >./arch/sh/include/asm/atomic-llsc.h:56:2: error: ‘asm’ operand has impossible constraints
> > __asm__ __volatile__ (      \

Yes, that much was clear from the above. I just odn't know enough about
SH asm to know how to go fix it.

There's a note there that says movli.l/movco.l requires r0, and maybe it
somehow tries to use 2 of those.

But I cannot find the inline asm constraints documented for SH:

  https://gcc.gnu.org/onlinedocs/gcc-6.2.0/gcc/Machine-Constraints.html#Machine-Constraints

Ahh..

  https://github.com/gcc-mirror/gcc/blob/master/gcc/config/sh/constraints.md

has them... would something like so fix things?


diff --git a/arch/sh/include/asm/atomic-llsc.h b/arch/sh/include/asm/atomic-llsc.h
index caea2c45f6c2..1d159ce50f5a 100644
--- a/arch/sh/include/asm/atomic-llsc.h
+++ b/arch/sh/include/asm/atomic-llsc.h
@@ -60,7 +60,7 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)			\
 "	movco.l	%0, @%3					\n"		\
 "	bf	1b					\n"		\
 "	synco						\n"		\
-	: "=&z" (temp), "=&z" (res)					\
+	: "=&z" (temp), "=&r" (res)					\
 	: "r" (i), "r" (&v->counter)					\
 	: "t");								\
 									\
