From: Felipe Balbi <balbi@ti.com>
Date: Fri, 27 Jun 2014 15:40:21 +0000
Subject: Re: [PATCH v6 1/1] usb: host: xhci-plat: add support for the R-Car H2 and M2 xHCI controllers
Message-Id: <20140627154021.GH8069@saruman.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="svZFHVx8/dhPCe52"
List-Id: <linux-sh.vger.kernel.org>
References: <539AEC8F.4030003@renesas.com>
 <20140613142525.GE8319@saruman.home>
 <CANqRtoRy=mzosq4F-PF9_HRWK8pV66TmV1u-0cSLELAGtkfbsg@mail.gmail.com>
In-Reply-To: <CANqRtoRy=mzosq4F-PF9_HRWK8pV66TmV1u-0cSLELAGtkfbsg@mail.gmail.com>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "mathias.nyman@intel.com" <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

--svZFHVx8/dhPCe52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2014 at 02:15:42PM +0900, Magnus Damm wrote:
> Hi Felipe,
>=20
> On Fri, Jun 13, 2014 at 11:25 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
> > On Fri, Jun 13, 2014 at 09:20:31PM +0900, Yoshihiro Shimoda wrote:
> >> The R-Car H2 and M2 SoCs come with an xHCI controller that requires
> >> some specific initializations related to the firmware downloading and
> >> some specific registers. This patch adds the support for this special
> >> configuration as an xHCI quirk executed during probe and start.
> >>
> >> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >> ---
>=20
> >> diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar=
=2Ec
> >> new file mode 100644
> >> index 0000000..ff0d1b4
> >> --- /dev/null
> >> +++ b/drivers/usb/host/xhci-rcar.c
> >> @@ -0,0 +1,148 @@
> >> +/*
> >> + * xHCI host controller driver for R-Car SoCs
> >> + *
> >> + * Copyright (C) 2014 Renesas Electronics Corporation
> >> + *
> >> + * This program is free software; you can redistribute it and/or
> >> + * modify it under the terms of the GNU General Public License
> >> + * version 2 as published by the Free Software Foundation.
> >> + */
> >> +
> >> +#include <linux/firmware.h>
> >> +#include <linux/module.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/usb/phy.h>
> >> +
> >> +#include "xhci.h"
> >> +#include "xhci-rcar.h"
> >> +
> >> +#define FIRMWARE_NAME                "r8a779x_usb3_v1.dlmem"
> >> +MODULE_FIRMWARE(FIRMWARE_NAME);
> >> +
> >> +/*** Register Offset ***/
> >> +#define RCAR_USB3_INT_ENA    0x224   /* Interrupt Enable */
> >> +#define RCAR_USB3_DL_CTRL    0x250   /* FW Download Control & Status =
*/
> >> +#define RCAR_USB3_FW_DATA0   0x258   /* FW Data0 */
> >> +
> >> +#define RCAR_USB3_LCLK               0xa44   /* LCLK Select */
> >> +#define RCAR_USB3_CONF1              0xa48   /* USB3.0 Configuration1=
 */
> >> +#define RCAR_USB3_CONF2              0xa5c   /* USB3.0 Configuration2=
 */
> >> +#define RCAR_USB3_CONF3              0xaa8   /* USB3.0 Configuration3=
 */
