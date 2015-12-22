From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Dec 2015 13:43:34 +0000
Subject: Re: [PATCH 2/4] ARM64: renesas: r8a7795: Add VSP instances
Message-Id: <CAMuHMdXFk-ZdYyJTosq37BPzSgiMuCxL-CGbeXcUpBo4_C+u0Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450336895-4279-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1450336895-4279-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Thu, Dec 17, 2015 at 8:21 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index 9ce6a5ea6629..47f97ffc6c8b 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -775,5 +775,119 @@
>                         clocks = <&cpg CPG_MOD 915>;
>                         status = "disabled";
>                 };
> +
> +               vspbc: vsp@fe920000 {
> +                       compatible = "renesas,vsp2";
> +                       reg = <0 0xfe920000 0 0x8000>;
> +                       interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&cpg CPG_MOD 624>;

No "power-domains = <&cpg_clocks>;"?
Each vsp device node corresponds nicely to one vsp module, and the driver
doesn't care at all about the clock, except for (explicit) PM of the vsp
modules.

That would allow to simplify vsp1_device_get(), vsp1_pm_suspend(), and
vsp1_pm_resume(), and get rid of vsp1_device_put() in favor of
pm_runtime_put().

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
