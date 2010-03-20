From: Andreas Bombe <aeb@debian.org>
Date: Sat, 20 Mar 2010 00:38:01 +0000
Subject: [PATCH] sh: Remove long unused mid_sched macro
Message-Id: <20100320003800.GA7568@amos.infernal>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

interruptible_sleep_on() is referenced for use in the mid_sched macro
which is not used anywhere.  Remove reference and macro as well as the
comment which appears to belong with them.

Signed-off-by: Andreas Bombe <aeb@debian.org>
---

At least the mid_sched name does not appear anywhere else.  It doesn't
even appear to have been in use at any time during the kernel's git
history.

 arch/sh/kernel/process_64.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/sh/kernel/process_64.c b/arch/sh/kernel/process_64.c
index c90957a..c0d40f6 100644
--- a/arch/sh/kernel/process_64.c
+++ b/arch/sh/kernel/process_64.c
@@ -504,13 +504,6 @@ out:
 	return error;
 }
 
-/*
- * These bracket the sleeping functions..
- */
-extern void interruptible_sleep_on(wait_queue_head_t *q);
-
-#define mid_sched	((unsigned long) interruptible_sleep_on)
-
 #ifdef CONFIG_FRAME_POINTER
 static int in_sh64_switch_to(unsigned long pc)
 {
-- 
1.7.0.2

