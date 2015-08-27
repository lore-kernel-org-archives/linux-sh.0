From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 27 Aug 2015 10:52:13 +0000
Subject: Re: [PATCH/RFC 02/10] arm64: defconfig: Enable GPIO of Renesas R-Car Gen3 SoC
Message-Id: <CAMuHMdVJ+VBnhvSrBP6L4gq5Gm3bf+mMGQG6zF8uNv-ufVLCkw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 27, 2015 at 11:24 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> Enable GPIO for  Renesas R-Car Gen3 SoC via the following options:
>   - GPIO_SYSFS
>   - GPIO_RCAR
>   - LEDS_GPIO
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> [horms: updated changelog]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm64/configs/defconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index a2ddca9c632b..e7b638eb5059 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -124,7 +124,9 @@ CONFIG_VIRTIO_CONSOLE=y
>  CONFIG_SPI=y
>  CONFIG_SPI_PL022=y
>  CONFIG_PINCTRL_MSM8916=y
> +CONFIG_GPIO_SYSFS=y

Do we really need GPIO_SYSFS?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
