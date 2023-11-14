Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68042C4167D
	for <linux-sh@archiver.kernel.org>; Tue, 14 Nov 2023 08:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjKNIAr (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Nov 2023 03:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjKNIAp (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Nov 2023 03:00:45 -0500
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D11AB19E
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 00:00:42 -0800 (PST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id C0C671C03F8;
        Tue, 14 Nov 2023 17:00:41 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v4 06/37] sh: kernel/setup Update DT support.
Date:   Tue, 14 Nov 2023 16:59:57 +0900
Message-Id: <65013d2dc41a9ce13bcd159d7cc5d267c6e90a67.1699856600.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1699856600.git.ysato@users.sourceforge.jp>
References: <cover.1699856600.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Fix extrnal fdt initialize and bootargs.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/kernel/setup.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 3d80515298d2..62b049ce586f 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -30,6 +30,7 @@
 #include <linux/memblock.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
+#include <linux/libfdt.h>
 #include <linux/uaccess.h>
 #include <uapi/linux/mount.h>
 #include <asm/io.h>
@@ -74,7 +75,13 @@ extern int root_mountflags;
 #define RAMDISK_PROMPT_FLAG		0x8000
 #define RAMDISK_LOAD_FLAG		0x4000
 
+#if defined(CONFIG_OF) && !defined(CONFIG_USE_BUILTIN_DTB)
+#define CHOSEN_BOOTARGS
+#endif
+
+#ifndef CHOSEN_BOOTARGS
 static char __initdata command_line[COMMAND_LINE_SIZE] = { 0, };
+#endif
 
 static struct resource code_resource = {
 	.name = "Kernel code",
@@ -99,6 +106,8 @@ unsigned long memory_limit = 0;
 
 static struct resource mem_resources[MAX_NUMNODES];
 
+static void *dt_virt;
+
 int l1i_cache_shape, l1d_cache_shape, l2_cache_shape;
 
 static int __init early_parse_mem(char *p)
@@ -244,7 +253,6 @@ void __init __weak plat_early_device_setup(void)
 void __ref sh_fdt_init(phys_addr_t dt_phys)
 {
 	static int done = 0;
-	void *dt_virt;
 
 	/* Avoid calling an __init function on secondary cpus. */
 	if (done) return;
@@ -269,8 +277,17 @@ void __ref sh_fdt_init(phys_addr_t dt_phys)
 
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
 
+#ifndef CONFIG_OF
 	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
 
 	printk(KERN_NOTICE "Boot params:\n"
@@ -299,6 +316,9 @@ void __init setup_arch(char **cmdline_p)
 	bss_resource.start = virt_to_phys(__bss_start);
 	bss_resource.end = virt_to_phys(__bss_stop)-1;
 
+#endif
+
+#ifndef CHOSEN_BOOTARGS
 #ifdef CONFIG_CMDLINE_OVERWRITE
 	strscpy(command_line, CONFIG_CMDLINE, sizeof(command_line));
 #else
@@ -307,11 +327,13 @@ void __init setup_arch(char **cmdline_p)
 	strlcat(command_line, " ", sizeof(command_line));
 	strlcat(command_line, CONFIG_CMDLINE, sizeof(command_line));
 #endif
-#endif
-
+#endif  /* CONFIG_CMDLINE_OVERWRITE */
 	/* Save unparsed command line copy for /proc/cmdline */
 	memcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
+#else
+	*cmdline_p = boot_command_line;
+#endif
 
 	parse_early_param();
 
@@ -322,14 +344,6 @@ void __init setup_arch(char **cmdline_p)
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

