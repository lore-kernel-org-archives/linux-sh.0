From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 12 Jun 2012 09:41:26 +0000
Subject: [PATCH 21/27 v2] ARM: shmobile: armadillo800eva: enable DMAEngine on FSI
Message-Id: <87d354x3y5.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

It is possible to reduce CPU load if FSI playback used DMAEngine.
This patch enabled it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - no change

 arch/arm/configs/armadillo800eva_defconfig     |    2 ++
 arch/arm/mach-shmobile/board-armadillo800eva.c |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
index df1ce54..16bbb3f 100644
--- a/arch/arm/configs/armadillo800eva_defconfig
+++ b/arch/arm/configs/armadillo800eva_defconfig
@@ -119,6 +119,8 @@ CONFIG_USB_ETH=m
 CONFIG_MMC=y
 CONFIG_MMC_SDHI=y
 CONFIG_MMC_SH_MMCIF=y
+CONFIG_DMADEVICES=y
+CONFIG_SH_DMAE=y
 CONFIG_UIO=y
 CONFIG_UIO_PDRV_GENIRQ=y
 # CONFIG_DNOTIFY is not set
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 0248573..271adb8 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -754,12 +754,14 @@ static int fsi_hdmi_set_rate(struct device *dev, int rate, int enable)
 static struct sh_fsi_platform_info fsi_info = {
 	/* FSI-WM8978 */
 	.port_a = {
+		.tx_id = SHDMA_SLAVE_FSIA_TX,
 	},
 	/* FSI-HDMI */
 	.port_b = {
 		.flags		= SH_FSI_FMT_SPDIF |
 				  SH_FSI_ENABLE_STREAM_MODE,
 		.set_rate	= fsi_hdmi_set_rate,
+		.tx_id		= SHDMA_SLAVE_FSIB_TX,
 	}
 };
 
-- 
1.7.5.4

