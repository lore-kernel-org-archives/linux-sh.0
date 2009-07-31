From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 31 Jul 2009 07:48:21 +0000
Subject: [PATCH 08/09] sh: Runtime PM pdev hwblk - kfr2r09
Message-Id: <20090731074821.29009.97641.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add hwblk_id to kfr2r09 board specific on-chip sh7724
platform devices.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/mach-kfr2r09/setup.c |    3 +++
 1 file changed, 3 insertions(+)

--- 0001/arch/sh/boards/mach-kfr2r09/setup.c
+++ work/arch/sh/boards/mach-kfr2r09/setup.c	2009-07-31 15:39:47.000000000 +0900
@@ -95,6 +95,9 @@ static struct platform_device kfr2r09_sh
 	.dev	= {
 		.platform_data	= &kfr2r09_sh_keysc_info,
 	},
+	.archdata = {
+		.hwblk_id = HWBLK_KEYSC,
+	},
 };
 
 static struct platform_device *kfr2r09_devices[] __initdata = {
