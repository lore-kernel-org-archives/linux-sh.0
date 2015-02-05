From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 05 Feb 2015 19:35:51 +0000
Subject: Re: [alsa-devel] Can we remove un-used Sound driver ?
Message-Id: <Pine.LNX.4.64.1502052034360.16351@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <87egq7774l.wl%kuninori.morimoto.gx@renesas.com>
 <87a90sj0hy.wl%kuninori.morimoto.gx@renesas.com> <20150205180343.GB21293@sirena.org.uk>
In-Reply-To: <20150205180343.GB21293@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Manuel Lauss <manuel.lauss@gmail.com>

Hi Mark,

Thanks for asking.

On Thu, 5 Feb 2015, Mark Brown wrote:

> On Thu, Feb 05, 2015 at 07:10:49AM +0000, Kuninori Morimoto wrote:
> 
> > These patches remove Renesas SuperH base un-used sound drivers.
> > Maybe, these had been used from out-of-tree (?). But ...
> >  - these are for very old SoC / platform
> >  - these are not used/enabled from upstreamed platform
> >  - maintenance cost is not zero
> >  - we can't test/check these drivers since we don't have these board.
> > 
> > I'm very sad, but...
> > Good bye migor
> > Good bye sh7760
> > Good bye ssi
> > Good bye siu
> > Good bye hac
> 
> Hrm.  At least migor was active relatively recently, Guennadi was
> working on it in 2012 which isn't *that* long ago and there may well be
> systems still in the field.  There's also still board code for migor in
> arch/sh so it's an upstream platform.  Some of the others like SSI and
> HAC are definitely not showing any signs of anyone being interested
> though and I'd not be surprised if they'd been broken at some point.
> 
> Manuel, Guennadi - what do you think about this?

If Morimoto-san (i.e. Renesas) doesn't need that driver, I don't need it 
either :)

Thanks
Guennadi
