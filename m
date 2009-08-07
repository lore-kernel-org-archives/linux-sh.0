From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 07 Aug 2009 03:52:18 +0000
Subject: [PATCH] sh: fix i2c init order on ap325rxa V2
Message-Id: <20090807035218.6009.65147.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20090806141918.3609.29170.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090806141918.3609.29170.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Convert the AP325RXA board code to register devices at
arch_initcall() time instead of device_initcall(). This
fix unbreaks pcf8563 RTC driver support.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Suitable for 2.6.31-rc.

 arch/sh/boards/board-ap325rxa.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/sh/boards/board-ap325rxa.c
+++ work/arch/sh/boards/board-ap325rxa.c	2009-08-07 12:35:22.000000000 +0900
@@ -547,7 +547,7 @@ static int __init ap325rxa_devices_setup
 	return platform_add_devices(ap325rxa_devices,
 				ARRAY_SIZE(ap325rxa_devices));
 }
-device_initcall(ap325rxa_devices_setup);
+arch_initcall(ap325rxa_devices_setup);
 
 /* Return the board specific boot mode pin configuration */
 static int ap325rxa_mode_pins(void)
