From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 07 Aug 2009 03:51:05 +0000
Subject: [PATCH] sh: fix i2c init order on Migo-R V2
Message-Id: <20090807035105.5997.74189.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20090806141536.28146.17373.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090806141536.28146.17373.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Convert the Migo-R board code to register devices at
arch_initcall() time instead of __initcall(). This fix
unbreaks migor_ts touch screen driver support.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Suitable for 2.6.31-rc.

 arch/sh/boards/mach-migor/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/sh/boards/mach-migor/setup.c
+++ work/arch/sh/boards/mach-migor/setup.c	2009-08-07 12:09:28.000000000 +0900
@@ -608,7 +608,7 @@ static int __init migor_devices_setup(vo
 
 	return platform_add_devices(migor_devices, ARRAY_SIZE(migor_devices));
 }
-__initcall(migor_devices_setup);
+arch_initcall(migor_devices_setup);
 
 /* Return the board specific boot mode pin configuration */
 static int migor_mode_pins(void)
