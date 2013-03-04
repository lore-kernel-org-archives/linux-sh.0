From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 04 Mar 2013 08:45:39 +0000
Subject: [PATCH] sh-pfc: r8a7779: fixup INDTx address
Message-Id: <87lia3pn80.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

INDTn address is 0xFFC4x000C. 0xFFC4x0008 is OUTDTn

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index 13feaa0..cb97fb6 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -2585,13 +2585,13 @@ static struct pinmux_cfg_reg pinmux_config_regs[] = {
 };
 
 static struct pinmux_data_reg pinmux_data_regs[] = {
-	{ PINMUX_DATA_REG("INDT0", 0xffc40008, 32) { GP_INDT(0) } },
-	{ PINMUX_DATA_REG("INDT1", 0xffc41008, 32) { GP_INDT(1) } },
-	{ PINMUX_DATA_REG("INDT2", 0xffc42008, 32) { GP_INDT(2) } },
-	{ PINMUX_DATA_REG("INDT3", 0xffc43008, 32) { GP_INDT(3) } },
-	{ PINMUX_DATA_REG("INDT4", 0xffc44008, 32) { GP_INDT(4) } },
-	{ PINMUX_DATA_REG("INDT5", 0xffc45008, 32) { GP_INDT(5) } },
-	{ PINMUX_DATA_REG("INDT6", 0xffc46008, 32) {
+	{ PINMUX_DATA_REG("INDT0", 0xffc4000c, 32) { GP_INDT(0) } },
+	{ PINMUX_DATA_REG("INDT1", 0xffc4100c, 32) { GP_INDT(1) } },
+	{ PINMUX_DATA_REG("INDT2", 0xffc4200c, 32) { GP_INDT(2) } },
+	{ PINMUX_DATA_REG("INDT3", 0xffc4300c, 32) { GP_INDT(3) } },
+	{ PINMUX_DATA_REG("INDT4", 0xffc4400c, 32) { GP_INDT(4) } },
+	{ PINMUX_DATA_REG("INDT5", 0xffc4500c, 32) { GP_INDT(5) } },
+	{ PINMUX_DATA_REG("INDT6", 0xffc4600c, 32) {
 		0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, GP_6_8_DATA,
 		GP_6_7_DATA, GP_6_6_DATA, GP_6_5_DATA, GP_6_4_DATA,
-- 
1.7.9.5

