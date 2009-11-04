From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 04 Nov 2009 10:34:43 +0000
Subject: [PATCH] sh: mach-ecovec24: Enable SPU2 clock when boot
Message-Id: <uocnifuik.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 2274985..d5d36fe 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -535,6 +535,8 @@ extern char ecovec24_sdram_leave_end;
 
 static int __init arch_setup(void)
 {
+	struct clk *clk;
+
 	/* register board specific self-refresh code */
 	sh_mobile_register_self_refresh(SUSP_SH_STANDBY | SUSP_SH_SF,
 					&ecovec24_sdram_enter_start,
@@ -780,6 +782,11 @@ static int __init arch_setup(void)
 	i2c_register_board_info(1, i2c1_devices,
 				ARRAY_SIZE(i2c1_devices));
 
+	/* enable SPU2 */
+	clk = clk_get(NULL, "spu_clk");
+	clk_enable(clk); /* start SPU2 */
+	clk_put(clk);
+
 	return platform_add_devices(ecovec_devices,
 				    ARRAY_SIZE(ecovec_devices));
 }
-- 
1.6.3.3

