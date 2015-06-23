From: Simon Horman <horms@verge.net.au>
Date: Tue, 23 Jun 2015 23:39:34 +0000
Subject: Re: [PATCH] gpio: rcar: Add r8a7795 (R-Car H3) support
Message-Id: <20150623233932.GA9988@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1434710308-15901-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1434710308-15901-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jun 22, 2015 at 01:03:14AM +0000, Kuninori Morimoto wrote:
> 
> Hi Ulrich
> 
> > R-Car Gen3's GPIO blocks are identical to Gen2's in every respect.
> (snip)
> > diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
> > index fd39774..e962ad5 100644
> > --- a/drivers/gpio/gpio-rcar.c
> > +++ b/drivers/gpio/gpio-rcar.c
> > @@ -318,6 +318,9 @@ static const struct of_device_id gpio_rcar_of_table[] = {
> >  		.compatible = "renesas,gpio-r8a7794",
> >  		.data = &gpio_rcar_info_gen2,
> >  	}, {
> > +		.compatible = "renesas,gpio-r8a7795",
> > +		.data = &gpio_rcar_info_gen2,
> > +	}, {
> >  		.compatible = "renesas,gpio-rcar",
> >  		.data = &gpio_rcar_info_gen1,
> >  	}, {
> 
> I would like to have "gen3", or have comment /* gen3 compatible */

I don't feel strongly about this, however, unless I am mistaken the name
in question is internal to this driver. So from my point of view a comment
would suffice.
