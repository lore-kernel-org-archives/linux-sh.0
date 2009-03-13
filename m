From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 13 Mar 2009 15:27:14 +0000
Subject: [PATCH] sh: add ap325 lcd power off support
Message-Id: <20090313152714.20494.42365.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Improve the ap325 board code to allow the lcd panel
and backlight to be powered off.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/board-ap325rxa.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- 0001/arch/sh/boards/board-ap325rxa.c
+++ work/arch/sh/boards/board-ap325rxa.c	2009-03-12 22:06:57.000000000 +0900
@@ -166,6 +166,16 @@ static void ap320_wvga_power_on(void *bo
 	ctrl_outw(0x100, FPGA_BKLREG);
 }
 
+static void ap320_wvga_power_off(void *board_data)
+{
+	/* backlight */
+	ctrl_outw(0, FPGA_BKLREG);
+	gpio_set_value(GPIO_PTS3, 1);
+
+	/* ASD AP-320/325 LCD OFF */
+	ctrl_outw(0, FPGA_LCDREG);
+}
+
 static struct sh_mobile_lcdc_info lcdc_info = {
 	.clock_source = LCDC_CLK_EXTERNAL,
 	.ch[0] = {
@@ -191,6 +201,7 @@ static struct sh_mobile_lcdc_info lcdc_i
 		},
 		.board_cfg = {
 			.display_on = ap320_wvga_power_on,
+			.display_off = ap320_wvga_power_off,
 		},
 	}
 };
