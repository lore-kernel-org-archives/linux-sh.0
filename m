From: kuninori.morimoto.gx@renesas.com
Date: Fri, 08 Jul 2011 01:12:04 +0000
Subject: Re: [RFC][PATCH 0/8] sh: clock-shxxxx: add CLKDEV_ICK_ID for cleanup
Message-Id: <87ei21a84b.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vcvgjjhj.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vcvgjjhj.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org


Dear Magnus

> > These are not so important, but are clean-up patches.
> > Current clock-shxxxx are a little bit un-readable.
> > I put it as [RFC]
> >
> > Kuninori Morimoto (8):
> >      sh: clock-sh7724: add CLKDEV_ICK_ID for cleanup
> >      sh: clock-sh7722: add CLKDEV_ICK_ID for cleanup
> >      sh: clock-sh7343: add CLKDEV_ICK_ID for cleanup
> >      sh: clock-sh7366: add CLKDEV_ICK_ID for cleanup
> >      sh: clock-sh7757: add CLKDEV_ICK_ID for cleanup
> >      sh: clock-sh7785: add CLKDEV_ICK_ID for cleanup
> >      sh: clock-sh7786: add CLKDEV_ICK_ID for cleanup
> >      sh: clock-shx3: add CLKDEV_ICK_ID for cleanup
> >
> > I checked sh7724, but couldn't others.
> 
> You mean that your compiler doesn't know how to talk SH4A? =)

No. I mean I don't have these board.

> Please at least build with the defconfigs that use the SoCs above.

OK.

Best regards
---
Kuninori Morimoto
