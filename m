From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 24 Oct 2012 13:36:40 +0000
Subject: Re: [Q] "console=" command line ignored?
Message-Id: <Pine.LNX.4.64.1210241535560.2683@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1210241226060.31768@axis700.grange>
 <CACVXFVOv-zMj_cEyRuehhWMjCF1nvd-tkW7c8o5raHZoMbCZiQ@mail.gmail.com>
In-Reply-To: <CACVXFVOv-zMj_cEyRuehhWMjCF1nvd-tkW7c8o5raHZoMbCZiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, linux-sh@vger.kernel.org

On Wed, 24 Oct 2012, Ming Lei wrote:

> On Wed, Oct 24, 2012 at 6:49 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > Hi
> >
> > I cannot seem to force selection of a serial console by specifying
> > "console=ttySC0..." on the command line with modern (yesterday's "next")
> > kernels. The kernel insists on
> >
> > console [tty0] enabled
> 
> Please see https://lkml.org/lkml/2012/10/23/307

Perfect, thanks! Fixes my problem too.

Regards
Guennadi

> > The reason might also well be, that the respective "sh-sci" driver is
> > only registered later. I'll try to look at this in more detail - since
> > when this is broken and how the registration order looked before. This is
> > just a first heads-up in case someone has a solution immediately at hand.
> 
> 
> 
> Thanks,
> -- 
> Ming Lei
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
