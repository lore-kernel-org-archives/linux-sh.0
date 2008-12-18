From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 18 Dec 2008 16:22:22 +0000
Subject: Re: A patch got applied to v4l bypassing v4l lists
Message-Id: <Pine.LNX.4.64.0812181717320.5510@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0812181613050.5510@axis700.grange>
	<20081218160841.GA13851@linux-sh.org>
In-Reply-To: <20081218160841.GA13851@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <damm@igel.co.jp>, video4linux-list@redhat.com, linux-sh@vger.kernel.org

On Fri, 19 Dec 2008, Paul Mundt wrote:

> On Thu, Dec 18, 2008 at 04:23:53PM +0100, Guennadi Liakhovetski wrote:
> > Hi Magnus, Paul,
> > 
> > just stumbled upon a patch
> > 
> > sh: sh_mobile ceu clock framework support
> > 
> > http://marc.info/?l=linux-sh&m2545217725877&w=2
> > 
> > with diffstat
> > 
> >  arch/sh/boards/board-ap325rxa.c            |    2 +-
> >  arch/sh/boards/mach-migor/setup.c          |    2 +-
> >  drivers/media/video/sh_mobile_ceu_camera.c |   20 +++++++++++++++++++-
> >  3 files changed, 21 insertions(+), 3 deletions(-)
> > 
> > that has been pulled through linux-sh ML and the sh tree without even 
> > being cc-ed to the v4l list, which wasn't a very good idea IMHO. Now this 
> > patch has to be manually "back-ported" to v4l hg repos using the 
> > "kernel-sync:" tag and only in part, because arch/sh directory is not in 
> > hg at all. Can we please avoid this in the future?
> > 
> It wasn't cc-ed to the v4l list because there was nothing v4l specific
> about it. The patch in question likewise has a dependency on arch/sh/
> changes, and it makes no sense to merge the v4l component out of order.
> 
> The last time v4l patches related to sh drivers got merged out of order
> with the board support patches, both the driver and the boards were
> broken for over a week. When there is something relevant to v4l, then the
> list will be CCed, but I will not hold trivial patches hostage to
> overzealous patchflow enforcement when the end result is likely to cause
> more trouble than it prevents.
> 
> When touching files outside of arch/sh/, it is always a judgement call
> whether it makes sense to include it through that subsystem's tree or
> whether to simply merge it directly. In this case, given that it is an
> sh-specific driver, and the changes are trivial in nature, with an
> inherent dependency on other bits, I see no reason to force this change
> through the v4l tree.
> 
> If you wish to be CC-ed on all trivial patches relating to sh drivers in
> the v4l space, that is certainly something we can watch out for in the
> future, but I will still be applying the patches where it makes sense.

I certainly understand, that the patch in question didn't contain any 
video specidic code, and you both are well able to justify its 
correctness, I'm just saying that because of the way v4l patches are 
handled it causes extra work, and not even knowing about such patches adds 
the necessity to search for them first - ok, thanks to git-blame it wasn't 
very difficult this time, but if the code had been removed, for instance, 
it could have been a bit trickier. So, yes, please, at least cc the v4l 
list on such patches.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
