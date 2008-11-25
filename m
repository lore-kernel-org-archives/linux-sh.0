From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 25 Nov 2008 17:06:03 +0000
Subject: Re: [RFC PATCH V2 FIX] Fix deadlock during find
Message-Id: <20081125170603.GA24395@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20081120134502.GA27286@gandalf.sssup.it>
In-Reply-To: <20081120134502.GA27286@gandalf.sssup.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 20, 2008 at 02:45:02PM +0100, Michael Trimarchi wrote:
> Fix a deadlock during find.
> 
> Continue with testing i find and errata implementation in the unlock.
> This patch fix the deadlock.
> 
> Signed-off-by: Michael Trimarchi <trimarchimichael@yahoo.it>
> 
> ---
>  arch/sh/include/asm/mutex_sh.h |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/sh/include/asm/mutex_sh.h b/arch/sh/include/asm/mutex_sh.h
> index c98e875..c65f19e 100644
> --- a/arch/sh/include/asm/mutex_sh.h
> +++ b/arch/sh/include/asm/mutex_sh.h
> @@ -48,18 +48,18 @@ __mutex_fastpath_lock_retval(atomic_t *count, int (*fail_fn)(atomic_t *))
>  static inline void
>  __mutex_fastpath_unlock(atomic_t *count, void (*fail_fn)(atomic_t *))
>  {
> -	int __res, __orig;
> +	int __res;
>  
>  	__asm__ __volatile__ (
> -		"movli.l	@%2, %0	\n\t"
> -		"mov		%0, %1	\n\t"
> +		"1: movli.l	@%1, %0	\n\t"
>  		"add		#1, %0	\n\t"
> -		"movco.l	%0, @%2 "
> -		: "=&z" (__res), "=&r" (__orig)
> +		"movco.l	%0, @%1 \n\t"
> +		"bf		1b\n\t"
> +		: "=&z" (__res)
>  		: "r" (&(count)->counter)
>  		: "t" );
>  
> -	if (unlikely(__orig != 0))
> +	if (unlikely(__res <= 0))
>  		fail_fn(count);
>  }
>  

Making __mutex_fastpath_unlock() loop seems counter-intuitive. I think
the initial test on __orig is what was causing you issues rather than the
need for looping. I do see why ARM did it this way, but we don't have
precisely the same semantics there.

Does the following patch against current git pass your test cases?

---

 arch/sh/include/asm/mutex-llsc.h |   37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)
 
diff --git a/arch/sh/include/asm/mutex-llsc.h b/arch/sh/include/asm/mutex-llsc.h
index 7c75af5..a91990c 100644
--- a/arch/sh/include/asm/mutex-llsc.h
+++ b/arch/sh/include/asm/mutex-llsc.h
@@ -21,16 +21,18 @@
 static inline void
 __mutex_fastpath_lock(atomic_t *count, void (*fail_fn)(atomic_t *))
 {
-	int __res;
+	int __ex_flag, __res;
 
 	__asm__ __volatile__ (
-		"movli.l	@%1, %0	\n"
-		"dt		%0	\n"
-		"movco.l	%0, @%1	\n"
-		: "=&z" (__res)
+		"movli.l	@%2, %0	\n"
+		"add		#-1, %0	\n"
+		"movco.l	%0, @%2	\n"
+		"movt		%1	\n"
+		: "=&z" (__res), "=&r" (__ex_flag)
 		: "r" (&(count)->counter)
 		: "t");
 
+	__res |= !__ex_flag;
 	if (unlikely(__res != 0))
 		fail_fn(count);
 }
@@ -38,16 +40,18 @@ __mutex_fastpath_lock(atomic_t *count, void (*fail_fn)(atomic_t *))
 static inline int
 __mutex_fastpath_lock_retval(atomic_t *count, int (*fail_fn)(atomic_t *))
 {
-	int __res;
+	int __ex_flag, __res;
 
 	__asm__ __volatile__ (
-		"movli.l	@%1, %0	\n"
-		"dt		%0	\n"
-		"movco.l	%0, @%1	\n"
-		: "=&z" (__res)
+		"movli.l	@%2, %0	\n"
+		"add		#-1, %0	\n"
+		"movco.l	%0, @%2	\n"
+		"movt		%1	\n"
+		: "=&z" (__res), "=&r" (__ex_flag)
 		: "r" (&(count)->counter)
 		: "t");
 
+	__res |= !__ex_flag;
 	if (unlikely(__res != 0))
 		__res = fail_fn(count);
 
@@ -57,18 +61,19 @@ __mutex_fastpath_lock_retval(atomic_t *count, int (*fail_fn)(atomic_t *))
 static inline void
 __mutex_fastpath_unlock(atomic_t *count, void (*fail_fn)(atomic_t *))
 {
-	int __res;
+	int __ex_flag, __res;
 
 	__asm__ __volatile__ (
-		"1: movli.l	@%1, %0	\n\t"
+		"movli.l	@%2, %0	\n\t"
 		"add		#1, %0	\n\t"
-		"movco.l	%0, @%1 \n\t"
-		"bf		1b\n\t"
-		: "=&z" (__res)
+		"movco.l	%0, @%2 \n\t"
+		"movt		%1	\n\t"
+		: "=&z" (__res), "=&r" (__ex_flag)
 		: "r" (&(count)->counter)
 		: "t");
 
-	if (unlikely(__res <= 0))
+	__res |= !__ex_flag;
+	if (unlikely(__res != 0))
 		fail_fn(count);
 }
 
