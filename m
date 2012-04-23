From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 23 Apr 2012 06:53:24 +0000
Subject: [PATCH 3/6] ARM: mach-shmobile: kzm9g: correct screen direction
Message-Id: <877gx79bxb.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The correct screen direction of KZM9G board needs
PORT226/SC settings.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-kzm9g.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index c846531..545d633 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -258,8 +258,10 @@ static void __init kzm_init(void)
 	gpio_request(GPIO_FN_LCDDISP,	NULL);
 	gpio_request(GPIO_FN_LCDDCK,	NULL);
 
-	gpio_request(GPIO_PORT222,	NULL);
+	gpio_request(GPIO_PORT222,	NULL); /* LCDCDON */
+	gpio_request(GPIO_PORT226,	NULL); /* SC */
 	gpio_direction_output(GPIO_PORT222, 1);
+	gpio_direction_output(GPIO_PORT226, 1);
 
 	/* Touchscreen */
 	gpio_request(GPIO_PORT223, NULL); /* IRQ8 */
-- 
1.7.5.4

