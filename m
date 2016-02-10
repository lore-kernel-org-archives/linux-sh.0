From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 10 Feb 2016 08:01:42 +0000
Subject: Re: [PATCH 2/3] arm64: renesas: r8a7795: Add PCIe nodes
Message-Id: <CAMuHMdVrJD7izUkSuCsp7F2WG6U3HOJ+c0CGpqXhF0MDBZOZnw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1446485499-26733-3-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1446485499-26733-3-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Nov 2, 2015 at 6:31 PM, Phil Edworthy <phil.edworthy@renesas.com> wrote:
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -74,6 +74,15 @@
>                 clock-frequency = <0>;
>         };
>
> +       /* External PCIe clock - can be overridden by the board */
> +       pcie_bus_clk: pcie_bus_clk {

Please drop the "_clk" suffix from the device node's name.

> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <100000000>;
> +               clock-output-names = "pcie_bus";

The "clock-output-names" property is optional and not needed. Please drop it,
the clock will be named after the device node's name.

> +               status = "disabled";
> +       };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
