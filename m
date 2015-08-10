From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Aug 2015 14:38:46 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: silk: add QSPI DT support
Message-Id: <CAMuHMdXQJ4Hju477Ys0ujXCNdUjWOa6AuKGzLPc3YFJc_eLz+g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1898263.zrOs5SAUTS@wasted.cogentembedded.com>
 <1768974.jEFIAaInqd@wasted.cogentembedded.com>
In-Reply-To: <1768974.jEFIAaInqd@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Sergei,

On Sun, Aug 9, 2015 at 12:27 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Define the SILK board dependent part of the QSPI device node.
> Add device nodes  for Spansion  S25FL512S SPI flash and MTD partitions on it.
>
> Based on the original patch by Vladimir Barinov
> <vladimir.barinov@cogentembedded.com>.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> --- renesas.orig/arch/arm/boot/dts/r8a7794-silk.dts
> +++ renesas/arch/arm/boot/dts/r8a7794-silk.dts

> +&qspi {
> +       pinctrl-0 = <&qspi_pins>;
> +       pinctrl-names = "default";
> +
> +       status = "okay";
> +
> +       flash@0 {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "spansion,s25fl512s";

Please add the "jedec,spi-nor" fallback.

> +               reg = <0>;
> +               spi-max-frequency = <30000000>;
> +               spi-tx-bus-width = <4>;
> +               spi-rx-bus-width = <4>;
> +               m25p,fast-read;

Please keep all "spi-*" properties together.

> +               spi-cpol;
> +               spi-cpha;

> +               partition@0 {
> +                       label = "loader";
> +                       reg = <0x00000000 0x00040000>;
> +                       read-only;
> +               };
> +               partition@40000 {
> +                       label = "user";
> +                       reg = <0x00040000 0x00400000>;
> +                       read-only;
> +               };
> +               partition@440000 {
> +                       label = "flash";
> +                       reg = <0x00440000 0x03bc0000>;
> +               };

The above part I cannot verify, so I have to trust you.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
