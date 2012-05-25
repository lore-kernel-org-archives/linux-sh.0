From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 25 May 2012 15:45:52 +0000
Subject: [PATCH 3/3 v3] ARM: mach-shmobile: specify IRQ names on mackerel SDHI0 interface
Message-Id: <1337960752-4944-38-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>

Using named IRQs helps the driver to act more selectively when configuring
the interface.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-mackerel.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 45854a9..15c8a08 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1050,14 +1050,17 @@ static struct resource sdhi0_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
+		.name	= SH_MOBILE_SDHI_IRQ_CARD_DETECT,
 		.start	= evt2irq(0x0e00) /* SDHI0_SDHI0I0 */,
 		.flags	= IORESOURCE_IRQ,
 	},
 	[2] = {
+		.name	= SH_MOBILE_SDHI_IRQ_SDCARD,
 		.start	= evt2irq(0x0e20) /* SDHI0_SDHI0I1 */,
 		.flags	= IORESOURCE_IRQ,
 	},
 	[3] = {
+		.name	= SH_MOBILE_SDHI_IRQ_SDIO,
 		.start	= evt2irq(0x0e40) /* SDHI0_SDHI0I2 */,
 		.flags	= IORESOURCE_IRQ,
 	},
-- 
1.7.2.5

--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
