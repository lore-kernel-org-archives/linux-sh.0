From: Lucas Stach <l.stach@pengutronix.de>
Date: Fri, 28 Feb 2014 17:28:36 +0000
Subject: [PATCH 0/7] PCI irq mapping fixes and cleanups
Message-Id: <1393608523-17509-1-git-send-email-l.stach@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This series cleans up the PCI irq mapping for all
the ARM PCI host drivers, so they handle it in the
way defined in the common PCI bindings.

Testing appreciated.

Lucas Stach (7):
  ARM: dts: tegra: add PCIe interrupt mapping properties
  PCI: tegra: use new OF interrupt mapping when possible
  PCI: rcar: use new OF interrupt mapping when possible
  ARM: dts: exynos5440: fix PCIe interrupt mapping
  ARM: dts: imx6: add PCIe interrupt mapping properties
  PCI: designware: use new OF interrupt mapping when possible
  PCI: designware: split samsung and fsl bindings

 .../devicetree/bindings/pci/designware-pcie.txt    | 69 +--------------------
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     | 48 +++++++++++++++
 .../bindings/pci/nvidia,tegra20-pcie.txt           |  8 +++
 .../bindings/pci/samsung,exynos5440-pcie.txt       | 70 ++++++++++++++++++++++
 arch/arm/boot/dts/exynos5440.dtsi                  |  4 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     | 11 ++++
 arch/arm/boot/dts/tegra20.dtsi                     |  4 ++
 arch/arm/boot/dts/tegra30.dtsi                     |  4 ++
 drivers/pci/host/pci-rcar-gen2.c                   |  8 ++-
 drivers/pci/host/pci-tegra.c                       |  7 ++-
 drivers/pci/host/pcie-designware.c                 |  8 ++-
 11 files changed, 168 insertions(+), 73 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt

-- 
1.8.5.3

