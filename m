From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 26 Aug 2011 05:12:10 +0000
Subject: Re: Can not compile Ecovec board
Message-Id: <878vqgpxi1.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87aaaxou97.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87aaaxou97.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus, Iwamatsu-san, and SH-ML

> > This was already revised in linux-next tree.
> 
> That's great, but shouldn't build fixes be solved for the RC kernels
> if possible?
> 
> People really need to learn how to separate build fixes from new
> development, otherwise everything will turn to shit.

Thank you for your help

I checked linux-next and solution patches.
It are in current paul/sh-latest branch I think.

If I hand merge it to linus/master branch, I could build.

Is this merge timing issue ?

Best regards
---
Kuninori Morimoto
