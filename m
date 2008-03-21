From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 21 Mar 2008 09:43:28 +0000
Subject: [PATCH 02/06] sh: Use physical addresses for sh7722 USBF resources
Message-Id: <20080321094328.10532.21139.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Use physical addresses and change resource name to follow data sheet.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2008-03-20 17:27:34.000000000 +0900
@@ -16,13 +16,12 @@
 
 static struct resource usbf_resources[] = {
 	[0] = {
-		.name	= "m66592_udc",
-		.start	= 0xA4480000,
-		.end	= 0xA44800FF,
+		.name	= "USBF",
+		.start	= 0x04480000,
+		.end	= 0x044800FF,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.name	= "m66592_udc",
 		.start	= 65,
 		.end	= 65,
 		.flags	= IORESOURCE_IRQ,
