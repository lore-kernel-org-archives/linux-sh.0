From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 03 Jul 2016 16:46:25 +0000
Subject: [PATCH v5 05/22] sh: command line passing chosen/bootargs in devicetree
Message-Id: <1467564402-2649-6-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/kernel/setup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 8e3b099..bdf57e5 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -280,6 +280,7 @@ void __init setup_arch(char **cmdline_p)
 #endif
 	enable_mmu();
 
+#ifndef CONFIG_OF
 	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
 
 	printk(KERN_NOTICE "Boot params:\n"
@@ -301,6 +302,7 @@ void __init setup_arch(char **cmdline_p)
 
 	if (!MOUNT_ROOT_RDONLY)
 		root_mountflags &= ~MS_RDONLY;
+#endif
 	init_mm.start_code = (unsigned long) _text;
 	init_mm.end_code = (unsigned long) _etext;
 	init_mm.end_data = (unsigned long) _edata;
@@ -323,9 +325,13 @@ void __init setup_arch(char **cmdline_p)
 #endif
 #endif
 
+#if !defined(CONFIG_OF) || defined(CONFIG_USE_BUILTIN_DTB)
 	/* Save unparsed command line copy for /proc/cmdline */
 	memcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
+#else
+	*cmdline_p = boot_command_line;
+#endif
 
 	parse_early_param();
 
-- 
2.7.0

