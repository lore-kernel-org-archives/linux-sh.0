From: Valentin Schneider <valentin.schneider@arm.com>
Date: Mon, 11 Mar 2019 22:47:48 +0000
Subject: [PATCH 10/14] sh: entry: Remove unneeded need_resched() loop
Message-Id: <20190311224752.8337-11-valentin.schneider@arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20190311224752.8337-1-valentin.schneider@arm.com>
In-Reply-To: <20190311224752.8337-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

Since the enabling and disabling of IRQs within preempt_schedule_irq()
is contained in a need_resched() loop, we don't need the outer arch
code loop.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/kernel/entry-common.S | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/sh/kernel/entry-common.S b/arch/sh/kernel/entry-common.S
index d31f66e82ce5..65a105de52a0 100644
--- a/arch/sh/kernel/entry-common.S
+++ b/arch/sh/kernel/entry-common.S
@@ -93,7 +93,7 @@ ENTRY(resume_kernel)
 	mov.l	@(TI_PRE_COUNT,r8), r0	! current_thread_info->preempt_count
 	tst	r0, r0
 	bf	noresched
-need_resched:
+
 	mov.l	@(TI_FLAGS,r8), r0	! current_thread_info->flags
 	tst	#_TIF_NEED_RESCHED, r0	! need_resched set?
 	bt	noresched
@@ -107,8 +107,6 @@ need_resched:
 	mov.l	1f, r0
 	jsr	@r0			! call preempt_schedule_irq
 	 nop
-	bra	need_resched
-	 nop
 
 noresched:
 	bra	__restore_all
-- 
2.20.1
