From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 14 May 2013 15:38:36 +0000
Subject: [PATCH 03/20] ARM: nomadik: Remove init_irq declaration in machine description
Message-Id: <1368545933-7430-4-git-send-email-maxime.ripard@free-electrons.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
specified") removed the need to explictly setup the init_irq field in
the machine description when using only irqchip_init. Remove that
declaration for nomadik as well.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-nomadik/cpu-8815.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 59f6ff5..46cce9b 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -25,7 +25,6 @@
 #include <linux/slab.h>
 #include <linux/irq.h>
 #include <linux/dma-mapping.h>
-#include <linux/irqchip.h>
 #include <linux/platform_data/clk-nomadik.h>
 #include <linux/platform_data/pinctrl-nomadik.h>
 #include <linux/pinctrl/machine.h>
@@ -323,7 +322,6 @@ static const char * cpu8815_board_compat[] = {
 
 DT_MACHINE_START(NOMADIK_DT, "Nomadik STn8815")
 	.map_io		= cpu8815_map_io,
-	.init_irq	= irqchip_init,
 	.init_time	= cpu8815_timer_init_of,
 	.init_machine	= cpu8815_init_of,
 	.restart	= cpu8815_restart,
-- 
1.8.1.2

