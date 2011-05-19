From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 19 May 2011 06:30:59 +0000
Subject: [PATCH] ARM: mach-shmobile: AG5EVM DSI resource string update
Message-Id: <20110519063059.27931.76032.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the struct resources for DSI0 to include the
hardware block name. Purely cosmetic, makes /proc/iomem
look slightly better.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-ag5evm.c |    2 ++
 1 file changed, 2 insertions(+)

--- 0001/arch/arm/mach-shmobile/board-ag5evm.c
+++ work/arch/arm/mach-shmobile/board-ag5evm.c	2011-05-19 15:04:16.000000000 +0900
@@ -296,11 +296,13 @@ static struct platform_device lcdc0_devi
 /* MIPI-DSI */
 static struct resource mipidsi0_resources[] = {
 	[0] = {
+		.name	= "DSI0",
 		.start  = 0xfeab0000,
 		.end    = 0xfeab3fff,
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
+		.name	= "DSI0",
 		.start  = 0xfeab4000,
 		.end    = 0xfeab7fff,
 		.flags  = IORESOURCE_MEM,
