From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 21 Mar 2008 09:43:46 +0000
Subject: [PATCH 04/06] sh: Use phyical addresses for MigoR smc91x resources
Message-Id: <20080321094346.10532.23730.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Use physical addresses and change resource name of MigoR ethernet chip.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---
 arch/sh/boards/renesas/migor/setup.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- 0005/arch/sh/boards/renesas/migor/setup.c
+++ work/arch/sh/boards/renesas/migor/setup.c	2008-03-20 17:31:56.000000000 +0900
@@ -27,9 +27,9 @@
 
 static struct resource smc91x_eth_resources[] = {
 	[0] = {
-		.name   = "smc91x-regs" ,
-		.start  = P2SEGADDR(0x10000300),
-		.end    = P2SEGADDR(0x1000030f),
+		.name   = "SMC91C111" ,
+		.start  = 0x10000300,
+		.end    = 0x1000030f,
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
