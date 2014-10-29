From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 29 Oct 2014 00:04:01 +0000
Subject: Re: [PATCH v3 0/9] R-Car Gen2 DMA Controller driver
Message-Id: <87r3xrivww.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414345216-14486-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414345216-14486-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent, Simon

> > On Lager board + SDHI
> > 
> > Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Thank you.
> 
> > Current SDHI driver + DMAC is working, but super slow,
> > especially, write case....
> 
> *sigh* I'll test that.

Maybe this is SDHI side issue (?)
Buswidth/clock/setting etc etc etc...
No one used SDHI + DMA in DT and in R-Car Gen2 today.
So, I guess it is very safety if we can ignore SDHI + DMA in upstream
-> Simon ?

Best regards
---
Kuninori Morimoto
