From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 15 Apr 2011 18:30:55 +0000
Subject: [PATCH 3/3] sh: add MMCIF runtime PM support on ecovec
Message-Id: <Pine.LNX.4.64.1104152027470.18593@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1104152021510.18593@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1104152021510.18593@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <damm@opensource.se>
---
 arch/sh/boards/mach-ecovec24/setup.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index bb13d0e..3a32741 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -885,6 +885,9 @@ static struct platform_device sh_mmcif_device = {
 	},
 	.num_resources	= ARRAY_SIZE(sh_mmcif_resources),
 	.resource	= sh_mmcif_resources,
+	.archdata = {
+		.hwblk_id = HWBLK_MMC,
+	},
 };
 #endif
 
-- 
1.7.2.5

