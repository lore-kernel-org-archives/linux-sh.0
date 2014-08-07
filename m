From: Nick Krause <xerofoiify@gmail.com>
Date: Thu, 07 Aug 2014 01:42:20 +0000
Subject: [PATCH] sh: bug: add unreachable() to silence warnings
Message-Id: <1407375741-3209-1-git-send-email-xerofoiify@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms+renesas@verge.net.au>, "GitAuthor: Nick Krause" <xerofoiify@gmail.com>, "open list:SUPERH" <linux-sh@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: josh@joshtriplett.org

SuperH BUG() have warnings like

kernel/sched/core.c:2692:1: warning: control reaches end of non-void function
[-Wreturn-type]
net/core/ethtool.c:236:1: warning: control reaches end of non-void function
[-Wreturn-type]

Other BUG() implementations
have added unreachable() at end becuase of which I guess
it does not showthese errors. We can silence them using unreachable().

Signed-off-by: Nick Krause <xerofoify@gmail.com>
---
 arch/sh/include/asm/bug.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/include/asm/bug.h b/arch/sh/include/asm/bug.h
index dcf2780..1ae948f 100644
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
2.0.1

