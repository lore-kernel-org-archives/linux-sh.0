From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 14 Mar 2012 15:02:24 +0000
Subject: [PATCH 2/2] ARM: mach-shmobile: sh7372 CEU supports up to 8188x8188 images
Message-Id: <Pine.LNX.4.64.1203141601060.25284@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1203141600210.25284@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1203141600210.25284@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Media Mailing List <linux-media@vger.kernel.org>
Cc: linux-sh@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

This patch we can push some time after the first one in this series gets 
in, no breakage is caused.

 arch/arm/mach-shmobile/board-ap4evb.c   |    2 ++
 arch/arm/mach-shmobile/board-mackerel.c |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index aab0a34..f67aa03 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -1009,6 +1009,8 @@ static struct sh_mobile_ceu_companion csi2 = {
 
 static struct sh_mobile_ceu_info sh_mobile_ceu_info = {
 	.flags = SH_CEU_FLAG_USE_8BIT_BUS,
+	.max_width = 8188,
+	.max_height = 8188,
 	.csi2 = &csi2,
 };
 
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 9b42fbd..f790772 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1270,6 +1270,8 @@ static void mackerel_camera_del(struct soc_camera_device *icd)
 
 static struct sh_mobile_ceu_info sh_mobile_ceu_info = {
 	.flags = SH_CEU_FLAG_USE_8BIT_BUS,
+	.max_width = 8188,
+	.max_height = 8188,
 };
 
 static struct resource ceu_resources[] = {
-- 
1.7.2.5

