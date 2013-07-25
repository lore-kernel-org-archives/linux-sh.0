From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 25 Jul 2013 00:50:50 +0000
Subject: [PATCH] ARM: shmobile: armadillo800eva: Don't request GPIO 166 in board code
Message-Id: <87zjtbwjh5.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fw7w38mf.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fw7w38mf.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

89ae7b5bbd3e65bc6ab7a577ca5ec18569589c8c
(ARM: shmobile: armadillo800eva: Register pinctrl mapping for INTC)
mistakenly requests GPIO 166 in board code,
most probably due to a wrong merge conflict resolution.
As the GPIO is passed to the st1232 driver through platform
data and requested by the driver,
there's no need to request it in board code. Fix it.

Tested by: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
>> Simon

This patch is v2 of
[ARM: shmobile: armadillo800eva: tidyup ST1232 pin settings]

v1 -> v2

 - exchange Subject and log
 - Hiep's Tested-by, and Laurent's Acked-by were added

 arch/arm/mach-shmobile/board-armadillo800eva.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 2412fca..4cfcbbe 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1205,9 +1205,6 @@ static void __init eva_init(void)
 	/* LCDC0 */
 	gpio_request_one(61, GPIOF_OUT_INIT_HIGH, NULL); /* LCDDON */
 
-	/* Touchscreen */
-	gpio_request_one(166, GPIOF_OUT_INIT_HIGH, NULL); /* TP_RST_B */
-
 	/* GETHER */
 	gpio_request_one(18, GPIOF_OUT_INIT_HIGH, NULL); /* PHY_RST */
 
-- 
1.7.9.5

