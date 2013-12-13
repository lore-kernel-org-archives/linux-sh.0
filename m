From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 13 Dec 2013 00:10:38 +0000
Subject: [PATCH] sh: Add EXPORT_SYMBOL(min_low_pfn) and EXPORT_SYMBOL(max_low_pfn) to sh_ksyms_32.c
Message-Id: <1386893438-23573-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Min_low_pfn and max_low_pfn were used in pfn_valid macro if defined
CONFIG_FLATMEM. When the functions that use the pfn_valid is used in driver
module, max_low_pfn and min_low_pfn is to undefined, and fail to build.

----
ERROR: "min_low_pfn" [drivers/block/aoe/aoe.ko] undefined!
ERROR: "max_low_pfn" [drivers/block/aoe/aoe.ko] undefined!
make[2]: *** [__modpost] Error 1
make[1]: *** [modules] Error 2
----

This patch fix this problem.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/kernel/sh_ksyms_32.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/sh/kernel/sh_ksyms_32.c b/arch/sh/kernel/sh_ksyms_32.c
index 2a0a596..a7d3b1b 100644
--- a/arch/sh/kernel/sh_ksyms_32.c
+++ b/arch/sh/kernel/sh_ksyms_32.c
@@ -20,6 +20,11 @@ EXPORT_SYMBOL(csum_partial_copy_generic);
 EXPORT_SYMBOL(copy_page);
 EXPORT_SYMBOL(__clear_user);
 EXPORT_SYMBOL(empty_zero_page);
+#ifdef CONFIG_FLATMEM
+/* need in pfn_valid macro */
+EXPORT_SYMBOL(min_low_pfn);
+EXPORT_SYMBOL(max_low_pfn);
+#endif
 
 #define DECLARE_EXPORT(name)		\
 	extern void name(void);EXPORT_SYMBOL(name)
-- 
1.8.5.1

