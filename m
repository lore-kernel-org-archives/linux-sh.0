From: Michael Trimarchi <trimarchimichael@yahoo.it>
Date: Thu, 20 Nov 2008 11:58:56 +0000
Subject: [RFC PATCH] Adjust the test in the unlock for sh4a fastlock
Message-Id: <20081120115856.GA26785@gandalf.sssup.it>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

[RFC PATCH] Adjust the test in the unlock for sh4a fastlock

The test condition in the previus patch was wrong.
Test on MigoR board

Signed-off-by: Trimarchi Michael <michaeltrimarchi@yahoo.it>

---
 arch/sh/include/asm/mutex_sh.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/mutex_sh.h b/arch/sh/include/asm/mutex_sh.h
index c62f5af..7a12036 100644
--- a/arch/sh/include/asm/mutex_sh.h
+++ b/arch/sh/include/asm/mutex_sh.h
@@ -49,7 +49,6 @@ static inline void
 __mutex_fastpath_unlock(atomic_t *count, void (*fail_fn)(atomic_t *))
 {
 	int __res;
-
 	__asm__ __volatile__ (
 		"movli.l	@%1, %0	\n"
 		"add		#1, %0	\n"
@@ -58,7 +57,7 @@ __mutex_fastpath_unlock(atomic_t *count, void (*fail_fn)(atomic_t *))
 		: "r" (&(count)->counter)
 		: "t" );
 
-	if (unlikely(__res != 0))
+	if (unlikely(__res <= 0))
 		fail_fn(count);
 }
 
-- 
1.5.6.5

