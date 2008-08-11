From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 11 Aug 2008 05:59:03 +0000
Subject: [PATCH] sh: export sh7723 VEU as VEU2H
Message-Id: <20080811055903.19919.35861.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Export sh7723 VEU hardware blocks as VEU2H. The sh7723 VEU2H differs
a bit from the sh7722 VEU so use different names for our UIO devices.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7723.c	2008-08-05 17:34:25.000000000 +0900
@@ -45,7 +45,7 @@ static struct platform_device vpu_device
 };
 
 static struct uio_info veu0_platform_data = {
-	.name = "VEU",
+	.name = "VEU2H",
 	.version = "0",
 	.irq = 54,
 };
@@ -73,7 +73,7 @@ static struct platform_device veu0_devic
 };
 
 static struct uio_info veu1_platform_data = {
-	.name = "VEU",
+	.name = "VEU2H",
 	.version = "0",
 	.irq = 27,
 };
