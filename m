From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 28 Oct 2015 23:57:08 +0000
Subject: Re: [PATCH] [RFC] ASoC: rsnd: Add missing initialization of ADG req_rate
Message-Id: <87egge1rhe.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1446044628-16924-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1446044628-16924-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org


Hi Geert

> If the "clock-frequency" DT property is not found, req_rate is used
> uninitialized, and the "audio_clkout" clock will be created with an
> arbitrary clock rate.
> 
> This uninitialized kernel stack data may leak to userspace through
> /sys/kernel/debug/clk/clk_summary, cfr. the value in the "rate" column:
> 
>        clock     enable_cnt  prepare_cnt        rate   accuracy   phase
>     --------------------------------------------------------------------
>      audio_clkout         0            0  4001836240          0 0
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> Should the absence of this property be considered an error?
> 
> Documentation/devicetree/bindings/sound/renesas,rsnd.txt states that
> both "#clock-cells" and "clock-frequency" are required properties, but
> none of the R-Car Gen1 and Gen2 DTSes seem to have them?

This clkout is option for each board
will fix
