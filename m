From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 23 Apr 2013 00:39:17 +0000
Subject: Re: [PATCH 2/3 v3] sh-pfc: r8a7778: add SDHI support
Message-Id: <87li8a5bd9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <871ua76wuz.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871ua76wuz.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent, Simon

> > +/* - SDHI1
> > ------------------------------------------------------------------ */
> > +SDHI_PFC_PINS(sdhi1_a_cd,	RCAR_GP_PIN(0, 30));
> > +SDHI_PFC_CDPN(sdhi1_a_cd,	SD1_CD_A);
> > +SDHI_PFC_PINS(sdhi1_a_ctrl,	RCAR_GP_PIN(1, 5),	RCAR_GP_PIN(1, 6));
> > +SDHI_PFC_CTRL(sdhi1_a_ctrl,	SD1_CLK_A,		SD1_CMD_A);
> > +SDHI_PFC_PINS(sdhi1_a_data1,	RCAR_GP_PIN(1, 7));
> > +SDHI_PFC_DAT1(sdhi1_a_data1,	SD1_DAT0_A);
> > +SDHI_PFC_PINS(sdhi1_a_data4,	RCAR_GP_PIN(1, 7),	RCAR_GP_PIN(1, 8),
> > +				RCAR_GP_PIN(0, 5),	RCAR_GP_PIN(0, 6));
> > +SDHI_PFC_DAT4(sdhi1_a_data4,	SD1_DAT0_A,		SD1_DAT1_A,
> > +				SD1_DAT2_A,		SD1_DAT3_A);
> > +SDHI_PFC_PINS(sdhi1_a_wp,	RCAR_GP_PIN(0, 31));
> > +SDHI_PFC_WPPN(sdhi1_a_wp,	SD1_WP_A);
> 
> The pin groups naming style used so far in the pfc-*.c files adds the _a and 
> _b suffixes at the end of the group name. The above would be shdi1_wp_a for 
> instance. Could you please modify that ?

Ahh... I see
OK, I can modify these.
Thank you for pointing it

>> Simon

This patch is already included on simon/pinmux branch.
Can I send additional patch for this branch ?
Or v4 full-patch-set ?

Best regards
---
Kuninori Morimoto
