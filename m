From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 16 Apr 2012 02:10:47 +0000
Subject: Re: [PATCH 0/7 v2] ARM: mach-shmobile: add Armadillo800eva board support
Message-Id: <87398477fg.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87sjghjmeu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sjghjmeu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > > > Patches [2-4/7] and [6-7/7] applied to the armadillo800eva branch of the
> > > > renesas.git tree.  Please let me know what the status of patch [5/7] is.
> > > 
> > > Hi Rafael,
> > > 
> > > I have not been able to successfully test 5/7 yet.
> > > I'll let you know when that changes.
> > 
> > I tested 5/7 patch this morning.
> > It seems work well on my board.
> > What's happen on your tmenu/board ?
> 
> Nothing :^)
> 
> # tmenu /dev/input/event0
> [ nothing ]
> 
> I am using 3.4-rc2 as a base, perhaps a different
> base would be better?

Hmm... strange.
If your .config has CONFIG_TOUCHSCREEN_ST1232,
but nothing happen, your board seems broken.

BTW, Did you touch the panel after tmenu ?

Best regards
---
Kuninori Morimoto
