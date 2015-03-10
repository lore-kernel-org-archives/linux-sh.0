From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 Mar 2015 23:48:57 +0000
Subject: Re: [PATCH] ASoC: rsnd: Use %pad to print dma_addr_t in rsnd_dmapp_init()
Message-Id: <87lhj4mn1q.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1425984485-28421-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1425984485-28421-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org


Hi

> sound/soc/sh/rcar/dma.c: In function 'rsnd_dmapp_init':
> sound/soc/sh/rcar/dma.c:341:2: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'dma_addr_t' [-Wformat=]
>   dev_dbg(dev, "id/src/dst/chcr = %d/%x/%x/%08x\n",
>   ^
> sound/soc/sh/rcar/dma.c:341:2: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t' [-Wformat=]
> 
> Fixes: 288f392e729dd4d3 ("ASoC: rsnd: add Audio DMAC peri peri support rework")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
