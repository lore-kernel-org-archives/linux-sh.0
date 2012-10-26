From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 26 Oct 2012 10:56:40 +0000
Subject: Re: mainlining tps80031
Message-Id: <Pine.LNX.4.64.1210261254310.20835@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1210261212170.20835@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1210261212170.20835@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 26 Oct 2012, Laxman Dewangan wrote:

> On Friday 26 October 2012 04:03 PM, Guennadi Liakhovetski wrote:
> > On Fri, 26 Oct 2012, Laxman Dewangan wrote:
> > 
> > > On Friday 26 October 2012 03:46 PM, Guennadi Liakhovetski wrote:
> > > > Hi Laxman
> > > > 
> > > > On Fri, 26 Oct 2012, Laxman Dewangan wrote:
> > > > 
> > > > > We have also plan for upstreaming this driver but lack of time, we
> > > > > were
> > > > > not able to do this.
> > > > > We are targeting this for k3.8.
> > > > This is very good to hear! 3.8 would also be my goal. In fact U have
> > > > already merged your relevant patches on top of current next, at least
> > > > they
> > > > compile. Would you mind if I post the resulting source as several
> > > > patches
> > > > - for the beginning 1 for the MFD and 1 for the regulator drivers. I
> > > > would
> > > > certainly preserve the original authorship and Sob's from all
> > > > contributors
> > > > would be appropriate. Would this be ok?
> > > > 
> > > I am fine with this. Do you have our k3.4 code with you? Still need some
> > > cleanups on these before sending to mainline.
> > For my port I cloned
> > 
> > https://android.googlesource.com/kernel/tegra
> > android-tegra3-grouper-3.1-jb-fr2
> > 
> > Is a newer version available somewhere?
> > 
> You need to clone for K3.4. We have changed the driver lots in k3.4 like
> converting to regmap.

This is very good, unfortunately, I don't see a branch with "3.4" in it at 
the above repository. Where can I get the version, you're referring to, 
from?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
