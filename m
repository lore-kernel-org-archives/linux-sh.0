From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 08 Mar 2015 10:04:00 +0000
Subject: Re: [PATCH 04/11] ARM: shmobile: r8a7793: add Gose board device tree
Message-Id: <CAMuHMdXr_wDvsRMWiBs2ykHcXByHvg79-1f9jZ3cwF7XCvf8-g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1425661798-10487-5-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1425661798-10487-5-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 6, 2015 at 6:09 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> DT description and Makefile entry for the Gose eval board.

Thanks!

Same comment here as for r8a7791.dtsi.
Please start from current r8a7791-koelsch.dts. You'll find more small
things that
need to fixed.

> diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
> new file mode 100644
> index 0000000..27d8b5b
> --- /dev/null
> +++ b/arch/arm/boot/dts/r8a7793-gose.dts

> +/ {
> +       model = "Gose";
> +       compatible = "renesas,gose", "renesas,r8a7793";
> +
> +       aliases {
> +               serial6 = &scif0;
> +               serial7 = &scif1;

serial0 and serial 1

> +       };
> +
> +       chosen {
> +               bootargs = "console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";

As we support new boards through DT only, please drop the "console=...",
and add "stdout-path = &scif0;".

> +       };
> +
> +       memory@40000000 {
> +               device_type = "memory";
> +               reg = <0 0x40000000 0 0x40000000>;
> +       };
> +
> +       gpio-keys {

keyboard

> +               compatible = "gpio-keys";

> +&i2c6 {
> +       status = "okay";
> +       clock-frequency = <100000>;
> +
> +       vdd_dvfs: regulator@68 {
> +               compatible = "dlg,da9210";

Yeah, a da9210 ;-)

> +               reg = <0x68>;
> +
> +               regulator-min-microvolt = <1000000>;
> +               regulator-max-microvolt = <1000000>;
> +               regulator-boot-on;
> +               regulator-always-on;
> +       };
> +};

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
