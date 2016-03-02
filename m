From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 02 Mar 2016 01:43:07 +0000
Subject: [PATCH] drivers: sh: Use ARCH_RENESAS
Message-Id: <1456882987-4502-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.

This is part of an ongoing process to migrate from ARCH_SHMOBILE to
ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.

ARCH_RENESAS should cover all cases where both CONFIG_OF and
ARCH_SHMOBILE are enabled.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/sh/pm_runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

 Based on v4.5-rc6

diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index a9bac3bf20de..aa2ce227e3eb 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -34,7 +34,7 @@ static struct pm_clk_notifier_block platform_bus_notifier = {
 
 static int __init sh_pm_runtime_init(void)
 {
-	if (IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_ARCH_SHMOBILE)) {
+	if (IS_ENABLED(CONFIG_ARCH_RENESAS)) {
 		if (!of_find_compatible_node(NULL, NULL,
 					     "renesas,cpg-mstp-clocks"))
 			return 0;
-- 
2.1.4

