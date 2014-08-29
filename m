From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 29 Aug 2014 18:15:45 +0000
Subject: [PATCH 3/3] ARM: shmobile: Add CA7 arch_timer initialization for secondary CPUs
Message-Id: <1409336145-619-4-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

In case of CA7, arch timer CNTVOFF register is uninitialized.
CNTVOFF must be initialized. This patch is for secondary CPUs.

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
---
 arch/arm/mach-shmobile/headsmp.S | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/mach-shmobile/headsmp.S b/arch/arm/mach-shmobile/headsmp.S
index 50c4915..9dc660d 100644
--- a/arch/arm/mach-shmobile/headsmp.S
+++ b/arch/arm/mach-shmobile/headsmp.S
@@ -1,6 +1,7 @@
 /*
  * SMP support for R-Mobile / SH-Mobile
  *
+ * Copyright (C) 2014  Renesas Electronics Corporation
  * Copyright (C) 2010  Magnus Damm
  * Copyright (C) 2010  Takashi Yoshii
  *
@@ -19,6 +20,31 @@
 #ifdef CONFIG_SMP
 ENTRY(shmobile_invalidate_start)
 	bl	v7_invalidate_l1
+
+	mrc	p15, 0, r0, c0, c0, 0
+	lsr	r0, #4
+	tst	r0, #0x7
+	beq	1f
+	lsr	r0, #4
+	tst	r0, #0xC0
+	beq	1f
+	/* CA7 setup */
+	/* CNTVOFF has to be initialized either from non-secure Hypervisor
+	 * mode or secure Monitor mode with SCR.NS=1. If TrustZone is enabled
+	 * then it should be handled by the secure code */
+	cps	0x16
+	mrc	p15, 0, r1, c1, c1, 0
+	orr	r0, r1, #1
+	mcr	p15, 0, r0, c1, c1, 0
+	isb
+	mov	r0, #0
+	mcrr	p15, 4, r0, r0, c14
+	isb
+	mcr	p15, 0, r1, c1, c1, 0
+	isb
+	cps	0x13
+1:
+
 	b	secondary_startup
 ENDPROC(shmobile_invalidate_start)
 #endif
-- 
1.8.4.5

