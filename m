From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 26 Oct 2009 10:41:58 +0000
Subject: [PATCH] sh: add hwblk_id to sh_eth on ecovec24
Message-Id: <20091026104158.25069.90213.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add HWBLK_ETHER to the sh_eth platform device
to allow Runtime PM of the ethernet hardware.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-ecovec24/setup.c |    3 +++
 1 file changed, 3 insertions(+)

--- 0004/arch/sh/boards/mach-ecovec24/setup.c
+++ work/arch/sh/boards/mach-ecovec24/setup.c	2009-10-07 16:58:33.000000000 +0900
@@ -132,6 +132,9 @@ static struct platform_device sh_eth_dev
 	},
 	.num_resources = ARRAY_SIZE(sh_eth_resources),
 	.resource = sh_eth_resources,
+	.archdata = {
+		.hwblk_id = HWBLK_ETHER,
+	},
 };
 
 /* USB0 host */
