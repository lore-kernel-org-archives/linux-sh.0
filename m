From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 17 Sep 2015 09:00:30 +0000
Subject: [PATCH 2/2] drivers: sh: Disable PM runtime for multi-platform ARM with genpd
Message-Id: <cbc41d0a761bffb3166a413a3c77100a737c0cd7.1442480237.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1442480237.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1442480237.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms+renesas@verge.net.au>

From: Geert Uytterhoeven <geert+renesas@glider.be>

If the default PM Domain using PM_CLK is used for PM runtime, the real
Clock Domain cannot be registered from DT later.

Hence do not enable it when running a multi-platform kernel with genpd
support on R-Car or RZ.  The CPG/MSTP Clock Domain driver will take care
of PM runtime management of the module clocks.

Now most multi-platform ARM shmobile platforms (SH-Mobile, R-Mobile,
R-Car, RZ) use DT-based PM Domains to take care of PM runtime management
of the module clocks, simplify the platform logic by replacing the
explicit SoC checks by a single check for the presence of MSTP clocks in
DT.

Backwards-compatiblity with old DTs (mainly for R-Car Gen2) is provided
by checking for the presence of a "#power-domain-cells" property in DT.

The default PM Domain is still needed for:
  - backwards-compatibility with old DTs that lack PM Domain properties,
  - the CONFIG_PM=n case,
  - legacy (non-DT) ARM/shmobile platforms without genpd support
    (r8a7778, r8a7779),
  - legacy SuperH.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/sh/pm_runtime.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index ad9188138ed5..25abd4eb7d10 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -35,19 +35,11 @@ static struct pm_clk_notifier_block platform_bus_notifier = {
 static int __init sh_pm_runtime_init(void)
 {
 	if (IS_ENABLED(CONFIG_ARCH_SHMOBILE_MULTI)) {
-		if (!of_machine_is_compatible("renesas,r7s72100") &&
-#ifndef CONFIG_PM_GENERIC_DOMAINS_OF
-		    !of_machine_is_compatible("renesas,r8a73a4") &&
-		    !of_machine_is_compatible("renesas,r8a7740") &&
-		    !of_machine_is_compatible("renesas,sh73a0") &&
-#endif
-		    !of_machine_is_compatible("renesas,r8a7778") &&
-		    !of_machine_is_compatible("renesas,r8a7779") &&
-		    !of_machine_is_compatible("renesas,r8a7790") &&
-		    !of_machine_is_compatible("renesas,r8a7791") &&
-		    !of_machine_is_compatible("renesas,r8a7792") &&
-		    !of_machine_is_compatible("renesas,r8a7793") &&
-		    !of_machine_is_compatible("renesas,r8a7794"))
+		if (!of_find_compatible_node(NULL, NULL,
+					     "renesas,cpg-mstp-clocks"))
+			return 0;
+		if (IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS_OF) &&
+		    of_find_node_with_property(NULL, "#power-domain-cells"))
 			return 0;
 	}
 
-- 
2.1.4

