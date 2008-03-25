From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 25 Mar 2008 08:30:45 +0000
Subject: [PATCH] sh: Add migor_ts support to MigoR
Message-Id: <20080325083045.10680.19822.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add support for the migor_ts touch panel to the MigoR board.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/renesas/migor/setup.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- 0010/arch/sh/boards/renesas/migor/setup.c
+++ work/arch/sh/boards/renesas/migor/setup.c	2008-03-20 19:54:41.000000000 +0900
@@ -180,6 +180,10 @@ static struct i2c_board_info __initdata 
 		I2C_BOARD_INFO("rtc-rs5c372", 0x32),
 		.type   = "rs5c372b",
 	},
+	{
+		I2C_BOARD_INFO("migor_ts", 0x51),
+		.irq = 38, /* IRQ6 */
+	},
 };
 
 static int __init migor_devices_setup(void)
@@ -211,6 +215,11 @@ static void __init migor_setup(char **cm
 
 	/* I2C */
 	ctrl_outl(ctrl_inl(MSTPCR1) & ~0x00000200, MSTPCR1);
+
+	/* Touch Panel - Enable IRQ6 */
+	ctrl_outw(ctrl_inw(PORT_PZCR) & ~0xc, PORT_PZCR);
+	ctrl_outw((ctrl_inw(PORT_PSELA) | 0x8000), PORT_PSELA);
+	ctrl_outw((ctrl_inw(PORT_HIZCRC) & ~0x4000), PORT_HIZCRC);
 }
 
 static struct sh_machine_vector mv_migor __initmv = {
