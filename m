From: Simon Horman <horms@verge.net.au>
Date: Thu, 18 Apr 2013 12:30:30 +0000
Subject: Re: [PATCH v2 1/6] sh-pfc: r8a7740: Add SCIFA1 data group
Message-Id: <20130418123030.GG13101@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1366194847-9879-1-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1366194847-9879-1-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 17, 2013 at 01:36:20PM +0200, Laurent Pinchart wrote:
> Hi Bastian,
> 
> Thank you for the patch.
> 
> On Wednesday 17 April 2013 12:34:01 Bastian Hecht wrote:
> > Add SCIFA1 as preparation to switch to pinctrl in board files.
> > 
> > Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, queued-up for v3.11 in the pinmux branch.

> > ---
> > v2: same
> > 
> >  drivers/pinctrl/sh-pfc/pfc-r8a7740.c |   14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> > b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c index d95040c..4753f54 100644
> > --- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> > +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> > @@ -1999,6 +1999,14 @@ static const unsigned int mmc0_ctrl_1_pins[] = {
> >  static const unsigned int mmc0_ctrl_1_mux[] = {
> >  	MMC1_CMD_PORT104_MARK, MMC1_CLK_PORT103_MARK,
> >  };
> > +/* - SCIFA1
> > ----------------------------------------------------------------- */
> > +static const unsigned int scifa1_data_pins[] = {
> > +	/* RXD, TXD */
> > +	195, 196,
> > +};
> > +static const unsigned int scifa1_data_mux[] = {
> > +	SCIFA1_RXD_MARK, SCIFA1_TXD_MARK,
> > +};
> >  /* - SDHI0
> > ------------------------------------------------------------------ */
> > static const unsigned int sdhi0_data1_pins[] = {
> >  	/* D0 */
> > @@ -2204,6 +2212,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] > > { SH_PFC_PIN_GROUP(mmc0_data4_1),
> >  	SH_PFC_PIN_GROUP(mmc0_data8_1),
> >  	SH_PFC_PIN_GROUP(mmc0_ctrl_1),
> > +	SH_PFC_PIN_GROUP(scifa1_data),
> >  	SH_PFC_PIN_GROUP(sdhi0_data1),
> >  	SH_PFC_PIN_GROUP(sdhi0_data4),
> >  	SH_PFC_PIN_GROUP(sdhi0_ctrl),
> > @@ -2316,6 +2325,10 @@ static const char * const mmc0_groups[] = {
> >  	"mmc0_ctrl_1",
> >  };
> > 
> > +static const char * const scifa1_groups[] = {
> > +	"scifa1_data",
> > +};
> > +
> >  static const char * const sdhi0_groups[] = {
> >  	"sdhi0_data1",
> >  	"sdhi0_data4",
> > @@ -2346,6 +2359,7 @@ static const struct sh_pfc_function pinmux_functions[]
> > = { SH_PFC_FUNCTION(lcd0),
> >  	SH_PFC_FUNCTION(lcd1),
> >  	SH_PFC_FUNCTION(mmc0),
> > +	SH_PFC_FUNCTION(scifa1),
> >  	SH_PFC_FUNCTION(sdhi0),
> >  	SH_PFC_FUNCTION(sdhi1),
> >  	SH_PFC_FUNCTION(sdhi2),
> -- 
> Regards,
> 
> Laurent Pinchart
> 
