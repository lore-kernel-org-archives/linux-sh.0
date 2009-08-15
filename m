From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 15 Aug 2009 02:53:34 +0000
Subject: [PATCH 03/04] sh: use in-soc KEYSC on se7724
Message-Id: <20090815025334.8125.11818.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch updates the Solution Engine 7724 board code to use
in-SoC KEYSC resources for the keyboard platform device. Using
the in-SoC key scan controller fixes a crash-during-resume issue.

Without this patch the KEYSC hardware block located in the board
specific FPGA is used together with an external IRQ which is
routed through the FPGA and handled by some board specific demux
code. This board specific FPGA interrupt code does not implement 
desc->set_wake() so the enable_irq_wake() call in the sh_keysc
driver will fail at suspend-to-ram time and the disable_irq_wake()
will bomb out when resuming.

Changing the platform data to use the in-SoC KEYSC hardware makes
the se7724 board support code less special which is a good thing.
Also, the board specific KEYSC pin setup code selects in-SoC pin
functions already which makes the current FPGA platform device data
look like a typo.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/mach-se/7724/setup.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- 0001/arch/sh/boards/mach-se/7724/setup.c
+++ work/arch/sh/boards/mach-se/7724/setup.c	2009-08-13 13:03:26.000000000 +0900
@@ -246,7 +246,7 @@ static struct platform_device ceu1_devic
 	},
 };
 
-/* KEYSC */
+/* KEYSC in SoC (Needs SW33-2 set to ON) */
 static struct sh_keysc_info keysc_info = {
 	.mode = SH_KEYSC_MODE_1,
 	.scan_timing = 10,
@@ -263,12 +263,13 @@ static struct sh_keysc_info keysc_info  
 static struct resource keysc_resources[] = {
 	[0] = {
-		.start  = 0x1a204000,
-		.end    = 0x1a20400f,
+		.name	= "KEYSC",
+		.start  = 0x044b0000,
+		.end    = 0x044b000f,
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start  = IRQ0_KEY,
+		.start  = 79,
 		.flags  = IORESOURCE_IRQ,
 	},
 };
