From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 15 Aug 2009 03:02:08 +0000
Subject: [PATCH] sh: Runtime PM pdev hwblk - kfr2r09 LCDC
Message-Id: <20090815030208.8312.1837.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch simply adds LCDC hwblk_id data for the kfr2r09 board.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Suitable for the sh/hwblk topic branch, but also depends on the
 kfr2r09 LCDC patch. I suppose the sh/hwblk stuff needs a rebase?

 arch/sh/boards/mach-kfr2r09/setup.c |    3 +++
 1 file changed, 3 insertions(+)

--- 0004/arch/sh/boards/mach-kfr2r09/setup.c
+++ work/arch/sh/boards/mach-kfr2r09/setup.c	2009-08-07 13:22:32.000000000 +0900
@@ -176,6 +176,9 @@ static struct platform_device kfr2r09_sh
 	.dev	= {
 		.platform_data	= &kfr2r09_sh_lcdc_info,
 	},
+	.archdata = {
+		.hwblk_id = HWBLK_LCDC,
+	},
 };
 
 static struct platform_device *kfr2r09_devices[] __initdata = {
