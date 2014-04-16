From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 16 Apr 2014 11:28:29 +0000
Subject: Re: [PATCH v3 7/7] soc_camera: initial of code
Message-Id: <Pine.LNX.4.64.1404161325480.14690@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1397471802-27216-8-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1397471802-27216-8-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ben,

On Wed, 16 Apr 2014, Ben Dooks wrote:

> On 16/04/14 11:38, Josh Wu wrote:
> > Hi, Ben
> > 
> > On 4/14/2014 6:36 PM, Ben Dooks wrote:
> > > Add initial support for OF based soc-camera devices that may be used
> > > by any of the soc-camera drivers. The driver itself will need converting
> > > to use OF.
> > > 
> > > These changes allow the soc-camera driver to do the connecting of any
> > > async capable v4l2 device to the soc-camera driver. This has currently
> > > been tested on the Renesas Lager board.
> > > 
> > > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > 
> > Tested-by: Josh Wu <josh.wu@atmel.com>
> > Thanks for your patch. I tested with atmel-isi DT and ov2640. It works
> > perfectly.
> > 
> > Best Regards,
> > Josh Wu

Thanks for testing, Josh!

> Thanks, I only have a limited set of hardware here to test with.
> 
> If there is no more feedback, could this be added to the appropriate
> next tree along with the rcar-vin updates please?

I'll be away this coming weekend, so, this will have to wait _at least_ 
until the one after, possibly more. But yes, I'll have a look at the 
patches and either comment on them or queue for 3.16.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
