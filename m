From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 09 Feb 2015 01:10:05 +0000
Subject: Re: [alsa-devel] Can we remove un-used Sound driver ?
Message-Id: <87k2zrx51v.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87egq7774l.wl%kuninori.morimoto.gx@renesas.com>
	<87a90sj0hy.wl%kuninori.morimoto.gx@renesas.com>
	<20150205180343.GB21293@sirena.org.uk>
	<CAOLZvyGemO=O8Eqafj0KUXg7cELtREcARU5KFDieAr3Y9DdVnw@mail.gmail.com>
In-Reply-To: <CAOLZvyGemO=O8Eqafj0KUXg7cELtREcARU5KFDieAr3Y9DdVnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Manuel Lauss <manuel.lauss@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>


Hi Manuel, Mark

> >> I'm very sad, but...
> >> Good bye sh7760
> >> Good bye ssi
> >> Good bye hac
> 
> I still have working hardware for those 3 files, I just need to dust
> it off.  But the last time I checked (~3 years ago) I had no issues
> with sound.

I didn't know that there is user of these drivers...
On which board ?

> > Hrm.  At least migor was active relatively recently, Guennadi was
> > working on it in 2012 which isn't *that* long ago and there may well be
> > systems still in the field.  There's also still board code for migor in
> > arch/sh so it's an upstream platform.  Some of the others like SSI and
> > HAC are definitely not showing any signs of anyone being interested
> > though and I'd not be surprised if they'd been broken at some point.
> 
> I still have the full board support code for the SH7760 hardware I originally
> wrote the above sound drivers for.  If there's interest I can whip
> it in shape for submission.

We need to keep existing driver if there is user...
