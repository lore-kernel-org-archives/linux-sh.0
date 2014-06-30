From: Felipe Balbi <balbi@ti.com>
Date: Mon, 30 Jun 2014 17:16:57 +0000
Subject: Re: [PATCH v6 1/1] usb: host: xhci-plat: add support for the R-Car H2 and M2 xHCI controllers
Message-Id: <20140630171657.GH31442@saruman.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="zhtSGe8h3+lMyY1M"
List-Id: <linux-sh.vger.kernel.org>
References: <539AEC8F.4030003@renesas.com>
 <20140613142525.GE8319@saruman.home>
 <CANqRtoRy=mzosq4F-PF9_HRWK8pV66TmV1u-0cSLELAGtkfbsg@mail.gmail.com>
 <20140627154021.GH8069@saruman.home>
 <CANqRtoTfvM95b1kYNXFj9GmOewt2WPb+4UMqKonkDXC8FZq6Sg@mail.gmail.com>
In-Reply-To: <CANqRtoTfvM95b1kYNXFj9GmOewt2WPb+4UMqKonkDXC8FZq6Sg@mail.gmail.com>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "mathias.nyman@intel.com" <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

--zhtSGe8h3+lMyY1M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 29, 2014 at 11:33:52PM +0900, Magnus Damm wrote:
> On Sat, Jun 28, 2014 at 12:40 AM, Felipe Balbi <balbi@ti.com> wrote:
> > On Wed, Jun 18, 2014 at 02:15:42PM +0900, Magnus Damm wrote:
> >> Hi Felipe,
> >>
> >> On Fri, Jun 13, 2014 at 11:25 PM, Felipe Balbi <balbi@ti.com> wrote:
> >> > Hi,
> >> >
> >> > On Fri, Jun 13, 2014 at 09:20:31PM +0900, Yoshihiro Shimoda wrote:
> >> >> The R-Car H2 and M2 SoCs come with an xHCI controller that requires
> >> >> some specific initializations related to the firmware downloading a=
nd
> >> >> some specific registers. This patch adds the support for this speci=
al
> >> >> configuration as an xHCI quirk executed during probe and start.
> >> >>
> >> >> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >> >> ---
> >>
> >> >> diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-r=
car.c
> >> >> new file mode 100644
> >> >> index 0000000..ff0d1b4
> >> >> --- /dev/null
> >> >> +++ b/drivers/usb/host/xhci-rcar.c
> >> >> @@ -0,0 +1,148 @@
> >> >> +/*
> >> >> + * xHCI host controller driver for R-Car SoCs
> >> >> + *
> >> >> + * Copyright (C) 2014 Renesas Electronics Corporation
> >> >> + *
> >> >> + * This program is free software; you can redistribute it and/or
> >> >> + * modify it under the terms of the GNU General Public License
> >> >> + * version 2 as published by the Free Software Foundation.
> >> >> + */
> >> >> +
> >> >> +#include <linux/firmware.h>
> >> >> +#include <linux/module.h>
> >> >> +#include <linux/platform_device.h>
> >> >> +#include <linux/usb/phy.h>
> >> >> +
> >> >> +#include "xhci.h"
> >> >> +#include "xhci-rcar.h"
> >> >> +
> >> >> +#define FIRMWARE_NAME                "r8a779x_usb3_v1.dlmem"
> >> >> +MODULE_FIRMWARE(FIRMWARE_NAME);
> >> >> +
> >> >> +/*** Register Offset ***/
> >> >> +#define RCAR_USB3_INT_ENA    0x224   /* Interrupt Enable */
> >> >> +#define RCAR_USB3_DL_CTRL    0x250   /* FW Download Control & Stat=
us */
> >> >> +#define RCAR_USB3_FW_DATA0   0x258   /* FW Data0 */
> >> >> +
> >> >> +#define RCAR_USB3_LCLK               0xa44   /* LCLK Select */
> >> >> +#define RCAR_USB3_CONF1              0xa48   /* USB3.0 Configurati=
on1 */
> >> >> +#define RCAR_USB3_CONF2              0xa5c   /* USB3.0 Configurati=
on2 */
> >> >> +#define RCAR_USB3_CONF3              0xaa8   /* USB3.0 Configurati=
on3 */
> >> >> +#define RCAR_USB3_RX_POL     0xab0   /* USB3.0 RX Polarity */
> >> >> +#define RCAR_USB3_TX_POL     0xab8   /* USB3.0 TX Polarity */
> >> >> +
> >> >> +/*** Register Settings ***/
> >> >> +/* Interrupt Enable */
> >> >> +#define RCAR_USB3_INT_XHC_ENA        0x00000001
> >> >> +#define RCAR_USB3_INT_PME_ENA        0x00000002
> >> >> +#define RCAR_USB3_INT_HSE_ENA        0x00000004
> >> >> +#define RCAR_USB3_INT_ENA_VAL        (RCAR_USB3_INT_XHC_ENA | \
> >> >> +                             RCAR_USB3_INT_PME_ENA | RCAR_USB3_INT=
_HSE_ENA)
> >> >> +
> >> >> +/* FW Download Control & Status */
> >> >> +#define RCAR_USB3_DL_CTRL_ENABLE     0x00000001
> >> >> +#define RCAR_USB3_DL_CTRL_FW_SUCCESS 0x00000010
> >> >> +#define RCAR_USB3_DL_CTRL_FW_SET_DATA0       0x00000100
> >> >> +
> >> >> +/* LCLK Select */
> >> >> +#define RCAR_USB3_LCLK_ENA_VAL       0x01030001
> >> >> +
> >> >> +/* USB3.0 Configuration */
> >> >> +#define RCAR_USB3_CONF1_VAL  0x00030204
> >> >> +#define RCAR_USB3_CONF2_VAL  0x00030300
> >> >> +#define RCAR_USB3_CONF3_VAL  0x13802007
> >> >> +
> >> >> +/* USB3.0 Polarity */
> >> >> +#define RCAR_USB3_RX_POL_VAL BIT(21)
> >> >> +#define RCAR_USB3_TX_POL_VAL BIT(4)
> >> >> +
> >> >> +void xhci_rcar_start(struct usb_hcd *hcd)
> >> >> +{
> >> >> +     u32 temp;
> >> >> +
> >> >> +     if (hcd->regs !=3D NULL) {
> >> >> +             /* Interrupt Enable */
> >> >> +             temp =3D readl(hcd->regs + RCAR_USB3_INT_ENA);
> >> >> +             temp |=3D RCAR_USB3_INT_ENA_VAL;
> >> >> +             writel(temp, hcd->regs + RCAR_USB3_INT_ENA);
> >> >> +             /* LCLK Select */
> >> >> +             writel(RCAR_USB3_LCLK_ENA_VAL, hcd->regs + RCAR_USB3_=
LCLK);
> >> >> +             /* USB3.0 Configuration */
> >> >> +             writel(RCAR_USB3_CONF1_VAL, hcd->regs + RCAR_USB3_CON=
F1);
> >> >> +             writel(RCAR_USB3_CONF2_VAL, hcd->regs + RCAR_USB3_CON=
F2);
> >> >> +             writel(RCAR_USB3_CONF3_VAL, hcd->regs + RCAR_USB3_CON=
F3);
> >> >> +             /* USB3.0 Polarity */
> >> >> +             writel(RCAR_USB3_RX_POL_VAL, hcd->regs + RCAR_USB3_RX=
_POL);
> >> >> +             writel(RCAR_USB3_TX_POL_VAL, hcd->regs + RCAR_USB3_TX=
_POL);
> >> >> +     }
> >> >> +}
> >> >> +
> >> >> +static int xhci_rcar_download_firmware(struct device *dev, void __=
iomem *regs)
> >> >> +{
> >> >> +     const struct firmware *fw;
> >> >> +     int retval, index, j, time;
> >> >> +     int timeout =3D 10000;
> >> >> +     u32 data, val, temp;
> >> >> +
> >> >> +     /* request R-Car USB3.0 firmware */
> >> >> +     retval =3D request_firmware(&fw, FIRMWARE_NAME, dev);
> >> >> +     if (retval)
> >> >> +             return retval;
> >> >> +
> >> >> +     /* download R-Car USB3.0 firmware */
> >> >> +     temp =3D readl(regs + RCAR_USB3_DL_CTRL);
> >> >> +     temp |=3D RCAR_USB3_DL_CTRL_ENABLE;
> >> >> +     writel(temp, regs + RCAR_USB3_DL_CTRL);
> >> >> +
> >> >> +     for (index =3D 0; index < fw->size; index +=3D 4) {
> >> >> +             /* to avoid reading beyond the end of the buffer */
> >> >> +             for (data =3D 0, j =3D 3; j >=3D 0; j--) {
> >> >> +                     if ((j + index) < fw->size)
> >> >> +                             data |=3D fw->data[index + j] << (8 *=
 j);
> >> >> +             }
> >> >> +             writel(data, regs + RCAR_USB3_FW_DATA0);
> >> >> +             temp =3D readl(regs + RCAR_USB3_DL_CTRL);
> >> >> +             temp |=3D RCAR_USB3_DL_CTRL_FW_SET_DATA0;
> >> >> +             writel(temp, regs + RCAR_USB3_DL_CTRL);
> >> >> +
> >> >> +             for (time =3D 0; time < timeout; time++) {
> >> >> +                     val =3D readl(regs + RCAR_USB3_DL_CTRL);
> >> >> +                     if ((val & RCAR_USB3_DL_CTRL_FW_SET_DATA0) =
=3D=3D 0)
> >> >> +                             break;
> >> >> +                     udelay(1);
> >> >> +             }
> >> >> +             if (time =3D=3D timeout) {
> >> >> +                     retval =3D -ETIMEDOUT;
> >> >> +                     break;
> >> >> +             }
> >> >> +     }
> >> >> +
> >> >> +     temp =3D readl(regs + RCAR_USB3_DL_CTRL);
> >> >> +     temp &=3D ~RCAR_USB3_DL_CTRL_ENABLE;
> >> >> +     writel(temp, regs + RCAR_USB3_DL_CTRL);
> >> >> +
> >> >> +     for (time =3D 0; time < timeout; time++) {
> >> >> +             val =3D readl(regs + RCAR_USB3_DL_CTRL);
> >> >> +             if (val & RCAR_USB3_DL_CTRL_FW_SUCCESS) {
> >> >> +                     retval =3D 0;
> >> >> +                     break;
> >> >> +             }
> >> >> +             udelay(1);
> >> >> +     }
> >> >> +     if (time =3D=3D timeout)
> >> >> +             retval =3D -ETIMEDOUT;
> >> >> +
> >> >> +     release_firmware(fw);
> >> >> +
> >> >> +     return retval;
> >> >> +}
> >> >> +
> >> >> +/* This function needs to initialize a "phy" of usb before */
> >> >
> >> > initializing a PHY looks like something that the PHY layer should do.
> >> > Why don't you write a PHY driver and teach xhci-core about PHYs ? Th=
en,
> >> > more people would benefit.
> >>
> >> Could you please clarify what you would like Shimoda-san to do?
> >>
> >> Like Ben and Shimoda-san mentioned, there is already a PHY driver
> >> developed for this SoC. The PHY driver is however shared in various
> >> ways. For example, on one particular SoC the same PHY driver is
> >> interfacing to a total of 3 different variants of USB controllers
> >> where XHCI is one of them. And to make things even more complicated,
> >> depending on SoC variant the XHCI hardware may or may not be available
> >> - but the PHY portion is more or less the same.
> >>
> >> Putting the firmware loader in the XHCI driver like this at least
> >> keeps it together with the rest of the XHCI stuff and also makes it
> >> possible to easily access the XHCI I/O register window for firmware
> >> loading. Moving the firmware loading to the PHY driver however
> >> complicates the situation when it comes to Kconfig handling of XHCI
> >> and PHY driver and also forces the PHY driver to access the XHCI
> >> hardware I/O registers for firmware loading...
> >
> > But the firmware is being loaded into the PHY registers, no ? In that
> > case, it should sit in the PHY driver.
>=20
> The firmware is not loaded into the PHY registers. It is loaded into
> what is considered XHCI registers by the documentation.

