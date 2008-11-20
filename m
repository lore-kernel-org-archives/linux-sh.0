From: Michael Trimarchi <trimarchimichael@yahoo.it>
Date: Thu, 20 Nov 2008 13:45:02 +0000
Subject: [RFC PATCH V2 FIX] Fix deadlock during find
Message-Id: <20081120134502.GA27286@gandalf.sssup.it>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Fix a deadlock during find.

Continue with testing i find and errata implementation in the unlock.
This patch fix the deadlock.

Signed-off-by: Michael Trimarchi <trimarchimichael@yahoo.it>

---
 arch/sh/include/asm/mutex_sh.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sh/include/asm/mutex_sh.h b/arch/sh/include/asm/mutex_sh.h
index c98e875..c65f19e 100644
--- a/arch/sh/include/asm/mutex_sh.h
+++ b/arch/sh/include/asm/mutex_sh.h
@@ -48,18 +48,18 @@ __mutex_fastpath_lock_retval(atomic_t *count, int (*fail_fn)(atomic_t *))
 static inline void
 __mutex_fastpath_unlock(atomic_t *count, void (*fail_fn)(atomic_t *))
 {
-	int __res, __orig;
+	int __res;
 
 	__asm__ __volatile__ (
-		"movli.l	@%2, %0	\n\t"
-		"mov		%0, %1	\n\t"
+		"1: movli.l	@%1, %0	\n\t"
 		"add		#1, %0	\n\t"
-		"movco.l	%0, @%2 "
-		: "=&z" (__res), "=&r" (__orig)
+		"movco.l	%0, @%1 \n\t"
+		"bf		1b\n\t"
+		: "=&z" (__res)
 		: "r" (&(count)->counter)
 		: "t" );
 
-	if (unlikely(__orig != 0))
+	if (unlikely(__res <= 0))
 		fail_fn(count);
 }
 
-- 
1.5.6.5

