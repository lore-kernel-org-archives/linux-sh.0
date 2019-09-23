From: Valentin Schneider <valentin.schneider@arm.com>
Date: Mon, 23 Sep 2019 14:36:19 +0000
Subject: [PATCH v2 8/9] sh64: entry: Remove unneeded need_resched() loop
Message-Id: <20190923143620.29334-9-valentin.schneider@arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20190923143620.29334-1-valentin.schneider@arm.com>
In-Reply-To: <20190923143620.29334-1-valentin.schneider@arm.com>
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
 arch/sh/kernel/cpu/sh5/entry.S | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh5/entry.S b/arch/sh/kernel/cpu/sh5/entry.S
index de68ffdfffbf..40e6d9a7a6a2 100644
--- a/arch/sh/kernel/cpu/sh5/entry.S
+++ b/arch/sh/kernel/cpu/sh5/entry.S
@@ -897,7 +897,6 @@ resume_kernel:
 	ld.l	r6, TI_PRE_COUNT, r7
 	beq/u	r7, ZERO, tr0
 
-need_resched:
 	ld.l	r6, TI_FLAGS, r7
 	movi	(1 << TIF_NEED_RESCHED), r8
 	and	r8, r7, r8
@@ -911,9 +910,7 @@ need_resched:
 	ori	r7, 1, r7
 	ptabs	r7, tr1
 	blink	tr1, LINK
-
-	pta	need_resched, tr1
-	blink	tr1, ZERO
+	blink   tr0, ZERO
 #endif
 
 	.global ret_from_syscall
-- 
2.22.0
