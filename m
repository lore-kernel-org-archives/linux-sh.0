From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 04 Jan 2012 14:22:44 +0000
Subject: [PATCH] ARM: mach-shmobile: fix SDHI0 hotplug sense
Message-Id: <Pine.LNX.4.64.1201041521400.30506@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

In most cases it suffices to only trigger SD-card interrupts on one edge
due to GPIO level bouncing, but sometimes it does indeed happen, that only
one interrupt is produced on a card insertion or removal, which is then
missed, if the wrong trigger sense is configured. To avoid this configure
the GPIO to produce interrupts on both edges.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-mackerel.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index b35343a..3139ced 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1011,7 +1011,7 @@ static struct sh_mobile_sdhi_info sdhi0_info = {
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
 	.cd_gpio	= GPIO_PORT172,
 	.cd_irq		= evt2irq(0x3340),
-	.cd_flags	= IRQF_TRIGGER_FALLING,
+	.cd_flags	= IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
 };
 
 static struct resource sdhi0_resources[] = {
-- 
1.7.2.5