> >> +#define RCAR_USB3_RX_POL     0xab0   /* USB3.0 RX Polarity */
> >> +#define RCAR_USB3_TX_POL     0xab8   /* USB3.0 TX Polarity */
> >> +
> >> +/*** Register Settings ***/
> >> +/* Interrupt Enable */
> >> +#define RCAR_USB3_INT_XHC_ENA        0x00000001
> >> +#define RCAR_USB3_INT_PME_ENA        0x00000002
> >> +#define RCAR_USB3_INT_HSE_ENA        0x00000004
> >> +#define RCAR_USB3_INT_ENA_VAL        (RCAR_USB3_INT_XHC_ENA | \
> >> +                             RCAR_USB3_INT_PME_ENA | RCAR_USB3_INT_HS=
E_ENA)
> >> +
> >> +/* FW Download Control & Status */
> >> +#define RCAR_USB3_DL_CTRL_ENABLE     0x00000001
> >> +#define RCAR_USB3_DL_CTRL_FW_SUCCESS 0x00000010
> >> +#define RCAR_USB3_DL_CTRL_FW_SET_DATA0       0x00000100
> >> +
> >> +/* LCLK Select */
> >> +#define RCAR_USB3_LCLK_ENA_VAL       0x01030001
> >> +
> >> +/* USB3.0 Configuration */
> >> +#define RCAR_USB3_CONF1_VAL  0x00030204
> >> +#define RCAR_USB3_CONF2_VAL  0x00030300
> >> +#define RCAR_USB3_CONF3_VAL  0x13802007
> >> +
> >> +/* USB3.0 Polarity */
> >> +#define RCAR_USB3_RX_POL_VAL BIT(21)
> >> +#define RCAR_USB3_TX_POL_VAL BIT(4)
> >> +
> >> +void xhci_rcar_start(struct usb_hcd *hcd)
> >> +{
> >> +     u32 temp;
> >> +
> >> +     if (hcd->regs !=3D NULL) {
> >> +             /* Interrupt Enable */
> >> +             temp =3D readl(hcd->regs + RCAR_USB3_INT_ENA);
> >> +             temp |=3D RCAR_USB3_INT_ENA_VAL;
> >> +             writel(temp, hcd->regs + RCAR_USB3_INT_ENA);
> >> +             /* LCLK Select */
> >> +             writel(RCAR_USB3_LCLK_ENA_VAL, hcd->regs + RCAR_USB3_LCL=
K);
> >> +             /* USB3.0 Configuration */
> >> +             writel(RCAR_USB3_CONF1_VAL, hcd->regs + RCAR_USB3_CONF1);
> >> +             writel(RCAR_USB3_CONF2_VAL, hcd->regs + RCAR_USB3_CONF2);
> >> +             writel(RCAR_USB3_CONF3_VAL, hcd->regs + RCAR_USB3_CONF3);
> >> +             /* USB3.0 Polarity */
> >> +             writel(RCAR_USB3_RX_POL_VAL, hcd->regs + RCAR_USB3_RX_PO=
L);
> >> +             writel(RCAR_USB3_TX_POL_VAL, hcd->regs + RCAR_USB3_TX_PO=
L);
> >> +     }
> >> +}
> >> +
> >> +static int xhci_rcar_download_firmware(struct device *dev, void __iom=
em *regs)
> >> +{
> >> +     const struct firmware *fw;
> >> +     int retval, index, j, time;
> >> +     int timeout =3D 10000;
> >> +     u32 data, val, temp;
> >> +
> >> +     /* request R-Car USB3.0 firmware */
> >> +     retval =3D request_firmware(&fw, FIRMWARE_NAME, dev);
> >> +     if (retval)
> >> +             return retval;
> >> +
> >> +     /* download R-Car USB3.0 firmware */
> >> +     temp =3D readl(regs + RCAR_USB3_DL_CTRL);
> >> +     temp |=3D RCAR_USB3_DL_CTRL_ENABLE;
> >> +     writel(temp, regs + RCAR_USB3_DL_CTRL);
> >> +
> >> +     for (index =3D 0; index < fw->size; index +=3D 4) {
> >> +             /* to avoid reading beyond the end of the buffer */
> >> +             for (data =3D 0, j =3D 3; j >=3D 0; j--) {
> >> +                     if ((j + index) < fw->size)
> >> +                             data |=3D fw->data[index + j] << (8 * j);
> >> +             }
> >> +             writel(data, regs + RCAR_USB3_FW_DATA0);
> >> +             temp =3D readl(regs + RCAR_USB3_DL_CTRL);
> >> +             temp |=3D RCAR_USB3_DL_CTRL_FW_SET_DATA0;
> >> +             writel(temp, regs + RCAR_USB3_DL_CTRL);
> >> +
> >> +             for (time =3D 0; time < timeout; time++) {
> >> +                     val =3D readl(regs + RCAR_USB3_DL_CTRL);
> >> +                     if ((val & RCAR_USB3_DL_CTRL_FW_SET_DATA0) =3D=
=3D 0)
> >> +                             break;
> >> +                     udelay(1);
> >> +             }
> >> +             if (time =3D=3D timeout) {
> >> +                     retval =3D -ETIMEDOUT;
> >> +                     break;
> >> +             }
> >> +     }
> >> +
> >> +     temp =3D readl(regs + RCAR_USB3_DL_CTRL);
> >> +     temp &=3D ~RCAR_USB3_DL_CTRL_ENABLE;
> >> +     writel(temp, regs + RCAR_USB3_DL_CTRL);
> >> +
> >> +     for (time =3D 0; time < timeout; time++) {
> >> +             val =3D readl(regs + RCAR_USB3_DL_CTRL);
> >> +             if (val & RCAR_USB3_DL_CTRL_FW_SUCCESS) {
> >> +                     retval =3D 0;
> >> +                     break;
> >> +             }
> >> +             udelay(1);
> >> +     }
> >> +     if (time =3D=3D timeout)
> >> +             retval =3D -ETIMEDOUT;
> >> +
> >> +     release_firmware(fw);
> >> +
> >> +     return retval;
> >> +}
> >> +
> >> +/* This function needs to initialize a "phy" of usb before */
> >
> > initializing a PHY looks like something that the PHY layer should do.
> > Why don't you write a PHY driver and teach xhci-core about PHYs ? Then,
> > more people would benefit.
>=20
> Could you please clarify what you would like Shimoda-san to do?
>=20
> Like Ben and Shimoda-san mentioned, there is already a PHY driver
> developed for this SoC. The PHY driver is however shared in various
> ways. For example, on one particular SoC the same PHY driver is
> interfacing to a total of 3 different variants of USB controllers
> where XHCI is one of them. And to make things even more complicated,
> depending on SoC variant the XHCI hardware may or may not be available
> - but the PHY portion is more or less the same.
>=20
> Putting the firmware loader in the XHCI driver like this at least
> keeps it together with the rest of the XHCI stuff and also makes it
> possible to easily access the XHCI I/O register window for firmware
> loading. Moving the firmware loading to the PHY driver however
> complicates the situation when it comes to Kconfig handling of XHCI
> and PHY driver and also forces the PHY driver to access the XHCI
> hardware I/O registers for firmware loading...

