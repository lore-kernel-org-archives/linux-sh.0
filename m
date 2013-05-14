From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 14 May 2013 15:38:35 +0000
Subject: [PATCH 02/20] ARM: zynq: Remove init_irq declaration in machine description
Message-Id: <1368545933-7430-3-git-send-email-maxime.ripard@free-electrons.com>
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
declaration for zynq as well.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Michal Simek <monstr@monstr.eu>
---
 arch/arm/mach-zynq/common.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 5bfe703..4c0199b8 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -25,7 +25,6 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/of.h>
-#include <linux/irqchip.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -106,7 +105,6 @@ static const char * const zynq_dt_match[] = {
 MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
 	.smp		= smp_ops(zynq_smp_ops),
 	.map_io		= zynq_map_io,
-	.init_irq	= irqchip_init,
 	.init_machine	= zynq_init_machine,
 	.init_time	= zynq_timer_init,
 	.dt_compat	= zynq_dt_match,
-- 
1.8.1.2

