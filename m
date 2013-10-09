From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Wed, 09 Oct 2013 22:14:44 +0000
Subject: [PATCH 0/3] Add USBHS support to Lager (take 3)
Message-Id: <1381356887-15564-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1381261407-12606-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1381261407-12606-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch set adds internal USB PHY support to RCAR Gen2 SoC, and
also enables USBHS for the Lager board. It has been updated, based
on the comments to the previous version.

The patches apply fine to the renesas-devel-20131009v2 tag of the renesas.git.
The first patch also applies fine to the usb.git at kernel.org.
It adds RCAR Gen2 phy driver which is used to configure the shared USB
channels 0/2 and to control USBHS internal PHY.
All the drivers that use the shared USB channels (USBHS/USBSS/PCI USB host)
should acquire the USB phy first to set proper channel configuration.

The other two patches add USBHS support to Lager board, which requires
RCAR Gen2 phy driver.

Changes from version 2:
* added COMPILE_TEST support to phy-rcar-gen2-usb;
* sorted phy-rcar-gen2-usb.c includes in the alphabetical order;
* dropped unnecessary checks and error messages
  in the phy-rcar-gen2 probe callback.

Changes from version 1:
* use-counting and clock handling done in the usb_phy_init/shutdown
  callbacks only;
* a minor typo in the comments fixed;
* phy clean up moved to __rcar_gen2_usb_phy_shutdown function;
* usb_phy_init/shutdown called from usbhs_power_ctrl callback
  to allow renesas_usbhs driver disable USB PHY completely
  when it is not needed.

Valentine Barshak (3):
  usb: phy: Add RCAR Gen2 USB phy
  arm: shmobile: r8a7790: Add USBHS clock support
  arm: shmobile: lager: Add USBHS support

 arch/arm/mach-shmobile/board-lager.c            | 106 ++++++++++
 arch/arm/mach-shmobile/clock-r8a7790.c          |   4 +
 drivers/usb/phy/Kconfig                         |  13 ++
 drivers/usb/phy/Makefile                        |   1 +
 drivers/usb/phy/phy-rcar-gen2-usb.c             | 255 ++++++++++++++++++++++++
 include/linux/platform_data/usb-rcar-gen2-phy.h |  22 ++
 6 files changed, 401 insertions(+)
 create mode 100644 drivers/usb/phy/phy-rcar-gen2-usb.c
 create mode 100644 include/linux/platform_data/usb-rcar-gen2-phy.h

-- 
1.8.3.1

