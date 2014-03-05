From: Lucas Stach <l.stach@pengutronix.de>
Date: Wed, 05 Mar 2014 13:25:45 +0000
Subject: [PATCH v2 0/6] PCI irq mapping fixes and cleanups
Message-Id: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This series cleans up the PCI irq mapping for all
the ARM PCI host drivers, so they handle it in the
way defined in the common PCI bindings.

I've worked in all the feedback I received on the first
round of this series and left out the i.MX pcie driver
changes, as these need more work includig breaking
of the existing binding, which I'll send as a separate
series.

Lucas Stach (6):
  ARM: dts: tegra: add PCIe interrupt mapping properties
  PCI: tegra: use new OF interrupt mapping when possible
  PCI: rcar: use new OF interrupt mapping when possible
  ARM: dts: exynos5440: fix PCIe interrupt mapping
  ARM: dts: imx6: add PCIe interrupt mapping properties
  PCI: designware: use new OF interrupt mapping when possible

 .../devicetree/bindings/pci/nvidia,tegra20-pcie.txt          |  8 ++++++++
 arch/arm/boot/dts/exynos5440.dtsi                            |  6 ++++--
 arch/arm/boot/dts/imx6qdl.dtsi                               |  8 ++++++++
 arch/arm/boot/dts/tegra20.dtsi                               |  4 ++++
 arch/arm/boot/dts/tegra30.dtsi                               |  4 ++++
 drivers/pci/host/pci-rcar-gen2.c                             | 12 +++++++++---
 drivers/pci/host/pci-tegra.c                                 |  7 ++++++-
 drivers/pci/host/pcie-designware.c                           | 12 +++++++++---
 8 files changed, 52 insertions(+), 9 deletions(-)

-- 
1.9.0

