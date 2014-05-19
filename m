From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 May 2014 11:58:48 +0000
Subject: Re: [PATCH 2/3] usb: host: xhci-plat: add support for the R-Car H2 and M2 xHCI controllers
Message-Id: <CAMuHMdUMGc_SNLWruEF=91v0Z+w6pnEpYhb4MeU+NEk=Dfi5Xg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5379D805.3070002@renesas.com>
In-Reply-To: <5379D805.3070002@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: mathias.nyman@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Shimoda-san,

On Mon, May 19, 2014 at 12:08 PM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> The R-Car H2 and M2 SoCs come with an xHCI controller that requires
> some specific initilization related to the firmware downloading and
> some specific registers. This patch adds the support for this special
> configuration as an xHCI quirk executed during probe and start.

Thanks for your patch!

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

Does R-Car Gen1 also have xHCI, and is it compatible?
If not, you may want to call this driver USB_XHCI_RCAR2.

> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 561d07e..3a2da1f 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c

> @@ -39,6 +40,12 @@ static int xhci_plat_setup(struct usb_hcd *hcd)
>
>  static int xhci_plat_start(struct usb_hcd *hcd)
>  {
> +       struct device_node *of_node = hcd->self.controller->of_node;
> +
> +       if (of_device_is_compatible(of_node, "renesas,r8a7790-xhci") ||
> +           of_device_is_compatible(of_node, "renesas,r8a7790-xhci"))

r8a7791, as Magnus already pointed out.

> +               xhci_rcar_start(hcd);

If CONFIG_USB_XHCI_RCAR is not defined, xhci_rcar_start() is a dummy
function, but the of_device_is_compatible() checks will still be compiled in.

Hence perhaps an #ifdef CONFIG_USB_XHCI_RCAR is warranted here,
possibly combined with inclusion of a C-source file, like is done in
drivers/usb/host/ohci-hcd.c? It's up to the USB maintainer to decide this,
though.

> +
>         return xhci_run(hcd);
>  }
>
> @@ -165,6 +172,15 @@ static int xhci_plat_probe(struct platform_device *pdev)
>                         goto unmap_registers;
>         }
>
> +       if (of_device_is_compatible(pdev->dev.of_node,
> +                                   "renesas,r8a7790-xhci") ||
> +           of_device_is_compatible(pdev->dev.of_node,
> +                                   "renesas,r8a7791-xhci")) {
> +               ret = xhci_rcar_init_quirk(pdev);

Same here.

> +               if (ret)
> +                       goto disable_clk;
> +       }
> +
>         ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
>         if (ret)
>                 goto disable_clk;

> --- /dev/null
> +++ b/drivers/usb/host/xhci-rcar.c

> +/* USB3.0 Configuraion */

Configuration

> +static int xhci_rcar_download_firmware(struct device *dev, void __iomem *regs)
> +{
> +       const struct firmware *fw;
> +       int retval, index, j, time;
> +       int timeout = 10000;
> +       u32 data, val, temp;
> +
> +       /* request R-Car USB3.0 firmware */
> +       retval = request_firmware(&fw, FIRMWARE_NAME, dev);
> +       if (retval)
> +               return retval;
> +
> +       /* download R-Car USB3.0 firmware */
> +       temp = readl(regs + RCAR_USB3_DL_CTRL);
> +       temp |= RCAR_USB3_DL_CTRL_ENABLE;
> +       writel(temp, regs + RCAR_USB3_DL_CTRL);
> +
> +       for (index = 0; index < fw->size; index += 4) {
> +               for (data = 0, j = 3; j >= 0; j--) {
> +                       if ((j + index) >= fw->size)
> +                               continue;
> +                       data |= fw->data[index + j] << (8 * j);
> +               }

This is your custom get_unaligned_le32(), to avoid reading beyond the end
of the buffer if its size is not a multiple of 4 bytes?
Is there some way to just use get_unaligned_le32()?

If you want to keep it, I would rewrite it as

              for (data = 0, j = 3; j >= 0; j--) {
                      if ((j + index) < fw->size)
                              data |= fw->data[index + j] << (8 * j);
              }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torval
