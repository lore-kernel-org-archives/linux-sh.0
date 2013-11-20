From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Wed, 20 Nov 2013 17:37:57 +0000
Subject: [PATCH 0/9] USB 2.0 host on Lager
Message-Id: <1384969086-8920-1-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This is a collection of patches developed by Valentine Barshak towards
support of the PCI-attached USB 2.0 host controllers on Lager, with some
glue supplied by me:

- added missing PCI host clock (MSTP703)
- bound PCI USB HCIs to the USB phy
- added PCI host platform devices on Lager

I chose to do incremental patches on top of Valentine's stuff because his
patches are already in various states of upstream acceptance; please tell me
if you need this packaged differently.

CU
Uli

Ulrich Hecht (4):
  pci: rcar-gen2: enable clock
  ARM: shmobile: r8a7790: add internal PCI clock
  usb: phy: rcar-gen2: register using usb_add_phy_dev()
  ARM: shmobile: lager: add PCI USB host controllers

Valentine Barshak (5):
  pci: Add R-Car Gen2 internal PCI support
  usb: hcd: Remove USB phy if needed
  usb: hcd: Initialize USB phy if needed
  usb: phy: Add RCAR Gen2 USB phy
  arm: shmobile: lager: Add USBHS support

 arch/arm/mach-shmobile/Kconfig                  |   1 +
 arch/arm/mach-shmobile/board-lager.c            | 138 ++++++++++
 arch/arm/mach-shmobile/clock-r8a7790.c          |   5 +-
 drivers/pci/host/Kconfig                        |   8 +
 drivers/pci/host/Makefile                       |   1 +
 drivers/pci/host/pci-rcar-gen2.c                | 347 ++++++++++++++++++++++++
 drivers/usb/core/hcd.c                          |  34 ++-
 drivers/usb/phy/Kconfig                         |  13 +
 drivers/usb/phy/Makefile                        |   1 +
 drivers/usb/phy/phy-rcar-gen2-usb.c             | 249 +++++++++++++++++
 include/linux/platform_data/usb-rcar-gen2-phy.h |  22 ++
 include/linux/usb/hcd.h                         |   1 +
 12 files changed, 818 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pci/host/pci-rcar-gen2.c
 create mode 100644 drivers/usb/phy/phy-rcar-gen2-usb.c
 create mode 100644 include/linux/platform_data/usb-rcar-gen2-phy.h

-- 
1.8.4

