From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Tue, 14 Oct 2014 06:24:38 +0000
Subject: [PATCH] media: soc_camera: rcar_vin: Add YUYV capture format support
Message-Id: <1413267878-8222-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387830486-10650-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387830486-10650-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is against master branch of linuxtv.org/media_tree.git.

 drivers/media/platform/soc_camera/rcar_vin.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/platform/soc_camera/rcar_vin.c b/drivers/media/platform/soc_camera/rcar_vin.c
index 7eb4f1e..61c36b0 100644
--- a/drivers/media/platform/soc_camera/rcar_vin.c
+++ b/drivers/media/platform/soc_camera/rcar_vin.c
@@ -889,6 +889,14 @@ static const struct soc_mbus_pixelfmt rcar_vin_formats[] = {
 		.layout			= SOC_MBUS_LAYOUT_PLANAR_Y_C,
 	},
 	{
+		.fourcc			= V4L2_PIX_FMT_YUYV,
+		.name			= "YUYV",
+		.bits_per_sample	= 16,
+		.packing		= SOC_MBUS_PACKING_NONE,
+		.order			= SOC_MBUS_ORDER_LE,
+		.layout			= SOC_MBUS_LAYOUT_PACKED,
+	},
+	{
 		.fourcc			= V4L2_PIX_FMT_UYVY,
 		.name			= "UYVY",
 		.bits_per_sample	= 16,
-- 
1.9.1

