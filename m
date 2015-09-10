From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 10 Sep 2015 09:33:26 +0000
Subject: Re: [PATCH 12/14][RFC] arm64: defconfig: add Renesas sound and AK4613 support
Message-Id: <CAMuHMdUMOAwYofic9N94hyCU3Pxkp50bzSsxCNRWs_-g0wpHYg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878u8en3tl.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878u8en3tl.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 10, 2015 at 9:18 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -140,6 +140,11 @@ CONFIG_FRAMEBUFFER_CONSOLE=y
>  CONFIG_LOGO=y
>  # CONFIG_LOGO_LINUX_MONO is not set
>  # CONFIG_LOGO_LINUX_VGA16 is not set
> +CONFIG_SOUND=y
> +CONFIG_SND=y
> +CONFIG_SND_SOC=y
> +CONFIG_SND_SOC_RCAR=y
> +CONFIG_SND_SOC_AK4613=y

=m?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
