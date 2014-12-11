From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 11 Dec 2014 02:33:35 +0000
Subject: [PATCH] Revert "ARM: shmobile: multiplatform: add Audo DMAC peri peri support on defconfig"
Message-Id: <b6f6383b98092a1759d19893875bba90c8d9f446.1418265122.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1418265122.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1418265122.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This reverts commit 2315f9fce4da7df9362e4baeb5250d14ea48bf63.

Unfortunately enabling RCAR_AUDMAC_PP support this patch breaks dmaengine
support on R-Car Gen2 boards. This should be resolved by driver updates
in v3.20. But v3.19 was too early for this defconfig change.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index cc67508..302faab 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -147,7 +147,6 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_S35390A=y
 CONFIG_DMADEVICES=y
 CONFIG_SH_DMAE=y
-CONFIG_RCAR_AUDMAC_PP=y
 CONFIG_RCAR_DMAC=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_PWM=y
-- 
2.1.3

