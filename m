From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 05 Feb 2013 08:45:01 +0000
Subject: Re: [PATCH 0/4] i2c: sh_mobile: fix STOP condition generation
Message-Id: <Pine.LNX.4.64.1302050942140.1275@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1358415957-8371-1-git-send-email-g.liakhovetski@gmx.de>
 <20130124072748.GK8364@nekote.pengutronix.de>
In-Reply-To: <20130124072748.GK8364-8EAEigeeuNG034pCzgS/Qg7AFbiQbgqx@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>

Hi Wolfram

On Thu, 24 Jan 2013, Wolfram Sang wrote:

> On Thu, Jan 17, 2013 at 10:45:53AM +0100, Guennadi Liakhovetski wrote:
> > Currently the i2c-sh_mobile.c driver generates STOP conditions after each 
> > message. This makes any multi-message transfers, e.g. reading, impossible 
> > with the AS3711 PMIC on kzm9g. This patch series fixes this by only 
> > generating the STOP condition after the last message or if the I2C_M_STOP 
> > flag is set.
> > 
> > Guennadi Liakhovetski (4):
> >   i2c: i2c-sh_mobile.c: cosmetic: trivially simplify 2 functions
> >   i2c: sh_mobile: fix timeout error handling
> >   i2c: sh_mobile: eliminate an open-coded "goto" loop
> >   i2c: sh_mobile: don't send a stop condition by default inside
> >     transfers
> 
> Looks good to me. I have to mention usleep_range, though. I leave it to
> you if you want to fix it or not. Other than that, I would apply the
> series.

Thanks, yes, we could try usleep_range(), but these delays could be a bit 
sensitive, so, such a change would require a new round of testing. Maybe 
we could commit these patches in this form and then I could try 
usleep_range() as a separate patch to also make any regression tracking 
easier?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
