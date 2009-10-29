From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 29 Oct 2009 10:51:57 +0000
Subject: [PATCH 03/07] sh: Add sh7724 notifier for R-standby save/restore
Message-Id: <20091029105157.29078.32745.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Make use of the recently added notifier chains for sh7724
r-standby register save/restore handling. At this point
only the BSC and INTC are handled.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |  167 ++++++++++++++++++++++++++++++++
 1 file changed, 167 insertions(+)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7724.c	2009-10-28 23:15:33.000000000 +0900
@@ -20,6 +20,8 @@
 #include <linux/uio_driver.h>
 #include <linux/sh_timer.h>
 #include <linux/io.h>
+#include <linux/notifier.h>
+#include <asm/suspend.h>
 #include <asm/clock.h>
 #include <asm/mmzone.h>
 #include <cpu/sh7724.h>
@@ -827,3 +829,168 @@ void __init plat_irq_setup(void)
 {
 	register_intc_controller(&intc_desc);
 }
+
+static struct {
+	/* BSC */
+	unsigned long mmselr;
+	unsigned long cs0bcr;
+	unsigned long cs4bcr;
+	unsigned long cs5abcr;
+	unsigned long cs5bbcr;
+	unsigned long cs6abcr;
+	unsigned long cs6bbcr;
+	unsigned long cs4wcr;
+	unsigned long cs5awcr;
+	unsigned long cs5bwcr;
+	unsigned long cs6awcr;
+	unsigned long cs6bwcr;
+	/* INTC */
+	unsigned short ipra;
+	unsigned short iprb;
+	unsigned short iprc;
+	unsigned short iprd;
+	unsigned short ipre;
+	unsigned short iprf;
+	unsigned short iprg;
+	unsigned short iprh;
+	unsigned short ipri;
+	unsigned short iprj;
+	unsigned short iprk;
+	unsigned short iprl;
+	unsigned char imr0;
+	unsigned char imr1;
+	unsigned char imr2;
+	unsigned char imr3;
+	unsigned char imr4;
+	unsigned char imr5;
+	unsigned char imr6;
+	unsigned char imr7;
+	unsigned char imr8;
+	unsigned char imr9;
+	unsigned char imr10;
+	unsigned char imr11;
+	unsigned char imr12;
+} sh7724_rstandby_state;
+
+static int sh7724_pre_sleep_notifier_call(struct notifier_block *nb,
+					  unsigned long flags, void *unused)
+{
+	if (!(flags & SUSP_SH_RSTANDBY))
+		return NOTIFY_DONE;
+
+	/* BCR */
+	sh7724_rstandby_state.mmselr = __raw_readl(0xff800020); /* MMSELR */
+	sh7724_rstandby_state.mmselr |= 0xa5a50000;
+	sh7724_rstandby_state.cs0bcr = __raw_readl(0xfec10004); /* CS0BCR */
+	sh7724_rstandby_state.cs4bcr = __raw_readl(0xfec10010); /* CS4BCR */
+	sh7724_rstandby_state.cs5abcr = __raw_readl(0xfec10014); /* CS5ABCR */
+	sh7724_rstandby_state.cs5bbcr = __raw_readl(0xfec10018); /* CS5BBCR */
+	sh7724_rstandby_state.cs6abcr = __raw_readl(0xfec1001c); /* CS6ABCR */
+	sh7724_rstandby_state.cs6bbcr = __raw_readl(0xfec10020); /* CS6BBCR */
+	sh7724_rstandby_state.cs4wcr = __raw_readl(0xfec10030); /* CS4WCR */
+	sh7724_rstandby_state.cs5awcr = __raw_readl(0xfec10034); /* CS5AWCR */
+	sh7724_rstandby_state.cs5bwcr = __raw_readl(0xfec10038); /* CS5BWCR */
+	sh7724_rstandby_state.cs6awcr = __raw_readl(0xfec1003c); /* CS6AWCR */
+	sh7724_rstandby_state.cs6bwcr = __raw_readl(0xfec10040); /* CS6BWCR */
+
+	/* INTC */
+	sh7724_rstandby_state.ipra = __raw_readw(0xa4080000); /* IPRA */
+	sh7724_rstandby_state.iprb = __raw_readw(0xa4080004); /* IPRB */
+	sh7724_rstandby_state.iprc = __raw_readw(0xa4080008); /* IPRC */
+	sh7724_rstandby_state.iprd = __raw_readw(0xa408000c); /* IPRD */
+	sh7724_rstandby_state.ipre = __raw_readw(0xa4080010); /* IPRE */
+	sh7724_rstandby_state.iprf = __raw_readw(0xa4080014); /* IPRF */
+	sh7724_rstandby_state.iprg = __raw_readw(0xa4080018); /* IPRG */
+	sh7724_rstandby_state.iprh = __raw_readw(0xa408001c); /* IPRH */
+	sh7724_rstandby_state.ipri = __raw_readw(0xa4080020); /* IPRI */
+	sh7724_rstandby_state.iprj = __raw_readw(0xa4080024); /* IPRJ */
+	sh7724_rstandby_state.iprk = __raw_readw(0xa4080028); /* IPRK */
+	sh7724_rstandby_state.iprl = __raw_readw(0xa408002c); /* IPRL */
+	sh7724_rstandby_state.imr0 = __raw_readb(0xa4080080); /* IMR0 */
+	sh7724_rstandby_state.imr1 = __raw_readb(0xa4080084); /* IMR1 */
+	sh7724_rstandby_state.imr2 = __raw_readb(0xa4080088); /* IMR2 */
+	sh7724_rstandby_state.imr3 = __raw_readb(0xa408008c); /* IMR3 */
+	sh7724_rstandby_state.imr4 = __raw_readb(0xa4080090); /* IMR4 */
+	sh7724_rstandby_state.imr5 = __raw_readb(0xa4080094); /* IMR5 */
+	sh7724_rstandby_state.imr6 = __raw_readb(0xa4080098); /* IMR6 */
+	sh7724_rstandby_state.imr7 = __raw_readb(0xa408009c); /* IMR7 */
+	sh7724_rstandby_state.imr8 = __raw_readb(0xa40800a0); /* IMR8 */
+	sh7724_rstandby_state.imr9 = __raw_readb(0xa40800a4); /* IMR9 */
+	sh7724_rstandby_state.imr10 = __raw_readb(0xa40800a8); /* IMR10 */
+	sh7724_rstandby_state.imr11 = __raw_readb(0xa40800ac); /* IMR11 */
+	sh7724_rstandby_state.imr12 = __raw_readb(0xa40800b0); /* IMR12 */
+
+	return NOTIFY_DONE;
+}
+
+static int sh7724_post_sleep_notifier_call(struct notifier_block *nb,
+					   unsigned long flags, void *unused)
+{
+	if (!(flags & SUSP_SH_RSTANDBY))
+		return NOTIFY_DONE;
+
+	/* BCR */
+	__raw_writel(sh7724_rstandby_state.mmselr, 0xff800020); /* MMSELR */
+	__raw_writel(sh7724_rstandby_state.cs0bcr, 0xfec10004); /* CS0BCR */
+	__raw_writel(sh7724_rstandby_state.cs4bcr, 0xfec10010); /* CS4BCR */
+	__raw_writel(sh7724_rstandby_state.cs5abcr, 0xfec10014); /* CS5ABCR */
+	__raw_writel(sh7724_rstandby_state.cs5bbcr, 0xfec10018); /* CS5BBCR */
+	__raw_writel(sh7724_rstandby_state.cs6abcr, 0xfec1001c); /* CS6ABCR */
+	__raw_writel(sh7724_rstandby_state.cs6bbcr, 0xfec10020); /* CS6BBCR */
+	__raw_writel(sh7724_rstandby_state.cs4wcr, 0xfec10030); /* CS4WCR */
+	__raw_writel(sh7724_rstandby_state.cs5awcr, 0xfec10034); /* CS5AWCR */
+	__raw_writel(sh7724_rstandby_state.cs5bwcr, 0xfec10038); /* CS5BWCR */
+	__raw_writel(sh7724_rstandby_state.cs6awcr, 0xfec1003c); /* CS6AWCR */
+	__raw_writel(sh7724_rstandby_state.cs6bwcr, 0xfec10040); /* CS6BWCR */
+
+	/* INTC */
+	__raw_writew(sh7724_rstandby_state.ipra, 0xa4080000); /* IPRA */
+	__raw_writew(sh7724_rstandby_state.iprb, 0xa4080004); /* IPRB */
+	__raw_writew(sh7724_rstandby_state.iprc, 0xa4080008); /* IPRC */
+	__raw_writew(sh7724_rstandby_state.iprd, 0xa408000c); /* IPRD */
+	__raw_writew(sh7724_rstandby_state.ipre, 0xa4080010); /* IPRE */
+	__raw_writew(sh7724_rstandby_state.iprf, 0xa4080014); /* IPRF */
+	__raw_writew(sh7724_rstandby_state.iprg, 0xa4080018); /* IPRG */
+	__raw_writew(sh7724_rstandby_state.iprh, 0xa408001c); /* IPRH */
+	__raw_writew(sh7724_rstandby_state.ipri, 0xa4080020); /* IPRI */
+	__raw_writew(sh7724_rstandby_state.iprj, 0xa4080024); /* IPRJ */
+	__raw_writew(sh7724_rstandby_state.iprk, 0xa4080028); /* IPRK */
+	__raw_writew(sh7724_rstandby_state.iprl, 0xa408002c); /* IPRL */
+	__raw_writeb(sh7724_rstandby_state.imr0, 0xa4080080); /* IMR0 */
+	__raw_writeb(sh7724_rstandby_state.imr1, 0xa4080084); /* IMR1 */
+	__raw_writeb(sh7724_rstandby_state.imr2, 0xa4080088); /* IMR2 */
+	__raw_writeb(sh7724_rstandby_state.imr3, 0xa408008c); /* IMR3 */
+	__raw_writeb(sh7724_rstandby_state.imr4, 0xa4080090); /* IMR4 */
+	__raw_writeb(sh7724_rstandby_state.imr5, 0xa4080094); /* IMR5 */
+	__raw_writeb(sh7724_rstandby_state.imr6, 0xa4080098); /* IMR6 */
+	__raw_writeb(sh7724_rstandby_state.imr7, 0xa408009c); /* IMR7 */
+	__raw_writeb(sh7724_rstandby_state.imr8, 0xa40800a0); /* IMR8 */
+	__raw_writeb(sh7724_rstandby_state.imr9, 0xa40800a4); /* IMR9 */
+	__raw_writeb(sh7724_rstandby_state.imr10, 0xa40800a8); /* IMR10 */
+	__raw_writeb(sh7724_rstandby_state.imr11, 0xa40800ac); /* IMR11 */
+	__raw_writeb(sh7724_rstandby_state.imr12, 0xa40800b0); /* IMR12 */
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block sh7724_pre_sleep_notifier = {
+	.notifier_call = sh7724_pre_sleep_notifier_call,
+	.priority = SH_MOBILE_PRE(SH_MOBILE_SLEEP_CPU),
+};
+
+static struct notifier_block sh7724_post_sleep_notifier = {
+	.notifier_call = sh7724_post_sleep_notifier_call,
+	.priority = SH_MOBILE_POST(SH_MOBILE_SLEEP_CPU),
+};
+
+static int __init sh7724_sleep_setup(void)
+{
+	atomic_notifier_chain_register(&sh_mobile_pre_sleep_notifier_list,
+				       &sh7724_pre_sleep_notifier);
+
+	atomic_notifier_chain_register(&sh_mobile_post_sleep_notifier_list,
+				       &sh7724_post_sleep_notifier);
+	return 0;
+}
+arch_initcall(sh7724_sleep_setup);
+
