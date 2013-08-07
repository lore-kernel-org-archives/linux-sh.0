From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 07 Aug 2013 04:07:23 +0000
Subject: [PATCH 5/5] ARM: shmobile: bockw defconfig: add Sound support
Message-Id: <87wqnyi1oo.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/configs/bockw_defconfig |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/bockw_defconfig b/arch/arm/configs/bockw_defconfig
index 845f5cd..e9440fe 100644
--- a/arch/arm/configs/bockw_defconfig
+++ b/arch/arm/configs/bockw_defconfig
@@ -84,6 +84,10 @@ CONFIG_I2C=y
 CONFIG_I2C_RCAR=y
 CONFIG_SPI=y
 CONFIG_SPI_SH_HSPI=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SOC=y
+CONFIG_SND_SOC_RCAR=y
 CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_EHCI_HCD=y
-- 
1.7.9.5

