From: Brian Norris <computersforpeace@gmail.com>
Date: Wed, 28 May 2014 22:57:32 +0000
Subject: [PATCH] SH: annotate code after BUG() as unreachable
Message-Id: <1401317852-32386-1-git-send-email-computersforpeace@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Brian Norris <computersforpeace@gmail.com>, linux-sh@vger.kernel.org

This squashes some warnings:

  CC      mm/bootmem.o
mm/bootmem.c: In function 'mark_bootmem':
mm/bootmem.c:379:1: warning: control reaches end of non-void function [-Wreturn-type]

  CC      kernel/sched/core.o
kernel/sched/core.c: In function 'pick_next_task':
kernel/sched/core.c:2610:1: warning: control reaches end of non-void function [-Wreturn-type]

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/include/asm/bug.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/include/asm/bug.h b/arch/sh/include/asm/bug.h
index dcf278075429..1ae948f309f2 100644
--- a/arch/sh/include/asm/bug.h
+++ b/arch/sh/include/asm/bug.h
@@ -48,6 +48,7 @@ do {							\
 		   "i" (__FILE__),			\
 		   "i" (__LINE__), "i" (0),		\
 		   "i" (sizeof(struct bug_entry)));	\
+	unreachable();					\
 } while (0)
 
 #define __WARN_TAINT(taint)				\
-- 
1.9.1

