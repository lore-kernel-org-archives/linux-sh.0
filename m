From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Mon, 13 May 2013 09:44:13 +0000
Subject: [PATCH 14/14] ARM: vt8500: Remove init_irq declaration in machine description
Message-Id: <1368438253-28218-15-git-send-email-maxime.ripard@free-electrons.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1368438253-28218-1-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1368438253-28218-1-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
specified") removed the need to explictly setup the init_irq field in
the machine description when using only irqchip_init. Remove that
declaration for vt8500 as well.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-vt8500/vt8500.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-vt8500/vt8500.c b/arch/arm/mach-vt8500/vt8500.c
index 1dd281e..1585900 100644
--- a/arch/arm/mach-vt8500/vt8500.c
+++ b/arch/arm/mach-vt8500/vt8500.c
@@ -178,7 +178,6 @@ static const char * const vt8500_dt_compat[] = {
 DT_MACHINE_START(WMT_DT, "VIA/Wondermedia SoC (Device Tree Support)")
 	.dt_compat	= vt8500_dt_compat,
 	.map_io		= vt8500_map_io,
-	.init_irq	= irqchip_init,
 	.init_machine	= vt8500_init,
 	.init_time	= clocksource_of_init,
 	.restart	= vt8500_restart,
-- 
1.8.1.2

