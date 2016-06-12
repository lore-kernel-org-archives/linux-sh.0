From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 12 Jun 2016 06:54:20 +0000
Subject: [PATCH v2 02/17] sh: More early unflatten device tree
Message-Id: <1465714475-24111-3-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1465714475-24111-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1465714475-24111-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

unflatten required MMU disabled.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/boards/of-generic.c | 6 ------
 arch/sh/kernel/setup.c      | 7 +++++++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index fe2d917..d24bc02 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -129,12 +129,6 @@ static void __init sh_of_setup(char **cmdline_p)
 {
 	struct device_node *root;
 
-#ifdef CONFIG_USE_BUILTIN_DTB
-	unflatten_and_copy_device_tree();
-#else
-	unflatten_device_tree();
-#endif
-
 	board_time_init = sh_of_time_init;
 
 	sh_mv.mv_name = "Unknown SH model";
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 5b9eb70..86f2792 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -271,6 +271,13 @@ void __ref sh_fdt_init(phys_addr_t dt_phys)
 
 void __init setup_arch(char **cmdline_p)
 {
+#ifdef CONFIG_OF
+#ifdef CONFIG_USE_BUILTIN_DTB
+	unflatten_and_copy_device_tree();
+#else
+	unflatten_device_tree();
+#endif
+#endif
 	enable_mmu();
 
 	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
-- 
2.7.0

