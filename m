From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 20 Oct 2015 08:57:47 +0000
Subject: [PATCH v5 0/4] phy: rcar-gen3-usb2: Add R-Car Gen3 USB2 PHY driver
Message-Id: <1445331471-5028-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kishon@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch is based on the latest linux-phy / next branch.
(commit id = 0f8669e343982ac66f4420335777cb5456b8abb0)

 Changes from v4:
  - Modify Kconfig to "depends on OF && ARCH_SHMOBILE".
  - Modify Kconfig to "select GENERIC_PHY" instead of "depends on GENERIC_PHY".
  - Modify device tree documentation about "reg" of example.
  - Remove spinlock handling because phy-core driver calls mutex_lock().
  - Change valiable name to val instead of tmp.
  - Remove dev_set_drvdata.
  - Use dev_vdbg() instead of dev_dbg().
  - Change rcar_gen3_device_recognition()'s condition as one line.
  - Remove unnecessary value in rcar_gen3_phy_usb2_probe().
  - Modify MAINTAINERS about this driver.

 Changes from v3:
  - Shorten structure names to avoid new line if we add a long function name.
  - Add ID/VBUS pin detection for peripheral mode.

 Changes from v2:
  - Modify Kconfig to add "depends on OF" and "depends on ARCH_SHMOBILE".
  - Add more information in the dt document.
  - Change reg-names from "usb2" to "usb2_host".

 Changes from v1:
  - Revise some typos.
  - Remove using clk API to enable/disable the clocks.
    (In other words, this driver expects to enable/disable the clocks by
     Runtime PM API by the phy-core driver.)
  - Remove an unnecessary header file (asm/cmpxchg.h).

Yoshihiro Shimoda (4):
  phy: rcar-gen3-usb2: Add R-Car Gen3 USB2 PHY driver
  phy: rcar-gen3-usb2: change the mode to OTG on the combined channel
  phy: rcar-gen3-usb2: add runtime ID/VBUS pin detection
  MAINTAINERS: add Renesas usb2 phy driver

 .../devicetree/bindings/phy/rcar-gen3-phy-usb2.txt |  39 +++
 MAINTAINERS                                        |   6 +
 drivers/phy/Kconfig                                |   7 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-rcar-gen3-usb2.c                   | 380 +++++++++++++++++++++
 5 files changed, 433 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
 create mode 100644 drivers/phy/phy-rcar-gen3-usb2.c

-- 
1.9.1

