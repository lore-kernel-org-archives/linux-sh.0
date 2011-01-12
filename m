From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 12 Jan 2011 10:43:07 +0000
Subject: [PATCH] ARM: mach-shmobile: Kill off unused !gpio_is_valid() case
Message-Id: <20110112104307.11071.4228.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

The Card Detect GPIOs used on AP4EVB and Mackerel are
alwayws valid, so kill off the unused !gpio_is_valid()
case.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-ap4evb.c   |    5 +----
 arch/arm/mach-shmobile/board-mackerel.c |    5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-ap4evb.c
+++ work/arch/arm/mach-shmobile/board-ap4evb.c	2011-01-12 14:42:46.000000000 +0900
@@ -247,10 +247,7 @@ static struct platform_device smc911x_de
  */
 static int slot_cn7_get_cd(struct platform_device *pdev)
 {
-	if (gpio_is_valid(GPIO_PORT41))
-		return !gpio_get_value(GPIO_PORT41);
-	else
-		return -ENXIO;
+	return !gpio_get_value(GPIO_PORT41);
 }
 
 /* SH_MMCIF */
--- 0001/arch/arm/mach-shmobile/board-mackerel.c
+++ work/arch/arm/mach-shmobile/board-mackerel.c	2011-01-12 14:32:00.000000000 +0900
@@ -657,10 +657,7 @@ static struct platform_device fsi_ak4643
  */
 static int slot_cn7_get_cd(struct platform_device *pdev)
 {
-	if (gpio_is_valid(GPIO_PORT41))
-		return !gpio_get_value(GPIO_PORT41);
-	else
-		return -ENXIO;
+	return !gpio_get_value(GPIO_PORT41);
 }
 
 /* SDHI0 */
