From: Matt Fleming <matt@console-pimps.org>
Date: Sat, 26 Sep 2009 19:44:05 +0000
Subject: [PATCH] sh: Don't enable interrupts in the page fault path
Message-Id: <1253994245-3739-1-git-send-email-matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

There's already code in do_page_fault() to conditionally enable
interrupts, so we don't need to unconditonally enable them before
calling it. This fixes a lockdep warning where we called
trace_hardirqs_off() but with irqs still enabled.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/kernel/cpu/sh3/entry.S |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh3/entry.S b/arch/sh/kernel/cpu/sh3/entry.S
index 0151933..bb407ef 100644
--- a/arch/sh/kernel/cpu/sh3/entry.S
+++ b/arch/sh/kernel/cpu/sh3/entry.S
@@ -152,8 +152,6 @@ call_do_page_fault:
 	mov.l	1f, r0
 	mov.l	@r0, r6
 
-	sti
-
 	mov.l	3f, r0
 	mov.l	4f, r1
 	mov	r15, r4
-- 
1.6.3.3

