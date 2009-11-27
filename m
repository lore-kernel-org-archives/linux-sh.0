From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 27 Nov 2009 05:16:21 +0000
Subject: [PATCH] sh: Add CPG save/restore code for sh7724 R-standby
Message-Id: <20091127051621.24738.14619.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add sh7724 code to save and restore CPG state during
R-standby. Only CPG registers IRDACLKCR and SPUCLKCR
require software save and restore.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7724.c	2009-11-27 14:07:07.000000000 +0900
@@ -941,6 +941,9 @@ static struct {
 	/* RWDT */
 	unsigned short rwtcnt;
 	unsigned short rwtcsr;
+	/* CPG */
+	unsigned long irdaclk;
+	unsigned long spuclk;
 } sh7724_rstandby_state;
 
 static int sh7724_pre_sleep_notifier_call(struct notifier_block *nb,
@@ -998,6 +1001,10 @@ static int sh7724_pre_sleep_notifier_cal
 	sh7724_rstandby_state.rwtcsr |= 0xa500;
 	__raw_writew(sh7724_rstandby_state.rwtcsr & 0x07, 0xa4520004);
 
+	/* CPG */
+	sh7724_rstandby_state.irdaclk = __raw_readl(0xa4150018); /* IRDACLKCR */
+	sh7724_rstandby_state.spuclk = __raw_readl(0xa415003c); /* SPUCLKCR */
+
 	return NOTIFY_DONE;
 }
 
@@ -1052,6 +1059,10 @@ static int sh7724_post_sleep_notifier_ca
 	__raw_writew(sh7724_rstandby_state.rwtcnt, 0xa4520000); /* RWTCNT */
 	__raw_writew(sh7724_rstandby_state.rwtcsr, 0xa4520004); /* RWTCSR */
 
+	/* CPG */
+	__raw_writel(sh7724_rstandby_state.irdaclk, 0xa4150018); /* IRDACLKCR */
+	__raw_writel(sh7724_rstandby_state.spuclk, 0xa415003c); /* SPUCLKCR */
+
 	return NOTIFY_DONE;
 }
 
