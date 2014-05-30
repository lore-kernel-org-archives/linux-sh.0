From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 May 2014 09:58:23 +0000
Subject: Re: [PATCH 3/7] ARM: shmobile: Disable DVS support for r8a7790
Message-Id: <CAMuHMdUw2So803-+auFnvptasG92O5tA3pUMa=K+VJB3L0qPTQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5386E66D.3020502@bp.renesas.com>
In-Reply-To: <5386E66D.3020502@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

(CC Benoit)

On Thu, May 29, 2014 at 9:49 AM, Gaku Inami
<gaku.inami.xw@bp.renesas.com> wrote:
> Since range of VDD is narrow, there is no effect of power consumption
> by DVS. So, DVS is disabled in R-CAR Gen2 series.
>
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> ---
>  arch/arm/boot/dts/r8a7790-lager.dts |    4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index ab73ed0..9becef7 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -317,7 +317,3 @@
>         cd-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
>         status = "okay";
>  };
> -
> -&cpu0 {
> -       cpu0-supply = <&vdd_dvfs>;
> -};

The role of the DT is to describe the hardware.
Not using DVS because the effect of power consumption is low or non-existent
is a software policy.

So perhaps it should be kept?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
