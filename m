From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Aug 2013 04:46:04 +0000
Subject: Re: [PATCH 1/5] sh-pfc: r8a7778: add SRU/SSI pin support
Message-Id: <87ppt6ib93.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8738qmjgav.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738qmjgav.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

Thank you for your review

> > +/* - AUDIO clock --------------------------------------------------------*/
> > +AUDIO_PFC_PIN(audio_clk_a,	RCAR_GP_PIN(2, 22));
> > +AUDIO_PFC_DAT(audio_clk_a,	AUDIO_CLKA);
> > +AUDIO_PFC_PIN(audio_clk_b,	RCAR_GP_PIN(2, 23));
> > +AUDIO_PFC_DAT(audio_clk_b,	AUDIO_CLKB);
> > +AUDIO_PFC_PIN(audio_clk_c,	RCAR_GP_PIN(2, 7));
> > +AUDIO_PFC_DAT(audio_clk_c,	AUDIO_CLKC);
> > +AUDIO_PFC_PIN(audio_clkout_a,	RCAR_GP_PIN(2, 16));
> > +AUDIO_PFC_DAT(audio_clkout_a,	AUDIO_CLKOUT_A);
> > +AUDIO_PFC_PIN(audio_clkout_b,	RCAR_GP_PIN(1, 16));
> > +AUDIO_PFC_DAT(audio_clkout_b,	AUDIO_CLKOUT_B);
> > +
> 
> Could you please move this block up to keep the blocks alphabetically sorted ?

Oops indeed.
Thank you. I will fix it in v2

> > +/* - SSI02
> > -------------------------------------------------------------------*/
> > +SSI_PFC_PINS(ssi02,	RCAR_GP_PIN(3, 6),	RCAR_GP_PIN(3, 7),
> > +				RCAR_GP_PIN(3, 10),	RCAR_GP_PIN(3, 8));
> > +SSI_PFC_MULT(ssi02,	SSI_SCK012,		SSI_WS012,
> > +				SSI_SDATA0,		SSI_SDATA2);
> 
> This looks a bit complex to me. Could you please explain how the various pins 
> are used ? I see that the SSI_DATA1 and SSI_DATA2 signals are used here and 
> below. What are the possible combinations ? For instance, if I select ssi02, 
> will SDATA0 and SDATA2 be driven by the SSI0 instance, or by the SSI0 and SSI2 
> instances respectively ?

Can you check datasheet ?
[Sound Routing Unit] has SSI image
SSI1, SSI2 can use (share) SSI0's pin (= SSI012)

Yes, SSI is very confusable device/pins

> > +/* - SSI34
> > -------------------------------------------------------------------*/
> > +SSI_PFC_PINS(ssi34,	RCAR_GP_PIN(3, 2),	RCAR_GP_PIN(3, 3),
> > +				RCAR_GP_PIN(3, 5),	RCAR_GP_PIN(3, 4));
> > +SSI_PFC_MULT(ssi34,	SSI_SCK34,		SSI_WS34,
> > +				SSI_SDATA3,		SSI_SDATA4);
> 
> Can SSI_SDATA4 be used without SSI_SDATA3 ? Same question for SSI_DATA7 and 
> SSI_DATA8 below.

Yes, you can use SSI4 without SSI3.
You can select SSI4 only in that case.

SSI34 is sharing pins case for SSI3/SSI4

> > +static const char * const ssi_groups[] = {
> > +	"ssi0",
> > +	"ssi01",
> > +	"ssi012",
> > +	"ssi02",
> > +	"ssi1_a",
> > +	"ssi1_b",
> > +	"ssi2_a",
> > +	"ssi2_b",
> > +	"ssi3",
> > +	"ssi34",
> > +	"ssi4",
> > +	"ssi5",
> > +	"ssi6",
> > +	"ssi7",
> > +	"ssi78",
> > +};
> 
> I'm not familiar with SSI so I could be wrong, but shouldn't we have one group 
> per SSI instance ?

Current pinctrl map is like below

	PIN_MAP_MUX_GROUP_DEFAULT("rcar_sound", "pfc-r8a7778",
				  "ssi01", "ssi"),

Do you want like this ?

	PIN_MAP_MUX_GROUP_DEFAULT("rcar_sound", "pfc-r8a7778",
				  "sck", "ssi01"),

But hmm...
this style can solve above complex SSIxyz settings ?
 - separate data / ctrl pin 
 - select these each

	PIN_MAP_MUX_GROUP_DEFAULT("rcar_sound", "pfc-r8a7778",
				  "ssi01_ctrl", "ssi"),
	PIN_MAP_MUX_GROUP_DEFAULT("rcar_sound", "pfc-r8a7778",
				  "ssi0_data", "ssi"),
	PIN_MAP_MUX_GROUP_DEFAULT("rcar_sound", "pfc-r8a7778",
				  "ssi1_data", "ssi"),



Best regards
---
Kuninori Morimoto
