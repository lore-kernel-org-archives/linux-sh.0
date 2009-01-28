From: Takashi Yoshii <yoshii.takashi@renesas.com>
Date: Wed, 28 Jan 2009 09:29:13 +0000
Subject: Re: [bug report] dead lock (?) occur on ap325 board
Message-Id: <49802569.4000808@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uprie4cmj.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uprie4cmj.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Kunihiro's fix looks good for me.
I have accidentally(?) fixed this one just same way as him.

I don't know why the original code does 
> 	__res |= !__ex_flag;
to combine the results (counter and exception flag).
Logical-OR to scaler value is logically:) wrong.
# And using movt explicitly results stupid code generated anyway.

Because this __ex_flag is from "t" of movco, which means
 0: interrupted by int or exp.
 1: done successfully.
, it works as "Low-active" signal, and is not easy to handle
as a C-language conditon.

So, I think 
        int __done, __res;
        ....
        if (unlikely(!done || __res != 0))

is easier to read.
This fixes the deadlock issue Kunihiro reported (by coincident:).

# I'm not sure if this is suitable to be marked as "earlyclobber",
# but I leave it as-is, since nothing bad will occur.
/yoshii

Fix conditon checking expression of __mutex_fastpath_*

Signed-off-by: Takashi YOSHII <yoshii.takashi@renesas.com>
---
 arch/sh/include/asm/mutex-llsc.h |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/sh/include/asm/mutex-llsc.h b/arch/sh/include/asm/mutex-llsc.h
index ee839ee..66f045f 100644
--- a/arch/sh/include/asm/mutex-llsc.h
+++ b/arch/sh/include/asm/mutex-llsc.h
@@ -21,38 +21,36 @@
 static inline void
 __mutex_fastpath_lock(atomic_t *count, void (*fail_fn)(atomic_t *))
 {
-	int __ex_flag, __res;
+	int __done, __res;
 
 	__asm__ __volatile__ (
 		"movli.l	@%2, %0	\n"
 		"add		#-1, %0	\n"
 		"movco.l	%0, @%2	\n"
 		"movt		%1	\n"
-		: "=&z" (__res), "=&r" (__ex_flag)
+		: "=&z" (__res), "=&r" (__done)
 		: "r" (&(count)->counter)
 		: "t");
 
-	__res |= !__ex_flag;
-	if (unlikely(__res != 0))
+	if (unlikely(!__done || __res != 0))
 		fail_fn(count);
 }
 
 static inline int
 __mutex_fastpath_lock_retval(atomic_t *count, int (*fail_fn)(atomic_t *))
 {
-	int __ex_flag, __res;
+	int __done, __res;
 
 	__asm__ __volatile__ (
 		"movli.l	@%2, %0	\n"
 		"add		#-1, %0	\n"
 		"movco.l	%0, @%2	\n"
 		"movt		%1	\n"
-		: "=&z" (__res), "=&r" (__ex_flag)
+		: "=&z" (__res), "=&r" (__done)
 		: "r" (&(count)->counter)
 		: "t");
 
-	__res |= !__ex_flag;
-	if (unlikely(__res != 0))
+	if (unlikely(!__done || __res != 0))
 		__res = fail_fn(count);
 
 	return __res;
@@ -61,19 +59,18 @@ __mutex_fastpath_lock_retval(atomic_t *count, int (*fail_fn)(atomic_t *))
 static inline void
 __mutex_fastpath_unlock(atomic_t *count, void (*fail_fn)(atomic_t *))
 {
-	int __ex_flag, __res;
+	int __done, __res;
 
 	__asm__ __volatile__ (
 		"movli.l	@%2, %0	\n\t"
 		"add		#1, %0	\n\t"
 		"movco.l	%0, @%2 \n\t"
 		"movt		%1	\n\t"
-		: "=&z" (__res), "=&r" (__ex_flag)
+		: "=&z" (__res), "=&r" (__done)
 		: "r" (&(count)->counter)
 		: "t");
 
-	__res |= !__ex_flag;
-	if (unlikely(__res <= 0))
+	if (unlikely(!__done || __res <= 0))
 		fail_fn(count);
 }
 
-- 1.6.0.6 