oh, my bad. I misinterpreted. I withdraw my comment then.

--=20
balbi

--zhtSGe8h3+lMyY1M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTsZuJAAoJEIaOsuA1yqREKiAP/jM8TunZqtaNmnwLXEi+ZdlR
AV7HXPIta+mXYc0LQpErsQV4AeIuy0mrc8AsoaG4OJioT0VFncC3nT6450fVWJD8
913X5L2u+Ck2/L77n7/6uCDIcmZXEkRneIYQWv1VGAuat1vAqIX3NnNEyoZnSp/v
3roh0K61kJvWlFcEXo4G5E1rCGq/CGZOXYCjwof7j4C2zRsHZwDt7hsGalxwpsuj
QHKxVelA0F/F+P3buT6SKLRZFqC+Qtjb/wDiVsvyB+d3eDI5RXHV5hzAdfAFFZbs
ULBZLneFLIYAD71Z3j2RoLjewCPw7UjM8tSRmuTmt4x6LzOTh1ZvRhEk3QgA6weC
8bUZwWyfS1Tig5aFZvP6RHHRkcPUp8aT6modNEKiNDo4IXZDxEx9VI9HuL31lqhN
hUUHVWqhg/2KNfnfdnPf6OcGNTWKq23T5oILJveVg08yNIxXJ4hqU6/slEjMf61u
lFkaCwGjerhIEvY7IrlSXyl6pLIVtlr+WJ8307HgVufJO2mowyaG6P7oJ8PoYSBS
l4HdDZAVUYEU2qPye5p6lIST9Vo2OFPYKQ/SqxZ38Uu0Zrf9D8QBBpXv6NyIe4lf
QqOubeRLbBxPk+wxDVkLJWRKaVqt80lZuxlPME3cxGbzQSKtFwHi6mxBveWqFAHh
wpi74qHFXVKn+sZXlp+h
=D4yN
-----END PGP SIGNATURE-----

--zhtSGe8h3+lMyY1M--
