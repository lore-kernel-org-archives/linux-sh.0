From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Nov 2010 06:19:52 +0000
Subject: [PATCH] ARM: mach-shmobile: mackerel: Add lost GPIO_FN_LCDD 18 - 23
Message-Id: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

RGB24 bus needs 18-23 pin

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 889ce4f..e6407cc 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -294,6 +294,12 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_IRQ6_39,	NULL);
 
 	/* LCDC */
+	gpio_request(GPIO_FN_LCDD23,   NULL);
+	gpio_request(GPIO_FN_LCDD22,   NULL);
+	gpio_request(GPIO_FN_LCDD21,   NULL);
+	gpio_request(GPIO_FN_LCDD20,   NULL);
+	gpio_request(GPIO_FN_LCDD19,   NULL);
+	gpio_request(GPIO_FN_LCDD18,   NULL);
 	gpio_request(GPIO_FN_LCDD17,   NULL);
 	gpio_request(GPIO_FN_LCDD16,   NULL);
 	gpio_request(GPIO_FN_LCDD15,   NULL);
-- 
1.7.0.4

