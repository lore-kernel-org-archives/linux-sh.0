From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 25 Jul 2014 14:40:44 +0000
Subject: [PATCH 0/6] r8a7794 driver enablement
Message-Id: <1406299250-23975-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This is a bunch of slightly brushed up driver enablements for the r8a7794
from the BSP.

CU
Uli

Hisashi Nakamura (3):
  net: sh_eth: Add r8a7794 support
  gpio: rcar: Add r8a7794 support
  clk: shmobile: Add r8a7794 support

Koji Matsuoka (1):
  media: soc_camera: rcar_vin: Add r8a7794 device support

Shinobu Uehara (2):
  mmc: sh_mobile_sdhi: Update sh_mobile_sdhi_of_data for r8a7794
  usb: phy: Add Renesas R-Car Gen2 USB PHY support for r8a7794

 Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt | 1 +
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt           | 2 ++
 Documentation/devicetree/bindings/net/sh_eth.txt             | 1 +
 drivers/clk/shmobile/Makefile                                | 1 +
 drivers/gpio/gpio-rcar.c                                     | 6 ++++++
 drivers/media/platform/soc_camera/rcar_vin.c                 | 1 +
 drivers/mmc/host/sh_mobile_sdhi.c                            | 1 +
 drivers/net/ethernet/renesas/sh_eth.c                        | 2 ++
 drivers/usb/phy/Kconfig                                      | 4 ++--
 9 files changed, 17 insertions(+), 2 deletions(-)

-- 
1.8.4.5

