From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 04 Jan 2016 12:42:13 +0000
Subject: Re: [PATCH v2 1/6] arm64: renesas: r8a7795: add usb2_phy device nodes
Message-Id: <CAMuHMdWXFVRgMAg90Xxa2N_81ckPdyzJtge8SPUghaSK0EcGOw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1451044361-5896-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1451044361-5896-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1451044361-5896-2-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Shimoda-san,

On Fri, Dec 25, 2015 at 12:52 PM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 34 ++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index bb353cd..89393ea 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -775,5 +775,39 @@
>                         clocks = <&cpg CPG_MOD 815>;
>                         status = "disabled";
>                 };
> +
> +               usb2_phy0: usb-phy@ee080200 {
> +                       compatible = "renesas,usb2-phy-r8a7795";
> +                       reg = <0 0xee080200 0 0x700>, <0 0xe6590100 0 0x100>;
> +                       reg-names = "usb2_host", "hsusb";
> +                       interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;

Isn't 108 the EHCI0 interrupt?
Cfr. the other usb-phy nodes that don't have interrupts.

> +                       clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
> +                       clock-names = "usb2", "hsusb";
> +                       power-domains = <&cpg>;

This device has two modules clocks, but the CPG/MSSR driver only manages
the first modulo clock.
Who enables the second clock (HS-USB-IF)?

> +                       #phy-cells = <0>;
> +                       status = "disabled";
> +               };
> +
> +               usb2_phy1: usb-phy@ee0a0200 {
> +                       compatible = "renesas,usb2-phy-r8a7795";
> +                       reg = <0 0xee0a0200 0 0x700>;
> +                       reg-names = "usb2_host";
> +                       clocks = <&cpg CPG_MOD 702>;
> +                       clock-names = "usb2";
> +                       power-domains = <&cpg>;
> +                       #phy-cells = <0>;
> +                       status = "disabled";
> +               };
> +
> +               usb2_phy2: usb-phy@ee0c0200 {
> +                       compatible = "renesas,usb2-phy-r8a7795";
> +                       reg = <0 0xee0c0200 0 0x700>;
> +                       reg-names = "usb2_host";
> +                       clocks = <&cpg CPG_MOD 701>;
> +                       clock-names = "usb2";
> +                       power-domains = <&cpg>;
> +                       #phy-cells = <0>;
> +                       status = "disabled";
> +               };
>         };
>  };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
