From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 24 Dec 2009 08:31:44 +0000
Subject: [PATCH] sh: ms7724: setup.c detailed correction
Message-Id: <uvdfwvklr.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

o change cpurelax -> udelay
o add device name comment

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-se/7724/setup.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 5d0f70b..63f958c 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -391,6 +391,7 @@ static struct platform_device sh_eth_device = {
 	},
 };
 
+/* USB0 */
 static struct r8a66597_platdata sh7724_usb0_host_data = {
 	.on_chip = 1,
 };
@@ -423,6 +424,7 @@ static struct platform_device sh7724_usb0_host_device = {
 	},
 };
 
+/* USB1 */
 static struct r8a66597_platdata sh7724_usb1_gadget_data = {
 	.on_chip = 1,
 };
@@ -452,6 +454,7 @@ static struct platform_device sh7724_usb1_gadget_device = {
 	.resource	= sh7724_usb1_gadget_resources,
 };
 
+/* SDHI0 */
 static struct resource sdhi0_cn7_resources[] = {
 	[0] = {
 		.name	= "SDHI0",
@@ -475,6 +478,7 @@ static struct platform_device sdhi0_cn7_device = {
 	},
 };
 
+/* SDHI1 */
 static struct resource sdhi1_cn8_resources[] = {
 	[0] = {
 		.name	= "SDHI1",
@@ -533,7 +537,7 @@ static int __init sh_eth_is_eeprom_ready(void)
 	while (t--) {
 		if (!ctrl_inw(EEPROM_STAT))
 			return 1;
-		cpu_relax();
+		udelay(1);
 	}
 
 	printk(KERN_ERR "ms7724se can not access to eeprom\n");
-- 
1.6.3.3

