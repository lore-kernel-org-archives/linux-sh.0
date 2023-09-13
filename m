Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CEDCA5520
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 09:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239238AbjIMJYN (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 05:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjIMJYL (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 05:24:11 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994671993
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 02:24:05 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-2.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 3bf958c2-f012-45c0-b07e-c64b3eac1f73;
        Wed, 13 Sep 2023 18:24:03 +0900 (JST)
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id C1BD71C0371;
        Wed, 13 Sep 2023 18:24:02 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RFC PATCH v2 05/30] arch/sh: setup.c update DeviceTree support.
Date:   Wed, 13 Sep 2023 18:23:30 +0900
Message-Id: <9ede23c8ca6239b449d2e505274def268a07bd86.1694596125.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1694596125.git.ysato@users.sourceforge.jp>
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

- Get CPU clock frequency for DeviceTree.
- Clean up fdt initialization.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/kernel/setup.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index b3da2757faaf..95628ecc41c8 100644
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
 
+#if !defined(CONFIG_OF) || defined(USE_BUILTIN_DTB)
 static char __initdata command_line[COMMAND_LINE_SIZE] = { 0, };
+#endif
 
 static struct resource code_resource = {
 	.name = "Kernel code",
@@ -104,6 +107,8 @@ unsigned long memory_limit = 0;
 
 static struct resource mem_resources[MAX_NUMNODES];
 
+static void *dt_virt;
+
 int l1i_cache_shape, l1d_cache_shape, l2_cache_shape;
 
 static int __init early_parse_mem(char *p)
@@ -180,7 +185,12 @@ void __init check_for_initrd(void)
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
@@ -249,7 +259,6 @@ void __init __weak plat_early_device_setup(void)
 void __ref sh_fdt_init(phys_addr_t dt_phys)
 {
 	static int done = 0;
-	void *dt_virt;
 
 	/* Avoid calling an __init function on secondary cpus. */
 	if (done) return;
@@ -274,8 +283,18 @@ void __ref sh_fdt_init(phys_addr_t dt_phys)
 
 void __init setup_arch(char **cmdline_p)
 {
+#ifdef CONFIG_OF
+#ifdef CONFIG_USE_BUILTIN_DTB
+	unflatten_and_copy_device_tree();
+#else
+	memblock_reserve(__pa(dt_virt), fdt_totalsize(dt_virt));
+	unflatten_device_tree();
+#endif
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
 
@@ -327,14 +351,6 @@ void __init setup_arch(char **cmdline_p)
 	/* Let earlyprintk output early console messages */
 	sh_early_platform_driver_probe("earlyprintk", 1, 1);
 
-#ifdef CONFIG_OF_EARLY_FLATTREE
-#ifdef CONFIG_USE_BUILTIN_DTB
-	unflatten_and_copy_device_tree();
-#else
-	unflatten_device_tree();
-#endif
-#endif
-
 	paging_init();
 
 	/* Perform the machine specific initialisation */
-- 
2.39.2

