From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 08 Jul 2013 06:16:46 +0000
Subject: [PATCH] ARM: shmobile: Minor update for the Lager DT reference code
Message-Id: <20130708061646.25516.97272.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Update the Lager DT reference code to get rid of the redundant
irqchip header and also make lager_add_standard_devices() static.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against "renesas-next-20130704v2"

 arch/arm/mach-shmobile/board-lager-reference.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-lager-reference.c
+++ work/arch/arm/mach-shmobile/board-lager-reference.c	2013-07-08 15:10:21.000000000 +0900
@@ -19,12 +19,11 @@
  */
 
 #include <linux/init.h>
-#include <linux/irqchip.h>
 #include <linux/of_platform.h>
 #include <mach/r8a7790.h>
 #include <asm/mach/arch.h>
 
-void __init lager_add_standard_devices(void)
+static void __init lager_add_standard_devices(void)
 {
 	/* clocks are setup late during boot in the case of DT */
 	r8a7790_clock_init();
