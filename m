From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 06 Nov 2009 22:42:05 +0000
Subject: [patch 13/16] sh: Replace old style lock initializer
Message-Id: <20091106223806.933145642@linutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20091106223547.784916750@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

SPIN_LOCK_UNLOCKED is deprecated. Use __SPIN_LOCK_UNLOCKED instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/include/asm/rwsem.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/arch/sh/include/asm/rwsem.h
=================================--- linux-2.6.orig/arch/sh/include/asm/rwsem.h
+++ linux-2.6/arch/sh/include/asm/rwsem.h
@@ -41,7 +41,7 @@ struct rw_semaphore {
 #endif
 
 #define __RWSEM_INITIALIZER(name) \
-	{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
+	{ RWSEM_UNLOCKED_VALUE, __SPIN_LOCK_UNLOCKED((name).wait_lock), \
 	  LIST_HEAD_INIT((name).wait_list) \
 	  __RWSEM_DEP_MAP_INIT(name) }
 