But the firmware is being loaded into the PHY registers, no ? In that
case, it should sit in the PHY driver.

--=20
balbi

--svZFHVx8/dhPCe52
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTrZBlAAoJEIaOsuA1yqREjosP/Ailim1SOGO/mN7iwGOlDtLt
3iJc9sm+Xif0w1bifihd1ZDEmsflU5yUcsOfrl7nF532z+ZKfbGJUd8y3tTXPmRc
e5xfVXvO8Xfei11At5Sv8j9YifqYaB+Hxk14QxB3tVF8HxhwC++0hq/lOV5YCdTE
q12qUQoEYL0OBR4DDctb729b8x2e6NbBPdeb4A0uJdnbvhnDPHtMAKxkc4WKBKB9
tMG6JbkoKfZqF0T3XTU01Xpcwbpn2Axqah4NJ9Gq3/GKqIjiefZgcNI1PdaMVlDV
GNXdbe3CXDjJV3XbihOF40hMUzSTOTMPwCFSc5cdjs/IOoSoqDnpovAOn+MaeU3P
L4dhw1su2dNc5pBKJii83UPN2yLZCADR0xZed/w4aBMyWq7U4WRmjAOxe7fleUJ8
tQkmft5S0inTwjZdoOQITWoMj5uKcLAMCqg1K6iv/9TwBSH5hul8davoCs5/FbqB
BRKFXpc9Avg0IXFFtAWBZ9JK7jjV5BNW1kG+Yeqi4BKJX3vJ1u4CfYsYYz6xTPTJ
u7uao0TM6xrrh6EuVP+cu4HX2VyQSJRvF+sns+zb7a2xFjpSkuk+AVS4d/GRu8JP
fUrED0F7k7xe/p9/a0CPzN0y/naxf+mZbmeUUutYyxL7arhiCWZ+3bD8DuPV/5iU
/ubcGho5d8ck0XixDhrK
=1zl4
-----END PGP SIGNATURE-----

--svZFHVx8/dhPCe52--
