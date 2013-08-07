From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 07 Aug 2013 04:28:28 +0000
Subject: [GIT PULL 04/19] ARM: shmobile: Minor update for the Lager DT reference code
Message-Id: <d144f3623ab37c8cd8365533217e9059d8eb4636.1375838900.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1375838900.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1375838900.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Update the Lager DT reference code to get rid of the redundant
irqchip header and also make lager_add_standard_devices() static.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager-reference.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index eb6c55e..9c316a1 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
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
-- 
1.8.3.2

