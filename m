From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 18 May 2012 15:23:15 +0000
Subject: Re: [PATCH 06/29] regulator: export a function to check if regulator can change status
Message-Id: <Pine.LNX.4.64.1205181711140.23140@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
 <1336057558-11031-7-git-send-email-g.liakhovetski@gmx.de>
 <20120503152558.GL3955@opensource.wolfsonmicro.com>
 <Pine.LNX.4.64.1205181030550.23140@axis700.grange>
 <20120518150858.GB4039@opensource.wolfsonmicro.com>
In-Reply-To: <20120518150858.GB4039@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

On Fri, 18 May 2012, Mark Brown wrote:

> On Fri, May 18, 2012 at 10:33:42AM +0200, Guennadi Liakhovetski wrote:
> > On Thu, 3 May 2012, Mark Brown wrote:
> 
> > > Bear in mind that the regulator may be shared by other users so even if
> > > the regulator is flagged as potentially being able to change status that
> > > doesn't mean that it actually can change status.
> 
> > Yes, I think, that's ok. We just need to know, that the card can in 
> > principle be powered off. We don't need a guarantee, that we can power it 
> > down at any time, when we think we need it.
> 
> Well, in that case what's the benefit in not just unconditionally
> claiming that you can power off and doing runtime PM on the card?

I'm using the ability of the regulator to change status as a signal from 
the user: "yes, this card may be powered off," or "no, keep it on." 
However, now that I think about it, it is not necessarily a good 
criterion. It can be, that the regulator can power off, but the card 
actually shouldn't be. Hm...

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
