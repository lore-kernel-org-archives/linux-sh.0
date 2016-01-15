From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 15 Jan 2016 10:42:54 +0000
Subject: Re: [PATCH 2/3] arm64: renesas: r8a7795: Add PCIe nodes
Message-Id: <CAMuHMdWGmvUDsJH16dRhcHAxG5S3=KGSOY+sQRAomubbhdKivg@mail.gmail.com>
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
> @@ -682,6 +691,55 @@
>                                 };
>                         };
>                 };
> -       };
>
> +               pciec0: pcie@fe000000 {
> +                       compatible = "renesas,pcie-r8a7795";
> +                       reg = <0 0xfe000000 0 0x80000>;
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +                       bus-range = <0x00 0xff>;
> +                       device_type = "pci";
> +                       ranges = <0x01000000 0 0x00000000 0 0xfe100000 0 0x00100000
> +                               0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000
> +                               0x02000000 0 0x30000000 0 0x30000000 0 0x08000000
> +                               0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
> +                       /* Map all possible DDR as inbound ranges */
> +                       dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000>;
> +                       interrupts = <0 116 IRQ_TYPE_LEVEL_HIGH>,
> +                               <0 117 IRQ_TYPE_LEVEL_HIGH>,
> +                               <0 118 IRQ_TYPE_LEVEL_HIGH>;

<GIC_SPI ...> (x3)

> +                       #interrupt-cells = <1>;
> +                       interrupt-map-mask = <0 0 0 0>;
> +                       interrupt-map = <0 0 0 0 &gic 0 116 IRQ_TYPE_LEVEL_HIGH>;

... &gic GIC_SPI ...

> +                       clocks = <&cpg CPG_MOD 319>, <&pcie_bus_clk>;
> +                       clock-names = "pcie", "pcie_bus";
> +                       power-domains = <&cpg>;
> +                       status = "disabled";
> +               };
> +
> +               pciec1: pcie@ee800000 {
> +                       compatible = "renesas,pcie-r8a7795";
> +                       reg = <0 0xee800000 0 0x80000>;
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +                       bus-range = <0x00 0xff>;
> +                       device_type = "pci";
> +                       ranges = <0x01000000 0 0x00000000 0 0xee900000 0 0x00100000
> +                               0x02000000 0 0xeea00000 0 0xeea00000 0 0x00200000
> +                               0x02000000 0 0xc0000000 0 0xc0000000 0 0x08000000
> +                               0x42000000 0 0xc8000000 0 0xc8000000 0 0x08000000>;
> +                       /* Map all possible DDR as inbound ranges */
> +                       dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000>;
> +                       interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>,
> +                               <0 149 IRQ_TYPE_LEVEL_HIGH>,
> +                               <0 150 IRQ_TYPE_LEVEL_HIGH>;

<GIC_SPI ...> (x3)

> +                       #interrupt-cells = <1>;
> +                       interrupt-map-mask = <0 0 0 0>;
> +                       interrupt-map = <0 0 0 0 &gic 0 148 IRQ_TYPE_LEVEL_HIGH>;

... &gic GIC_SPI ...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
