From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Nov 2017 13:07:31 +0000
Subject: Re: [PATCH v1 01/10] dt-bindings: media: Add Renesas CEU bindings
Message-Id: <CAMuHMdUG6gAEyyC0ANBzmj3KA-940+C7e9Nv_rLkBSjtfeKR1g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1510743363-25798-1-git-send-email-jacopo+renesas@jmondi.org> <1510743363-25798-2-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1510743363-25798-2-git-send-email-jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jacopo Mondi <jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Media Mailing List <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Jacopo,

CC devicetree folks

On Wed, Nov 15, 2017 at 11:55 AM, Jacopo Mondi
<jacopo+renesas@jmondi.org> wrote:
> Add bindings documentation for Renesas Capture Engine Unit (CEU).
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  .../devicetree/bindings/media/renesas,ceu.txt      | 87 ++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/renesas,ceu.txt
>
> diff --git a/Documentation/devicetree/bindings/media/renesas,ceu.txt b/Documentation/devicetree/bindings/media/renesas,ceu.txt
> new file mode 100644
> index 0000000..a88e9cb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/renesas,ceu.txt
> @@ -0,0 +1,87 @@
> +Renesas Capture Engine Unit (CEU)
> +----------------------------------------------
> +
> +The Capture Engine Unit is the image capture interface found on Renesas
> +RZ chip series and on SH Mobile ones.
> +
> +The interface supports a single parallel input with up 8/16bits data bus width.

... with data bus widths up to 8/16 bits?

> +
> +Required properties:
> +- compatible
> +       Must be "renesas,renesas-ceu".

The double "renesas" part looks odd to me. What about "renesas,ceu"?
Shouldn't you add SoC-specific compatible values like "renesas,r7s72100-ceu",
too?

> +- reg
> +       Physical address base and size.
> +- interrupts
> +       The interrupt line number.

interrupt specifier

> +- pinctrl-names, pinctrl-0
> +       phandle of pin controller sub-node configuring pins for CEU operations.
> +
> +CEU supports a single parallel input and should contain a single 'port' subnode
> +with a single 'endpoint'. Optional endpoint properties applicable to parallel
> +input bus are described in "video-interfaces.txt".
> +
> +Example:
> +
> +The example describes the connection between the Capture Engine Unit and a

... an

> +OV7670 image sensor sitting on bus i2c1 with an on-board 24Mhz clock.
> +
> +ceu: ceu@e8210000 {
> +       reg = <0xe8210000 0x209c>;
> +       compatible = "renesas,renesas-ceu";
> +       interrupts = <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&vio_pins>;
> +
> +       status = "okay";
> +
> +       port {
> +               ceu_in: endpoint {
> +                       remote-endpoint = <&ov7670_out>;
> +
> +                       bus-width = <8>;
> +                       hsync-active = <1>;
> +                       vsync-active = <1>;
> +                       pclk-sample = <1>;
> +                       data-active = <1>;
> +               };
> +       };
> +};
> +
> +i2c1: i2c@fcfee400 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&i2c1_pins>;
> +
> +       status = "okay";
> +       clock-frequency = <100000>;
> +
> +       ov7670: camera@21 {
> +               compatible = "ovti,ov7670";
> +               reg = <0x21>;
> +
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&vio_pins>;
> +
> +               reset-gpios = <&port3 11 GPIO_ACTIVE_LOW>;
> +               powerdown-gpios = <&port3 12 GPIO_ACTIVE_HIGH>;
> +
> +               clocks = <&xclk>;
> +               clock-names = "xclk";
> +
> +               xclk: fixed_clk {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       clock-frequency = <24000000>;
> +               };
> +
> +               port {
> +                       ov7670_out: endpoint {
> +                               remote-endpoint = <&ceu_in>;
> +
> +                               bus-width = <8>;
> +                               hsync-active = <1>;
> +                               vsync-active = <1>;
> +                               pclk-sample = <1>;
> +                               data-active = <1>;
> +                       };
> +               };
> +       };
> --
> 2.7.4

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
