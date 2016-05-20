From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 20 May 2016 07:50:54 +0000
Subject: [PATCH v2 1/2] drivers: sh: Stop using the legacy clock domain on ARM
Message-Id: <1463730655-16199-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1463730655-16199-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1463730655-16199-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Since commits 71d076ceb245f0d9 ("ARM: shmobile: Enable PM and
PM_GENERIC_DOMAINS for SoCs with PM Domains") and 2ee98234b88174f2
("arm64: renesas: Enable PM and PM_GENERIC_DOMAINS for SoCs with PM
Domains"), CONFIG_PM and CONFIG_PM_GENERIC_DOMAINS are enabled
unconditionally for Renesas ARM-based SoCs. Hence the legacy clock
domain is no longer used on these SoCs.

Remove the related support code, and stop entering drivers/sh/ on ARM.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Extracted from series "[PATCH 0/4] Enable PM and PM_GENERIC_DOMAINS
    for SoCs with PM Domains",
  - Rebased,
  - Updated patch description with commit IDs.

Notes:
  - This does break booting R-Car Gen2 boards using pre-v4.3 DTSes that
    don't have power-domains properties,
---
 drivers/Makefile        | 1 -
 drivers/sh/pm_runtime.c | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 8f5d076baeb0e832..6afdb78e21382538 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -127,7 +127,6 @@ obj-$(CONFIG_SGI_SN)		+= sn/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
-obj-$(CONFIG_ARCH_SHMOBILE)	+= sh/
 ifndef CONFIG_ARCH_USES_GETTIMEOFFSET
 obj-y				+= clocksource/
 endif
diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index a9bac3bf20de14e5..c887ecdaf19b7c10 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -34,15 +34,6 @@ static struct pm_clk_notifier_block platform_bus_notifier = {
 
 static int __init sh_pm_runtime_init(void)
 {
-	if (IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_ARCH_SHMOBILE)) {
-		if (!of_find_compatible_node(NULL, NULL,
-					     "renesas,cpg-mstp-clocks"))
-			return 0;
-		if (IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS_OF) &&
-		    of_find_node_with_property(NULL, "#power-domain-cells"))
-			return 0;
-	}
-
 	pm_clk_add_notifier(&platform_bus_type, &platform_bus_notifier);
 	return 0;
 }
-- 
1.9.1

