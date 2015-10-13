From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 13 Oct 2015 10:22:03 +0000
Subject: [PATCH v4 0/3] phy: rcar-gen3-usb2: Add R-Car Gen3 USB2 PHY driver
Message-Id: <1444731726-5328-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kishon@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch is based on the latest linux-phy / next branch.
(commit id = 882fed73420e85c0b06447c036e3096862fc73ba)

In this v4 patch set, it has a new feature (ID/VBUS pin detection).
To ease review, I don't add this intp the patch 1/3. If I should add
it into the patch 1/3, please let me know!

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

Yoshihiro Shimoda (3):
  phy: rcar-gen3-usb2: Add R-Car Gen3 USB2 PHY driver
  phy: rcar-gen3-usb2: change the mode to OTG on the combined channel
  phy: rcar-gen3-usb2: add runtime ID/VBUS pin detection

 .../devicetree/bindings/phy/rcar-gen3-phy-usb2.txt |  39 ++
 drivers/phy/Kconfig                                |   8 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-rcar-gen3-usb2.c                   | 403 +++++++++++++++++++++
 4 files changed, 451 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
 create mode 100644 drivers/phy/phy-rcar-gen3-usb2.c

-- 
1.9.1

