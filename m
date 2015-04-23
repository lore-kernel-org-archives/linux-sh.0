From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Apr 2015 10:00:21 +0000
Subject: Re: [PATCH 4/7 v4] mmc: sh_mmcif: separate sh_mmcif_clk_update() into setup and prepare
Message-Id: <CAMuHMdXcVSQiE3QrdCo=ucFXV84qMFrU7JfJVpKsNkfWmvZtEw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <873840a4ch.wl%kuninori.morimoto.gx@renesas.com>
	<87d22vgt8u.wl%kuninori.morimoto.gx@renesas.com>
	<87618ngt1d.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87618ngt1d.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Simon <horms@verge.net.au>, linux-mmc <linux-mmc@vger.kernel.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Laurent <laurent.pinchart@ideasonboard.com>, kobayashi <keita.kobayashi.ym@renesas.com>

On Thu, Apr 23, 2015 at 10:16 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Current sh_mmcif_clk_update() is called from probe() and set_ios(),
> but, the purpose of later one is just clk_prepare_enable().
> No need to setup mmc->f_max/f_min in many times.
> This patch separe sh_mmcif_clk_update() into clk_prepare_enable()
> and mmc->f_max/f_min setup.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
