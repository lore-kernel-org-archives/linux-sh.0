From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 27 Aug 2015 09:24:02 +0000
Subject: [PATCH/RFC 02/10] arm64: defconfig: Enable GPIO of Renesas R-Car Gen3 SoC
Message-Id: <1440667450-3513-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

Enable GPIO for  Renesas R-Car Gen3 SoC via the following options:
  - GPIO_SYSFS
  - GPIO_RCAR
  - LEDS_GPIO

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[horms: updated changelog]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a2ddca9c632b..e7b638eb5059 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -124,7 +124,9 @@ CONFIG_VIRTIO_CONSOLE=y
 CONFIG_SPI=y
 CONFIG_SPI_PL022=y
 CONFIG_PINCTRL_MSM8916=y
+CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_PL061=y
+CONFIG_GPIO_RCAR=y
 CONFIG_GPIO_XGENE=y
 CONFIG_POWER_RESET_XGENE=y
 CONFIG_POWER_RESET_SYSCON=y
@@ -152,6 +154,7 @@ CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SPI=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_SYSCON=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
-- 
2.1.4

