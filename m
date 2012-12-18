From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 18 Dec 2012 00:08:01 +0000
Subject: Re: [PATCH 0/2] Preliminary Armadillo DT support
Message-Id: <87y5gwgr37.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1355666066-25649-1-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1355666066-25649-1-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Bastian
Cc Simon

> > How about this ?
> >   1) add new file like board-armadillo800eva-dt.c for DT support
> >   2) keep adding new DT suuport on board-armadillo800eva-dt.c
> >   3) If board-armadillo800eva-dt.c has full-support,
> >      remove old board-armadillo800eva.c
> >
> 
> Sounds like a plan!
> Yes this looks like the way Simon has made up his kzm9g reference
> implementation. So I suppose we want this extra board file in the
> mainline until 3) happens?

It is nice for users.
But I'm not sure detail of patch maintenance side work. >> Simon

Best regards
---
Kuninori Morimoto
