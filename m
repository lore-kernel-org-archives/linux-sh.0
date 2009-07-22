From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 22 Jul 2009 15:26:42 +0000
Subject: [PATCH] sh: allow board specific code in the zImage loader
Message-Id: <20090722152642.18607.21007.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch simply adds code to allow board specific
assembly setup code in the zImage boot loader.

Boards that support this mode should allow the user to
enable this by selecting SYS_SUPPORTS_ZIMAGE_BOOT_LOADER.

If SYS_SUPPORTS_ZIMAGE_BOOT_LOADER is selected then the
board specific assembly file must be pointed out with
ZIMAGE_BOOT_LOADER_FILE.

The user can then use CONFIG_ZIMAGE_BOOT_LOADER to enable
or disable board specific code in the zImage.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                   |   15 +++++++++++++++
 arch/sh/boot/compressed/head_32.S |    3 +++
 2 files changed, 18 insertions(+)

--- 0001/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2009-07-22 18:17:56.000000000 +0900
@@ -139,6 +139,9 @@ config SYS_SUPPORTS_MTU2
 config SYS_SUPPORTS_TMU
 	bool
 
+config SYS_SUPPORTS_ZIMAGE_BOOT_LOADER
+	bool
+
 config STACKTRACE_SUPPORT
 	def_bool y
 
@@ -766,6 +769,18 @@ config CMDLINE
 	depends on CMDLINE_BOOL
 	default "console=ttySC1,115200"
 
+config ZIMAGE_BOOT_LOADER_FILE
+	string
+	depends on ZIMAGE_BOOT_LOADER
+
+config ZIMAGE_BOOT_LOADER
+	bool "Use zImage as boot loader"
+	depends on SYS_SUPPORTS_ZIMAGE_BOOT_LOADER
+	help
+	  This option enables board specific code in the zImage boot loader.
+
+	  If unsure, say N.
+
 endmenu
 
 menu "Bus options"
--- 0001/arch/sh/boot/compressed/head_32.S
+++ work/arch/sh/boot/compressed/head_32.S	2009-07-22 18:16:12.000000000 +0900
@@ -11,6 +11,9 @@
 
 	.global	startup
 startup:
+#ifdef CONFIG_ZIMAGE_BOOT_LOADER
+#include CONFIG_ZIMAGE_BOOT_LOADER_FILE
+#endif
 	/* Load initial status register */
 	mov.l   init_sr, r1
 	ldc     r1, sr
