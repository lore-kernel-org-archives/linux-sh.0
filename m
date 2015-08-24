From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 24 Aug 2015 02:31:58 +0000
Subject: [PATCH 21/25 v7][RFC] arm64: defconfig: renesas: enable USB2 PHY of Gen3
Message-Id: <87y4h15sjn.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v5 -> v7

 - based on Gen3 v7 patch-set

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f49d044..fcf375a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -164,6 +164,7 @@ CONFIG_VIRTIO_MMIO=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_MSM_GCC_8916=y
 # CONFIG_IOMMU_SUPPORT is not set
+CONFIG_PHY_RCAR_GEN3_USB2=y
 CONFIG_PHY_XGENE=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-- 
1.9.1

