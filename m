From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Sep 2015 04:35:20 +0000
Subject: [PATCH 19/20 v2] arm64: defconfig: add Renesas R-Car DMAC driver support
Message-Id: <8761397jlh.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - no change

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e333159..4ffae18 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -169,6 +169,8 @@ CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_EFI=y
 CONFIG_RTC_DRV_XGENE=y
+CONFIG_DMADEVICES=y
+CONFIG_RCAR_DMAC=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_MMIO=y
-- 
1.9.1

