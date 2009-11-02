From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 02 Nov 2009 09:31:03 +0000
Subject: [PATCH] sh: Add RWDT save/restore code for sh7724 R-standby
Message-Id: <20091102093103.19544.17850.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add sh7724 code to save and restore RWDT state during
R-standby. Without this patch the watchdog will generate
a reset shortly after resuming from R-standby.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- 0003/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7724.c	2009-10-30 16:48:05.000000000 +0900
@@ -870,6 +870,9 @@ static struct {
 	unsigned char imr10;
 	unsigned char imr11;
 	unsigned char imr12;
+	/* RWDT */
+	unsigned short rwtcnt;
+	unsigned short rwtcsr;
 } sh7724_rstandby_state;
 
 static int sh7724_pre_sleep_notifier_call(struct notifier_block *nb,
@@ -920,6 +923,13 @@ static int sh7724_pre_sleep_notifier_cal
 	sh7724_rstandby_state.imr11 = __raw_readb(0xa40800ac); /* IMR11 */
 	sh7724_rstandby_state.imr12 = __raw_readb(0xa40800b0); /* IMR12 */
 
+	/* RWDT */
+	sh7724_rstandby_state.rwtcnt = __raw_readb(0xa4520000); /* RWTCNT */
+	sh7724_rstandby_state.rwtcnt |= 0x5a00;
+	sh7724_rstandby_state.rwtcsr = __raw_readb(0xa4520004); /* RWTCSR */
+	sh7724_rstandby_state.rwtcsr |= 0xa500;
+	__raw_writew(sh7724_rstandby_state.rwtcsr & 0x07, 0xa4520004);
+
 	return NOTIFY_DONE;
 }
 
@@ -970,6 +980,10 @@ static int sh7724_post_sleep_notifier_ca
 	__raw_writeb(sh7724_rstandby_state.imr11, 0xa40800ac); /* IMR11 */
 	__raw_writeb(sh7724_rstandby_state.imr12, 0xa40800b0); /* IMR12 */
 
+	/* RWDT */
+	__raw_writew(sh7724_rstandby_state.rwtcnt, 0xa4520000); /* RWTCNT */
+	__raw_writew(sh7724_rstandby_state.rwtcsr, 0xa4520004); /* RWTCSR */
+
 	return NOTIFY_DONE;
 }
 
