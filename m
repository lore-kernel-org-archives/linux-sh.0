From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 16 Apr 2012 21:09:04 +0000
Subject: [PATCH 1/3] ARM: mach-shmobile: sh7372 CEU supports up to 8188x8188 images
Message-Id: <Pine.LNX.4.64.1204162305050.29915@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Reviewed-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/board-ap4evb.c   |    2 ++
 arch/arm/mach-shmobile/board-mackerel.c |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index b56dde2..0c3caeba 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -997,6 +997,8 @@ static struct sh_mobile_ceu_companion csi2 = {
 
 static struct sh_mobile_ceu_info sh_mobile_ceu_info = {
 	.flags = SH_CEU_FLAG_USE_8BIT_BUS,
+	.max_width = 8188,
+	.max_height = 8188,
 	.csi2 = &csi2,
 };
 
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index f49e28a..30fd516 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1257,6 +1257,8 @@ static void mackerel_camera_del(struct soc_camera_device *icd)
 
 static struct sh_mobile_ceu_info sh_mobile_ceu_info = {
 	.flags = SH_CEU_FLAG_USE_8BIT_BUS,
+	.max_width = 8188,
+	.max_height = 8188,
 };
 
 static struct resource ceu_resources[] = {
-- 
1.7.2.5

