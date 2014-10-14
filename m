From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Tue, 14 Oct 2014 07:20:23 +0000
Subject: [PATCH 1/2] media: soc_camera: rcar_vin: Add r8a7794 device support
Message-Id: <1413271224-9792-2-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1413271224-9792-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1413271224-9792-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---
 drivers/media/platform/soc_camera/rcar_vin.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/soc_camera/rcar_vin.c b/drivers/media/platform/soc_camera/rcar_vin.c
index bf3588f..224604d0 100644
--- a/drivers/media/platform/soc_camera/rcar_vin.c
+++ b/drivers/media/platform/soc_camera/rcar_vin.c
@@ -1887,6 +1887,7 @@ MODULE_DEVICE_TABLE(of, rcar_vin_of_table);
 #endif
 
 static struct platform_device_id rcar_vin_id_table[] = {
+	{ "r8a7794-vin",  RCAR_GEN2 },
 	{ "r8a7791-vin",  RCAR_GEN2 },
 	{ "r8a7790-vin",  RCAR_GEN2 },
 	{ "r8a7779-vin",  RCAR_H1 },
-- 
1.9.1

