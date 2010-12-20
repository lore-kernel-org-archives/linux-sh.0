From: Yusuke Goda <yusuke.goda.sx@renesas.com>
Date: Mon, 20 Dec 2010 01:06:04 +0000
Subject: [PATCH] ARM: mach-shmobile: mackerel: Add GPS support
Message-Id: <4D0EABFC.9030605@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index fd46f06..c0d18cb 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -807,6 +807,10 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_MMCCMD0, NULL);
 	gpio_request(GPIO_FN_MMCCLK0, NULL);

+	/* enable GPS module (GT-720F) */
+	gpio_request(GPIO_FN_SCIFA2_TXD1, NULL);
+	gpio_request(GPIO_FN_SCIFA2_RXD1, NULL);
+
 	i2c_register_board_info(0, i2c0_devices,
 				ARRAY_SIZE(i2c0_devices));
 	i2c_register_board_info(1, i2c1_devices,
-- 
1.5.6.5


