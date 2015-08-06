From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 06 Aug 2015 00:45:13 +0000
Subject: Re: [RFT 1/2] i2c: rcar: add support for r8a7795 (R-Car H3)
Message-Id: <2090805.Cxfp9Z1Hmm@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1438780706-20945-1-git-send-email-wsa@the-dreams.de> <4463128.lAKghhIhbx@avalon> <20150806003849.GA1743@katana>
In-Reply-To: <20150806003849.GA1743@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>

On Thursday 06 August 2015 02:38:49 Wolfram Sang wrote:
> On Thu, Aug 06, 2015 at 03:34:05AM +0300, Laurent Pinchart wrote:
> > Hi Wolfram,
> > 
> > Thank you for the patch.
> > 
> > On Wednesday 05 August 2015 15:18:25 Wolfram Sang wrote:
> > > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > 
> > > Enable the I2C core for this SoC. I add a new type because this version
> > > has new features (e.g. DMA) which will be added somewhen later.
> > > 
> > > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> ...
> 
> > > @@ -625,6 +627,7 @@ static const struct of_device_id rcar_i2c_dt_ids[] > > > {
> > >  	{ .compatible = "renesas,i2c-r8a7792", .data = (void *)I2C_RCAR_GEN2
> > >  	},
> > >  	{ .compatible = "renesas,i2c-r8a7793", .data = (void *)I2C_RCAR_GEN2
> > >  	},
> > >  	{ .compatible = "renesas,i2c-r8a7794", .data = (void *)I2C_RCAR_GEN2
> > >  	},
> > > +	{ .compatible = "renesas,i2c-r8a7795", .data = (void *)I2C_RCAR_GEN3
> > > },
> > 
> > If H3 is compatible with Gen2, can't you just use I2C_RCAR_GEN2 here ? You
> > can always add I2C_RCAR_GEN3 later if you find differences.
> 
> Is the patch description not clear enough?

My bad. I should go to bed. And so should you by the way ;-)

-- 
Regards,

Laurent Pinchart

