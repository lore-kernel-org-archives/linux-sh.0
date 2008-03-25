From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 25 Mar 2008 08:24:31 +0000
Subject: [PATCH] sh: Add rs5c732b RTC support to MigoR
Message-Id: <20080325082431.10604.57349.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add support for the rs5c372b RTC chip to MigoR.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/renesas/migor/setup.c |    4 ++++
 1 file changed, 4 insertions(+)

--- 0009/arch/sh/boards/renesas/migor/setup.c
+++ work/arch/sh/boards/renesas/migor/setup.c	2008-03-20 19:52:25.000000000 +0900
@@ -176,6 +176,10 @@ static struct platform_device *migor_dev
 };
 
 static struct i2c_board_info __initdata migor_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("rtc-rs5c372", 0x32),
+		.type   = "rs5c372b",
+	},
 };
 
 static int __init migor_devices_setup(void)
