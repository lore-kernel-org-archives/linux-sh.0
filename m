From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 18 May 2012 08:54:26 +0000
Subject: Re: [PATCH 04/29] regulator: fix devm_regulator_put() to call regulator_put() explicitly
Message-Id: <Pine.LNX.4.64.1205181053510.23140@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
 <1336057558-11031-5-git-send-email-g.liakhovetski@gmx.de>
 <20120503165606.GR3955@opensource.wolfsonmicro.com>
In-Reply-To: <20120503165606.GR3955@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

Hi Mark

On Thu, 3 May 2012, Mark Brown wrote:

> On Thu, May 03, 2012 at 05:05:33PM +0200, Guennadi Liakhovetski wrote:
> > devres_destroy() doesn't call the release() method, it only destroys the
> > resource. The caller should take care to release the associated object
> > itself.
> 
> > +	regulator_put(regulator);
> >  	rc = devres_destroy(regulator->dev, devm_regulator_release,
> >  			    devm_regulator_match, regulator);

So, shall we rather use your new devres_release() here?

Thanks
Guennadi

> Oh dear.  This seems like pretty peculiar behaviour on the part of
> devres_destroy() - everything about the function and its documentation
> would suggest that it'd actually free the resource not just free the
> devm_ internal bits of the resource, and especially given that we have
> to pass the release function in.
> 
> This also seems like it's the wrong way round - it probably shouldn't
> matter that much but we should really only do the regulator_put() after
> the destroy succeeded since there's a small chance that hotplug or
> something might cause this to run while the device is being removed
> elsewhere so we could end up trying to double free.
> 
> Also, this patch is totally unrelated to the rest of the series and
> should really have been sent separately.

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
