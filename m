From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 01 Dec 2015 05:36:57 +0000
Subject: [PATCH 2/2] arm64: defconfig: add CS2000 support
Message-Id: <87io4iyboj.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2b0a9dc..f239a2e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -189,6 +189,7 @@ CONFIG_QCOM_BAM_DMA=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_MMIO=y
+CONFIG_COMMON_CLK_CS2000_CP=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_MSM_GCC_8916=y
 CONFIG_HWSPINLOCK_QCOM=y
-- 
1.9.1

