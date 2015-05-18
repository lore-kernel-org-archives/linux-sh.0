From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 18 May 2015 09:48:38 +0000
Subject: Re: [PATCH 2/2] usb: renesas_usbhs: Add support for R-Car E2
Message-Id: <CAMuHMdWs3y5vP5+mGeuEWOg5HJuZ4NbB4Ra=EriNOdQDzjDqOA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1431941665-3768-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1431941665-3768-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1431941665-3768-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, USB list <linux-usb@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Shimoda-san,

On Mon, May 18, 2015 at 11:34 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> This patch adds a compatible string to support for R-Car E2.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  Documentation/devicetree/bindings/usb/renesas_usbhs.txt | 1 +
>  drivers/usb/renesas_usbhs/common.c                      | 6 ++++++
>  include/linux/usb/renesas_usbhs.h                       | 1 +
>  3 files changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> index ddbe304..64a4ca6 100644
> --- a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> +++ b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> @@ -4,6 +4,7 @@ Required properties:
>    - compatible: Must contain one of the following:
>         - "renesas,usbhs-r8a7790"
>         - "renesas,usbhs-r8a7791"
> +       - "renesas,usbhs-r8a7794"
>    - reg: Base address and length of the register for the USBHS
>    - interrupts: Interrupt specifier for the USBHS
>    - clocks: A list of phandle + clock specifier pairs

For the DT binding part:
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

> diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
> index 0f7e850..954357f 100644
> --- a/drivers/usb/renesas_usbhs/common.c
> +++ b/drivers/usb/renesas_usbhs/common.c
> @@ -472,6 +472,10 @@ static const struct of_device_id usbhs_of_match[] = {
>                 .compatible = "renesas,usbhs-r8a7791",
>                 .data = (void *)USBHS_TYPE_R8A7791,
>         },
> +       {
> +               .compatible = "renesas,usbhs-r8a7794",
> +               .data = (void *)USBHS_TYPE_R8A7794,
> +       },
>         { },
>  };
>  MODULE_DEVICE_TABLE(of, usbhs_of_match);
> @@ -500,6 +504,7 @@ static struct renesas_usbhs_platform_info *usbhs_parse_dt(struct device *dev)
>         switch (dparam->type) {
>         case USBHS_TYPE_R8A7790:
>         case USBHS_TYPE_R8A7791:
> +       case USBHS_TYPE_R8A7794:
>                 dparam->has_usb_dmac = 1;
>                 break;
>         default:
> @@ -561,6 +566,7 @@ static int usbhs_probe(struct platform_device *pdev)
>         switch (priv->dparam.type) {
>         case USBHS_TYPE_R8A7790:
>         case USBHS_TYPE_R8A7791:
> +       case USBHS_TYPE_R8A7794:

Given all R-Car Gen2 variants are treated the same...

>                 priv->pfunc = usbhs_rcar2_ops;
>                 if (!priv->dparam.pipe_type) {
>                         priv->dparam.pipe_type = usbhsc_new_pipe_type;
> diff --git a/include/linux/usb/renesas_usbhs.h b/include/linux/usb/renesas_usbhs.h
> index e438e72..08c62ba 100644
> --- a/include/linux/usb/renesas_usbhs.h
> +++ b/include/linux/usb/renesas_usbhs.h
> @@ -172,6 +172,7 @@ struct renesas_usbhs_driver_param {
>  enum {
>         USBHS_TYPE_R8A7790 = 1,
>         USBHS_TYPE_R8A7791,
> +       USBHS_TYPE_R8A7794,

... perhaps it would be better to just have a single USBHS_TYPE_RCAR_GEN2,
so you don't have to add more enums and case statements?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
