From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Aug 2014 14:36:51 +0000
Subject: Re: [PATCH 01/10] ARM: shmobile: sh7372: Update DTS to include CPU frequency
Message-Id: <CAMuHMdUVKs3xft7E_E4U=1AVwfJ=KRq1RPdodmiwuRbChKOLbw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140820130210.32075.68195.sendpatchset@w520>
In-Reply-To: <20140820130210.32075.68195.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Wed, Aug 20, 2014 at 3:02 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> Add CPU Frequency information to the sh7372 DTS file. This
> will allow us to use the shared C code on sh7372 and Mackerel
> which reads out the clock frequency from DT and calculates the
> delay settings from there.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
>
>  arch/arm/boot/dts/sh7372.dtsi |    1 +
>  1 file changed, 1 insertion(+)
>
> --- 0001/arch/arm/boot/dts/sh7372.dtsi
> +++ work/arch/arm/boot/dts/sh7372.dtsi  2014-08-20 21:00:26.000000000 +0900
> @@ -21,6 +21,7 @@
>                         compatible = "arm,cortex-a8";
>                         device_type = "cpu";
>                         reg = <0x0>;
> +                       clock-frequency = <800000000>;

Should this be overridden in sh7372-mackerel.dtsi?

While the sh7372 manual states 800 MHz, the Mackerel manual states
806 MHz.

>                 };
>         };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
