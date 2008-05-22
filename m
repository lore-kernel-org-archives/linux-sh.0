From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 22 May 2008 13:15:31 +0000
Subject: [PATCH] sh: fix USBF resource for sh7722
Message-Id: <20080522131531.12223.45466.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The USBF function on sh7722 is currently not working with the m66592_udc
driver. The driver is using platform_get_resource_byname() so my commit
a0d29798e568116aa6c32aef7bab2d9e620c88ad broke sh7722 support.

The long term fix is to replace platform_get_resource_byname() in the
driver with platform_get_resource(), but this helps until that happens.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2008-05-22 14:19:32.000000000 +0900
@@ -16,7 +16,7 @@
 
 static struct resource usbf_resources[] = {
 	[0] = {
-		.name	= "USBF",
+		.name	= "m66592_udc",
 		.start	= 0x04480000,
 		.end	= 0x044800FF,
 		.flags	= IORESOURCE_MEM,
