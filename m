From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jul 2015 01:02:59 +0000
Subject: Re: [PATCH] ASoC: fsi: Remove obsolete sh_fsi2 platform_device_id entry
Message-Id: <87io9mw7zh.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1436875174-13960-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1436875174-13960-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org


Hi

> Since the removal of the r8a7740 legacy board code in commit
> 1fa59bda21c7fa36 ("ARM: shmobile: Remove legacy board code for
> Armadillo-800 EVA"), all former users of the "sh_fsi2" platform device
> name are only supported in generic DT-only ARM multi-platform builds.
> The driver doesn't need to match platform devices by name anymore, hence
> remove the corresponding platform_device_id entry.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
