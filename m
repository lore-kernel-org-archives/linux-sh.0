From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Sun, 13 Dec 2015 15:27:16 +0000
Subject: [PATCH] media: soc_camera: rcar_vin: Add R-Car Gen3 support
Message-Id: <1450020436-809-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387830486-10650-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387830486-10650-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

From: Yoshihiko Mori <yoshihiko.mori.nx@renesas.com>

Add chip identification for R-Car Gen3.

Signed-off-by: Yoshihiko Mori <yoshihiko.mori.nx@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is against master branch of linuxtv.org/media_tree.git.

 Documentation/devicetree/bindings/media/rcar_vin.txt | 1 +
 drivers/media/platform/soc_camera/rcar_vin.c         | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/rcar_vin.txt b/Documentation/devicetree/bindings/media/rcar_vin.txt
index 9dafe6b..619193c 100644
--- a/Documentation/devicetree/bindings/media/rcar_vin.txt
+++ b/Documentation/devicetree/bindings/media/rcar_vin.txt
@@ -6,6 +6,7 @@ family of devices. The current blocks are always slaves and suppot one input
 channel which can be either RGB, YUYV or BT656.
 
  - compatible: Must be one of the following
+   - "renesas,vin-r8a7795" for the R8A7795 device
    - "renesas,vin-r8a7794" for the R8A7794 device
    - "renesas,vin-r8a7793" for the R8A7793 device
    - "renesas,vin-r8a7791" for the R8A7791 device
diff --git a/drivers/media/platform/soc_camera/rcar_vin.c b/drivers/media/platform/soc_camera/rcar_vin.c
index 5d90f39..29e7ca4 100644
--- a/drivers/media/platform/soc_camera/rcar_vin.c
+++ b/drivers/media/platform/soc_camera/rcar_vin.c
@@ -143,6 +143,7 @@
 #define RCAR_VIN_BT656			(1 << 3)
 
 enum chip_id {
+	RCAR_GEN3,
 	RCAR_GEN2,
 	RCAR_H1,
 	RCAR_M1,
@@ -1846,6 +1847,7 @@ static struct soc_camera_host_ops rcar_vin_host_ops = {
 
 #ifdef CONFIG_OF
 static const struct of_device_id rcar_vin_of_table[] = {
+	{ .compatible = "renesas,vin-r8a7795", .data = (void *)RCAR_GEN3 },
 	{ .compatible = "renesas,vin-r8a7794", .data = (void *)RCAR_GEN2 },
 	{ .compatible = "renesas,vin-r8a7793", .data = (void *)RCAR_GEN2 },
 	{ .compatible = "renesas,vin-r8a7791", .data = (void *)RCAR_GEN2 },
-- 
1.9.1

