Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42728C83F14
	for <linux-sh@archiver.kernel.org>; Thu, 31 Aug 2023 01:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244827AbjHaBMN (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 30 Aug 2023 21:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjHaBMM (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 30 Aug 2023 21:12:12 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E55ECC2
        for <linux-sh@vger.kernel.org>; Wed, 30 Aug 2023 18:12:07 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-0.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 3679d02a-b39c-4d9a-8df0-cc78b569a8cb;
        Thu, 31 Aug 2023 10:12:06 +0900 (JST)
Received: from SIOS1075.flets-east.jp (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id 445EE1C0246;
        Thu, 31 Aug 2023 10:12:05 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RESEND RFC PATCH 02/12] sh: Update OF handling.
Date:   Thu, 31 Aug 2023 10:11:49 +0900
Message-Id: <184764e337b9fea92bed4576d776118984e31f38.1693444193.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1693444193.git.ysato@users.sourceforge.jp>
References: <cover.1693444193.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

- avoid build warning.
- reserve external dtb area.
- use generic interfaces on internal peripheral driver.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/boards/of-generic.c       | 28 +++++++++++++++++++++++++---
 arch/sh/boot/compressed/head_32.S |  5 +++--
 arch/sh/kernel/head_32.S          |  2 +-
 arch/sh/kernel/setup.c            | 26 +++++++++++++++++++++++++-
 4 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index f7f3e618e85b..ff4643b3deee 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -8,6 +8,7 @@
 #include <linux/of.h>
 #include <linux/of_clk.h>
 #include <linux/of_fdt.h>
+#include <linux/of_platform.h>
 #include <linux/clocksource.h>
 #include <linux/irqchip.h>
 #include <asm/machvec.h>
@@ -107,7 +108,7 @@ static int noopi(void)
 	return 0;
 }
 
-static void __init sh_of_mem_reserve(void)
+static void __init sh_of_mem_init(void)
 {
 	early_init_fdt_reserve_self();
 	early_init_fdt_scan_reserved_mem();
@@ -116,6 +117,8 @@ static void __init sh_of_mem_reserve(void)
 static void __init sh_of_setup(char **cmdline_p)
 {
 	struct device_node *root;
+	struct device_node *cpu;
+	int freq;
 
 	sh_mv.mv_name = "Unknown SH model";
 	root = of_find_node_by_path("/");
@@ -125,6 +128,9 @@ static void __init sh_of_setup(char **cmdline_p)
 	}
 
 	sh_of_smp_probe();
+	cpu = of_find_node_by_name(NULL, "cpu");
+	if (!of_property_read_u32(cpu, "clock-frequency", &freq))
+		preset_lpj = freq / 500;
 }
 
 static int sh_of_irq_demux(int irq)
@@ -157,8 +163,7 @@ static struct sh_machine_vector __initmv sh_of_generic_mv = {
 	.mv_init_irq	= sh_of_init_irq,
 	.mv_clk_init	= sh_of_clk_init,
 	.mv_mode_pins	= noopi,
-	.mv_mem_init	= noop,
-	.mv_mem_reserve	= sh_of_mem_reserve,
+	.mv_mem_init	= sh_of_mem_init,
 };
 
 struct sh_clk_ops;
@@ -170,3 +175,20 @@ void __init __weak arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
 void __init __weak plat_irq_setup(void)
 {
 }
+
+static int __init sh_of_device_init(void)
+{
+	pr_info("SH generic board support: populating platform devices\n");
+	if (of_have_populated_dt()) {
+		of_platform_populate(NULL, of_default_bus_match_table,
+				     NULL, NULL);
+	} else {
+		pr_crit("Device tree not populated\n");
+	}
+	return 0;
+}
+arch_initcall_sync(sh_of_device_init);
+
+void intc_finalize(void)
+{
+}
diff --git a/arch/sh/boot/compressed/head_32.S b/arch/sh/boot/compressed/head_32.S
index 7bb168133dbb..c5227ef636c3 100644
--- a/arch/sh/boot/compressed/head_32.S
+++ b/arch/sh/boot/compressed/head_32.S
@@ -15,7 +15,8 @@ startup:
 	/* Load initial status register */
 	mov.l   init_sr, r1
 	ldc     r1, sr
-
+	/* Save FDT address */
+	mov	r4, r13
 	/* Move myself to proper location if necessary */
 	mova	1f, r0
 	mov.l	1f, r2
@@ -84,7 +85,7 @@ l1:
 	/* Jump to the start of the decompressed kernel */
 	mov.l	kernel_start_addr, r0
 	jmp	@r0
-	nop
+	  mov	r13,r4
 	
 	.align	2
 bss_start_addr:
diff --git a/arch/sh/kernel/head_32.S b/arch/sh/kernel/head_32.S
index b603b7968b38..28cd8806f67c 100644
--- a/arch/sh/kernel/head_32.S
+++ b/arch/sh/kernel/head_32.S
@@ -56,7 +56,7 @@ ENTRY(empty_zero_page)
  */
 ENTRY(_stext)
 	!			Initialize Status Register
-	mov.l	1f, r0		! MD=1, RB=0, BL=0, IMASK=0xF
+	mov.l	1f, r0		! MD=1, RB=0, BL=1, IMASK=0xF
 	ldc	r0, sr
 	!			Initialize global interrupt mask
 #ifdef CONFIG_CPU_HAS_SR_RB
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index b3da2757faaf..8389b673f2e8 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -31,6 +31,7 @@
 #include <linux/memblock.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
+#include <linux/libfdt.h>
 #include <linux/uaccess.h>
 #include <uapi/linux/mount.h>
 #include <asm/io.h>
@@ -79,7 +80,9 @@ extern int root_mountflags;
 #define RAMDISK_PROMPT_FLAG		0x8000
 #define RAMDISK_LOAD_FLAG		0x4000
 
+#ifndef CONFIG_OF
 static char __initdata command_line[COMMAND_LINE_SIZE] = { 0, };
+#endif
 
 static struct resource code_resource = {
 	.name = "Kernel code",
@@ -104,6 +107,10 @@ unsigned long memory_limit = 0;
 
 static struct resource mem_resources[MAX_NUMNODES];
 
+#if defined(CONFIG_OF)
+static void *dt_virt;
+#endif
+
 int l1i_cache_shape, l1d_cache_shape, l2_cache_shape;
 
 static int __init early_parse_mem(char *p)
@@ -180,7 +187,12 @@ void __init check_for_initrd(void)
 #ifndef CONFIG_GENERIC_CALIBRATE_DELAY
 void calibrate_delay(void)
 {
+#ifndef CONFIG_OF
 	struct clk *clk = clk_get(NULL, "cpu_clk");
+#else
+	struct device_node *cpu = of_find_node_by_name(NULL, "cpu");
+	struct clk *clk = of_clk_get_by_name(cpu, NULL);
+#endif
 
 	if (IS_ERR(clk))
 		panic("Need a sane CPU clock definition!");
@@ -249,7 +261,6 @@ void __init __weak plat_early_device_setup(void)
 void __ref sh_fdt_init(phys_addr_t dt_phys)
 {
 	static int done = 0;
-	void *dt_virt;
 
 	/* Avoid calling an __init function on secondary cpus. */
 	if (done) return;
@@ -274,8 +285,16 @@ void __ref sh_fdt_init(phys_addr_t dt_phys)
 
 void __init setup_arch(char **cmdline_p)
 {
+#ifdef CONFIG_OF
+#ifndef CONFIG_USE_BUILTIN_DTB
+	memblock_reserve(__pa(dt_virt), fdt_totalsize(dt_virt));
+#endif
+	unflatten_device_tree();
+#endif
 	enable_mmu();
 
+
+#ifndef CONFIG_OF
 	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
 
 	printk(KERN_NOTICE "Boot params:\n"
@@ -313,10 +332,15 @@ void __init setup_arch(char **cmdline_p)
 	strlcat(command_line, CONFIG_CMDLINE, sizeof(command_line));
 #endif
 #endif
+#endif
 
+#if !defined(CONFIG_OF) || defined(USE_BUILTIN_DTB)
 	/* Save unparsed command line copy for /proc/cmdline */
 	memcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
+#else
+	*cmdline_p = boot_command_line;
+#endif
 
 	parse_early_param();
 
-- 
2.39.2

