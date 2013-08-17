From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 17 Aug 2013 22:15:42 +0000
Subject: [PATCH 1/2] SH7619: fix Ether support
Message-Id: <201308180215.43063.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201308180213.23296.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201308180213.23296.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: lethal@linux-sh.org, linux-sh@vger.kernel.org, davem@davemloft.net

The 'sh_eth' driver's probe will crash as the platform code is hopelessly behind
the platform data -- it passes PHY ID instead of 'struct sh_eth_plat_data *'.
Strangely, both commit d88a3ea6fa4c (SH7619 add ethernet controler support) that
added the platform code and commit 71557a37adb5 ([netdrvr] sh_eth: Add  SH7619
support)  were done  in about  the same time, yet the latter one added 'struct
sh_eth_plat_data' and the platform code didn't ever get updated...

Add the proper platform data and fix off-by-one memory resource end error, while
at it...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: stable@vger.kernel.org

---
 arch/sh/kernel/cpu/sh2/setup-sh7619.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

Index: net/arch/sh/kernel/cpu/sh2/setup-sh7619.c
=================================--- net.orig/arch/sh/kernel/cpu/sh2/setup-sh7619.c
+++ net/arch/sh/kernel/cpu/sh2/setup-sh7619.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
+#include <linux/sh_eth.h>
 #include <linux/sh_timer.h>
 #include <linux/io.h>
 
@@ -110,10 +111,17 @@ static struct platform_device scif2_devi
 	},
 };
 
+static struct sh_eth_plat_data eth_platform_data = {
+	.phy		= 1,
+	.edmac_endian	= EDMAC_LITTLE_ENDIAN,
+	.register_type	= SH_ETH_REG_FAST_SH3_SH2,
+	.phy_interace	= PHY_INTERFACE_MODE_MII,
+};
+
 static struct resource eth_resources[] = {
 	[0] = {
 		.start = 0xfb000000,
-		.end =   0xfb0001c8,
+		.end = 0xfb0001c7,
 		.flags = IORESOURCE_MEM,
 	},
 	[1] = {
@@ -127,7 +135,7 @@ static struct platform_device eth_device
 	.name = "sh7619-ether",
 	.id = -1,
 	.dev = {
-		.platform_data = (void *)1,
+		.platform_data = &eth_platform_data,
 	},
 	.num_resources = ARRAY_SIZE(eth_resources),
 	.resource = eth_resources,
