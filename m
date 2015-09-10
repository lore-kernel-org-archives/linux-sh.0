From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 10 Sep 2015 09:34:09 +0000
Subject: Re: [PATCH 14/14][RFC] arm64: defconfig: add CS2000 driver support
Message-Id: <CAMuHMdWXw+sOudjGOcJzctaRVH9L1c6eotGmHgsEjUXdhUvvEQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87613in3sc.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87613in3sc.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 10, 2015 at 9:19 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -82,6 +82,7 @@ CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_DMA_CMA=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_VIRTIO_BLK=y
> +CONFIG_CS2000_CP=y

=m?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
