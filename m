Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E1DC4332F
	for <linux-sh@archiver.kernel.org>; Tue, 14 Nov 2023 08:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjKNIAq (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Nov 2023 03:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjKNIAp (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Nov 2023 03:00:45 -0500
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1150195
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 00:00:41 -0800 (PST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id C58F41C03C1;
        Tue, 14 Nov 2023 17:00:40 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 05/37] sh: GENERIC_IRQ_CHIP support for CONFIG_OF=y
Date:   Tue, 14 Nov 2023 16:59:56 +0900
Message-Id: <e2f40366c157cdb76e1ec8693b6bfc08bdcdf159.1699856600.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1699856600.git.ysato@users.sourceforge.jp>
References: <cover.1699856600.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Remove unused function prototype.
Add helper update_sr_imask. use for SH7751 irq driver.
Add stub intc_finalize.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/include/asm/irq.h      | 10 ++++++++--
 arch/sh/kernel/cpu/Makefile    |  5 +----
 arch/sh/kernel/cpu/irq/imask.c | 17 +++++++++++++++++
 include/linux/sh_intc.h        |  7 ++++++-
 4 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/arch/sh/include/asm/irq.h b/arch/sh/include/asm/irq.h
index 0f384b1f45ca..c3e3db793dba 100644
--- a/arch/sh/include/asm/irq.h
+++ b/arch/sh/include/asm/irq.h
@@ -16,8 +16,8 @@
 /*
  * Simple Mask Register Support
  */
-extern void make_maskreg_irq(unsigned int irq);
-extern unsigned short *irq_mask_register;
+
+void update_sr_imask(unsigned int irq, unsigned int enable);
 
 /*
  * PINT IRQs
@@ -54,4 +54,10 @@ extern void irq_finish(unsigned int irq);
 
 #include <asm-generic/irq.h>
 
+/* SH3/4 INTC stuff */
+/* IRL level 0 - 15 */
+#define NR_IRL 15
+/* IRL0 -> IRQ16 */
+#define IRL_BASE_IRQ	16
+
 #endif /* __ASM_SH_IRQ_H */
diff --git a/arch/sh/kernel/cpu/Makefile b/arch/sh/kernel/cpu/Makefile
index e00ebf134985..ad12807fae9c 100644
--- a/arch/sh/kernel/cpu/Makefile
+++ b/arch/sh/kernel/cpu/Makefile
@@ -20,7 +20,4 @@ ifndef CONFIG_COMMON_CLK
 obj-y += clock.o
 obj-$(CONFIG_SH_CLK_CPG_LEGACY)	+= clock-cpg.o
 endif
-ifndef CONFIG_GENERIC_IRQ_CHIP
-obj-y	+= irq/
-endif
-obj-y	+= init.o fpu.o pfc.o proc.o
+obj-y	+= init.o fpu.o pfc.o proc.o irq/
diff --git a/arch/sh/kernel/cpu/irq/imask.c b/arch/sh/kernel/cpu/irq/imask.c
index 572585c3f2fd..d9a703715228 100644
--- a/arch/sh/kernel/cpu/irq/imask.c
+++ b/arch/sh/kernel/cpu/irq/imask.c
@@ -51,6 +51,7 @@ static inline void set_interrupt_registers(int ip)
 		     : "t");
 }
 
+#ifndef CONFIG_GENERIC_IRQ_CHIP
 static void mask_imask_irq(struct irq_data *data)
 {
 	unsigned int irq = data->irq;
@@ -83,3 +84,19 @@ void make_imask_irq(unsigned int irq)
 	irq_set_chip_and_handler_name(irq, &imask_irq_chip, handle_level_irq,
 				      "level");
 }
+#else
+void update_sr_imask(unsigned int irq, unsigned int enable)
+{
+	if (enable) {
+		set_bit(irq, imask_mask);
+		interrupt_priority = IMASK_PRIORITY -
+		  find_first_bit(imask_mask, IMASK_PRIORITY);
+	} else {
+		clear_bit(irq, imask_mask);
+		if (interrupt_priority < IMASK_PRIORITY - irq)
+			interrupt_priority = IMASK_PRIORITY - irq;
+	}
+	set_interrupt_registers(interrupt_priority);
+}
+EXPORT_SYMBOL(update_sr_imask);
+#endif
diff --git a/include/linux/sh_intc.h b/include/linux/sh_intc.h
index 27ae79191bdc..994b5b05a0d7 100644
--- a/include/linux/sh_intc.h
+++ b/include/linux/sh_intc.h
@@ -139,8 +139,13 @@ struct intc_desc symbol __initdata = {					\
 int register_intc_controller(struct intc_desc *desc);
 int intc_set_priority(unsigned int irq, unsigned int prio);
 int intc_irq_lookup(const char *chipname, intc_enum enum_id);
+#ifndef CONFIG_SH_DEVICE_TREE
 void intc_finalize(void);
-
+#else
+static inline void intc_finalize(void)
+{
+}
+#endif
 #ifdef CONFIG_INTC_USERIMASK
 int register_intc_userimask(unsigned long addr);
 #else
-- 
2.39.2

