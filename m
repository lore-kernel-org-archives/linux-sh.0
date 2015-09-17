From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 17 Sep 2015 09:00:29 +0000
Subject: [PATCH 1/2] drivers: sh: Disable legacy default PM Domain on emev2
Message-Id: <9b302c1acf4114d51b7f0962df0b0ddee0dc75cd.1442480237.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1442480237.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1442480237.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms+renesas@verge.net.au>

From: Geert Uytterhoeven <geert+renesas@glider.be>

EMMA Mobile EV2 doesn't have MSTP clocks. All its device drivers manage
clocks explicitly, without relying on Runtime PM, so it doesn't need the
legacy default PM Domain.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/sh/pm_runtime.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index d3d1891cda3c..ad9188138ed5 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -35,8 +35,7 @@ static struct pm_clk_notifier_block platform_bus_notifier = {
 static int __init sh_pm_runtime_init(void)
 {
 	if (IS_ENABLED(CONFIG_ARCH_SHMOBILE_MULTI)) {
-		if (!of_machine_is_compatible("renesas,emev2") &&
-		    !of_machine_is_compatible("renesas,r7s72100") &&
+		if (!of_machine_is_compatible("renesas,r7s72100") &&
 #ifndef CONFIG_PM_GENERIC_DOMAINS_OF
 		    !of_machine_is_compatible("renesas,r8a73a4") &&
 		    !of_machine_is_compatible("renesas,r8a7740") &&
-- 
2.1.4

