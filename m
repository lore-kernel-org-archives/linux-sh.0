From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 02 Dec 2014 21:29:45 +0000
Subject: Re: [PATCH 5/5] ARM: shmobile: r8a73a4: ape6evm: replace legacy with multiplatform
Message-Id: <CAMuHMdXaRxCVLUOYT37COCd47CS024MSKU7YS9MO+qmUJ-XXww@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1417509439-31739-6-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1417509439-31739-6-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Tue, Dec 2, 2014 at 9:37 AM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> --- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
> +++ /dev/null
> @@ -1,240 +0,0 @@

> -       lbsc {
> -               compatible = "simple-bus";
> -               #address-cells = <1>;
> -               #size-cells = <1>;
> -               ranges = <0 0 0 0x80000000>;
> -
> -               ethernet@8000000 {
> -                       compatible = "smsc,lan9220", "smsc,lan9115";
> -                       reg = <0x08000000 0x1000>;
> -                       interrupt-parent = <&irqc1>;
> -                       interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
> -                       phy-mode = "mii";
> -                       reg-io-width = <4>;
> -                       smsc,irq-active-high;
> -                       smsc,irq-push-pull;
> -                       vddvario-supply = <&ape6evm_fixed_3v3>;
> -                       vdd33a-supply = <&ape6evm_fixed_3v3>;
> -                       status = "okay";
> -                       clocks = <&zb_clk>;

I may be wrong, but I think something went wrong with the patch generation,
as "[PATCH 1/3] ARM: shmobile: ape6evm-reference: add ethernet controller
to DT" did _not_ add the zb_clk?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
