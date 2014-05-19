From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 19 May 2014 10:21:04 +0000
Subject: Re: [PATCH 2/3] usb: host: xhci-plat: add support for the R-Car H2 and M2 xHCI controllers
Message-Id: <CANqRtoQ7k8auQzrE-YA=W+9_eOZ1iT20=RKoqQxOqyofD+Jk=g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5379D805.3070002@renesas.com>
In-Reply-To: <5379D805.3070002-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Shimoda-san,

Thanks for your patches, I did however find one typo below:

On Mon, May 19, 2014 at 7:08 PM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> The R-Car H2 and M2 SoCs come with an xHCI controller that requires
> some specific initilization related to the firmware downloading and
> some specific registers. This patch adds the support for this special
> configuration as an xHCI quirk executed during probe and start.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/usb/host/Kconfig     |    8 ++
>  drivers/usb/host/Makefile    |    3 +
>  drivers/usb/host/xhci-plat.c |   18 +++++
>  drivers/usb/host/xhci-rcar.c |  182 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/usb/host/xhci-rcar.h |   28 +++++++
>  5 files changed, 239 insertions(+)
>  create mode 100644 drivers/usb/host/xhci-rcar.c
>  create mode 100644 drivers/usb/host/xhci-rcar.h
>
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 9247ad2..229e968 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -37,6 +37,14 @@ config USB_XHCI_MVEBU
>           Say 'Y' to enable the support for the xHCI host controller
>           found in Marvell Armada 375/38x ARM SOCs.
>
> +config USB_XHCI_RCAR
> +       tristate "xHCI support for Renesas R-Car SoCs"
> +       select USB_XHCI_PLATFORM
> +       depends on ARCH_SHMOBILE || COMPILE_TEST
> +       ---help---
> +         Say 'Y' to enable the support for the xHCI host controller
> +         found in Renesas R-Car ARM SoCs.
> +
>  endif # USB_XHCI_HCD
>
>  config USB_EHCI_HCD
> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> index 7c0886a..b59ca3c 100644
> --- a/drivers/usb/host/Makefile
> +++ b/drivers/usb/host/Makefile
> @@ -22,6 +22,9 @@ ifneq ($(CONFIG_USB_XHCI_PLATFORM), )
>  ifneq ($(CONFIG_USB_XHCI_MVEBU), )
>         xhci-hcd-y              += xhci-mvebu.o
>  endif
> +ifneq ($(CONFIG_USB_XHCI_RCAR), )
> +       xhci-hcd-y              += xhci-rcar.o
> +endif
>  endif
>
>  obj-$(CONFIG_USB_WHCI_HCD)     += whci/
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 561d07e..3a2da1f 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -20,6 +20,7 @@
>
>  #include "xhci.h"
>  #include "xhci-mvebu.h"
> +#include "xhci-rcar.h"
>
>  static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
>  {
> @@ -39,6 +40,12 @@ static int xhci_plat_setup(struct usb_hcd *hcd)
>
>  static int xhci_plat_start(struct usb_hcd *hcd)
>  {
> +       struct device_node *of_node = hcd->self.controller->of_node;
> +
> +       if (of_device_is_compatible(of_node, "renesas,r8a7790-xhci") ||
> +           of_device_is_compatible(of_node, "renesas,r8a7790-xhci"))
> +               xhci_rcar_start(hcd);
> +

This is most likely a typo - I believe this is supposed to be r8a7790
and r8a7791?

Cheers,

/ magnus
