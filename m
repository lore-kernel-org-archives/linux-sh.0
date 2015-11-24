From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 24 Nov 2015 06:16:42 +0000
Subject: RE: [PATCH v5 0/4] phy: rcar-gen3-usb2: Add R-Car Gen3 USB2 PHY driver
Message-Id: <SG2PR06MB0919EE202A7433E471268093D8060@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1445331471-5028-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1445331471-5028-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "kishon@ti.com" <kishon@ti.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>

Hi Kishon,

> From: Yoshihiro Shimoda
> Sent: Tuesday, October 20, 2015 5:58 PM
> 
> This patch is based on the latest linux-phy / next branch.
> (commit id = 0f8669e343982ac66f4420335777cb5456b8abb0)

Would you review this patch set?
I confirmed the patch set could apply the latest linux-phy / next branch correctly.
(commit id = 8005c49d9aea74d382f474ce11afbbc7d7130bec)

Best regards,
Yoshihiro Shimoda

>  Changes from v4:
>   - Modify Kconfig to "depends on OF && ARCH_SHMOBILE".
>   - Modify Kconfig to "select GENERIC_PHY" instead of "depends on GENERIC_PHY".
>   - Modify device tree documentation about "reg" of example.
>   - Remove spinlock handling because phy-core driver calls mutex_lock().
>   - Change valiable name to val instead of tmp.
>   - Remove dev_set_drvdata.
>   - Use dev_vdbg() instead of dev_dbg().
>   - Change rcar_gen3_device_recognition()'s condition as one line.
>   - Remove unnecessary value in rcar_gen3_phy_usb2_probe().
>   - Modify MAINTAINERS about this driver.
> 
>  Changes from v3:
>   - Shorten structure names to avoid new line if we add a long function name.
>   - Add ID/VBUS pin detection for peripheral mode.
> 
>  Changes from v2:
>   - Modify Kconfig to add "depends on OF" and "depends on ARCH_SHMOBILE".
>   - Add more information in the dt document.
>   - Change reg-names from "usb2" to "usb2_host".
> 
>  Changes from v1:
>   - Revise some typos.
>   - Remove using clk API to enable/disable the clocks.
>     (In other words, this driver expects to enable/disable the clocks by
>      Runtime PM API by the phy-core driver.)
>   - Remove an unnecessary header file (asm/cmpxchg.h).
> 
> Yoshihiro Shimoda (4):
>   phy: rcar-gen3-usb2: Add R-Car Gen3 USB2 PHY driver
>   phy: rcar-gen3-usb2: change the mode to OTG on the combined channel
>   phy: rcar-gen3-usb2: add runtime ID/VBUS pin detection
>   MAINTAINERS: add Renesas usb2 phy driver
> 
>  .../devicetree/bindings/phy/rcar-gen3-phy-usb2.txt |  39 +++
>  MAINTAINERS                                        |   6 +
>  drivers/phy/Kconfig                                |   7 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-rcar-gen3-usb2.c                   | 380 +++++++++++++++++++++
>  5 files changed, 433 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
>  create mode 100644 drivers/phy/phy-rcar-gen3-usb2.c
> 
> --
> 1.9.1

