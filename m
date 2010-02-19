From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 19 Feb 2010 09:33:47 +0000
Subject: [PATCH] sh: always enable sh7724 vpu_clk and set to 166MHz on Ecovec
Message-Id: <20100219093347.646.98356.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the sh7724 processor code to always enable vpu_clk.

On the Ecovec board, set the vpu_clk to 166 Mhz.

The 166MHz setting results in a divide-by-6 setup for
vpu_clk and improves the VPU performance compared to the
power-on-reset/bootloader configuration.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-ecovec24/setup.c   |    5 +++++
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |    2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

--- 0001/arch/sh/boards/mach-ecovec24/setup.c
+++ work/arch/sh/boards/mach-ecovec24/setup.c	2010-02-19 17:57:00.000000000 +0900
@@ -1121,6 +1121,11 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_FN_INTC_IRQ1, NULL);
 	gpio_direction_input(GPIO_FN_INTC_IRQ1);
 
+	/* set VPU clock to 166 MHz */
+	clk = clk_get(NULL, "vpu_clk");
+	clk_set_rate(clk, clk_round_rate(clk, 166000000));
+	clk_put(clk);
+
 	/* enable I2C device */
 	i2c_register_board_info(0, i2c0_devices,
 				ARRAY_SIZE(i2c0_devices));
--- 0004/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7724.c	2010-02-19 18:04:26.000000000 +0900
@@ -159,7 +159,7 @@ struct clk div4_clks[DIV4_NR] = {
 	[DIV4_SH] = DIV4("shyway_clk", FRQCRA, 12, 0x2f7c, CLK_ENABLE_ON_INIT),
 	[DIV4_B] = DIV4("bus_clk", FRQCRA, 8, 0x2f7c, CLK_ENABLE_ON_INIT),
 	[DIV4_P] = DIV4("peripheral_clk", FRQCRA, 0, 0x2f7c, 0),
-	[DIV4_M1] = DIV4("vpu_clk", FRQCRB, 4, 0x2f7c, 0),
+	[DIV4_M1] = DIV4("vpu_clk", FRQCRB, 4, 0x2f7c, CLK_ENABLE_ON_INIT),
 };
 
 struct clk div6_clks[] = {
