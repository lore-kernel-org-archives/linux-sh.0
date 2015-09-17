From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Sep 2015 23:43:48 +0000
Subject: Re: [PATCH 0/20 v2][RFC] arm64: Salvator-X sound support
Message-Id: <871tdw39an.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbb97kci.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbb97kci.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > > Do you have any thoughts the above patches going into topic branches?
> > > It seems a bit messy but possible from my light analysis so far.
> > 
> > what does it mean ?
> > What/Which is messy ?
> 
> Sorry for my poor choice of words. I was not referring to the code
> itself, rather that the patchset doesn't appear to map well
> to a single topic branch.
> 
> What I see is something like this:
> 
> 1) dmaengine core topic
> 2,3) ak4613 driver topic
> 5-18) i2c+sound integration topics
> 19,20) i2c driver topic
> 
> I think the above can be constructed if you think it is worthwhile.
> There are of course other possibilities.

Ahh, OK I see
I need to send v3 patch-set. Then, I will separate these for each topics
Does it clear for you ?

Best regards
---
Kuninori Morimoto
