From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 22 Aug 2013 11:02:07 +0000
Subject: Re: [PATCH 1/5] sh-pfc: r8a7778: add SRU/SSI pin support
Message-Id: <3361379.lnxpgxHbaE@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <8738qmjgav.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738qmjgav.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Wednesday 21 August 2013 21:46:04 Kuninori Morimoto wrote:

[snip]

> > > +/* - SSI02
> > > -------------------------------------------------------------------*/
> > > +SSI_PFC_PINS(ssi02,	RCAR_GP_PIN(3, 6),	RCAR_GP_PIN(3, 7),
> > > +				RCAR_GP_PIN(3, 10),	RCAR_GP_PIN(3, 8));
> > > +SSI_PFC_MULT(ssi02,	SSI_SCK012,		SSI_WS012,
> > > +				SSI_SDATA0,		SSI_SDATA2);
> > 
> > This looks a bit complex to me. Could you please explain how the various
> > pins are used ? I see that the SSI_DATA1 and SSI_DATA2 signals are used
> > here and below. What are the possible combinations ? For instance, if I
> > select ssi02, will SDATA0 and SDATA2 be driven by the SSI0 instance, or
> > by the SSI0 and SSI2 instances respectively ?
> 
> Can you check datasheet ?
> [Sound Routing Unit] has SSI image
> SSI1, SSI2 can use (share) SSI0's pin (= SSI012)
> 
> Yes, SSI is very confusable device/pins

The only copy of the datasheet I have access to is in Japanese, so it's a bit 
hard to understand for me :-)

We seem to have three pin sharing groups: SSI0/1/2, SSI3/4 and SSI7/8.

SSI7 and SSI8 have a single set of SCK and WS pins called SCK78 and WS78. What 
are the possible combinations here ? I can think of

- SSI7 alone with (SCK78, WS78, SDATA7)
- SSI8 alone with (SCK78, WS78, SDATA8)
- SSI7 and SSI8 together with (SCK78, WS78, SDATA7, SDATA8) using a single set 
of shared SCK and WS signals, driven by either SSI7 or SSI8

For SSI3 and SSI4, I can think of more combinations:

- SSI3 alone with (SCK34, WS34, SDATA3)
- SSI4 alone with (SCK4, WS4, SDATA4)
- SSI4 alone with (SCK34, WS34, SDATA4)
- SSI3 and SSI4 together with (SCK34, WS34, SDATA3) for SSI3 and (SCK4, WS4, 
SDATA4) for SSI4
- SSI3 and SSI4 together with (SCK34, WS34, SDATA3, SDATA4) using a single set 
of shared SCK and WS signals, driven by either SSI3 or SSI4
- SSI3 and SSI4 together with (SCK4, WS4, SDATA3, SDATA4) using a single set 
of shared SCK and WS signals, driven by either SSI3 or SSI4

SSI0/1/2 is even more complex.

Could you please tell me which of the above combinations is supported ? Based 
on that we can divide the pins into proper groups.

[snip]

> > > +static const char * const ssi_groups[] = {
> > > +	"ssi0",
> > > +	"ssi01",
> > > +	"ssi012",
> > > +	"ssi02",
> > > +	"ssi1_a",
> > > +	"ssi1_b",
> > > +	"ssi2_a",
> > > +	"ssi2_b",
> > > +	"ssi3",
> > > +	"ssi34",
> > > +	"ssi4",
> > > +	"ssi5",
> > > +	"ssi6",
> > > +	"ssi7",
> > > +	"ssi78",
> > > +};
> > 
> > I'm not familiar with SSI so I could be wrong, but shouldn't we have one
> > group per SSI instance ?
> 
> Current pinctrl map is like below
> 
> 	PIN_MAP_MUX_GROUP_DEFAULT("rcar_sound", "pfc-r8a7778",
> 				  "ssi01", "ssi"),
> 
> Do you want like this ?
> 
> 	PIN_MAP_MUX_GROUP_DEFAULT("rcar_sound", "pfc-r8a7778",
> 				  "sck", "ssi01"),
> 
> But hmm...
> this style can solve above complex SSIxyz settings ?
>  - separate data / ctrl pin
>  - select these each
> 
> 	PIN_MAP_MUX_GROUP_DEFAULT("rcar_sound", "pfc-r8a7778",
> 				  "ssi01_ctrl", "ssi"),
> 	PIN_MAP_MUX_GROUP_DEFAULT("rcar_sound", "pfc-r8a7778",
> 				  "ssi0_data", "ssi"),
> 	PIN_MAP_MUX_GROUP_DEFAULT("rcar_sound", "pfc-r8a7778",
> 				  "ssi1_data", "ssi"),

The answer to this depends on what combinations are supported by the hardware. 
Let's first discuss that, and then decide how to divide pins in pin groups.

-- 
Regards,

Laurent Pinchart

