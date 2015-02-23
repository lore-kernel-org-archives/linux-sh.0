From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Feb 2015 11:22:24 +0000
Subject: Re: [PATCH 01/24 v2] dmaengine: export symbol of of_dma_request_slave_channel()
Message-Id: <CAMuHMdUqJEONj-To7YhLhTqT+1vYnNL6ah8na6+W9VwcVOgwFQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
	<87egpkop98.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87egpkop98.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, dmaengine@vger.kernel.org

Hi Morimoto-san,

On Fri, Feb 20, 2015 at 11:22 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> --- a/include/linux/of_dma.h
> +++ b/include/linux/of_dma.h
> @@ -37,8 +37,8 @@ extern int of_dma_controller_register(struct device_node *np,
>                 (struct of_phandle_args *, struct of_dma *),
>                 void *data);
>  extern void of_dma_controller_free(struct device_node *np);
> -extern struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
> -                                                    const char *name);
> +struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
> +                                             const char *name);

Why have you dropped the "extern" keyword? Checkpach?
All prototypes in the neighborhood have "extern" keywords, so I think it's
better to keep it for consistency.

>  extern struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_spec,
>                 struct of_dma *ofdma);
>  extern struct dma_chan *of_dma_xlate_by_chan_id(struct of_phandle_args *dma_spec,




-- 
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
