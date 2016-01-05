From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 05 Jan 2016 13:37:07 +0000
Subject: Re: [PATCH] ARM: shmobile: armadillo800eva dts: Correct extal1 frequency to 24 MHz
Message-Id: <CAMuHMdUZx5ynmJOz+EDzFSGOgVQraVquj0GtdMgkE0UxCQ-V2Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450435896-6026-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1450435896-6026-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Dec 18, 2015 at 11:51 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> On r8a7740/armadillo, actual clock rates are ca. 4% lower than reported
> by /sys/kernel/debug/clk/clk_summary. Correct the extal1 frequency from
> 25 MHz to 24 MHz to fix this.
>
> This matches the Armadillo-800 EVA Product Manual, which claims the main
> crystal runs at 24 MHz, and the old legacy/reference board code.

Ping? I think we want this applied to -stable and -ltsi, too.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
> index 5845e4e6c700568f..13d27e3985378552 100644
> --- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
> +++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
> @@ -180,7 +180,7 @@
>  };
>
>  &extal1_clk {
> -       clock-frequency = <25000000>;
> +       clock-frequency = <24000000>;
>  };
>  &extal2_clk {
>         clock-frequency = <48000000>;
> --
> 1.9.1

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
