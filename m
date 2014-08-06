From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 06 Aug 2014 00:35:09 +0000
Subject: Re: [GIT PULL] Renesas rcar-audmapp Driver Updates for v3.17
Message-Id: <877g2mlakk.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1405401560.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1405401560.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Ben

# I addded Laurent

> > > Please consider pulling these Renesas rcar-audmapp Driver Updates for v3.17
> > 
> > Out of interest, what happened to the series I posted adding DT
> > support for the renesas dma code? I don't seem to have had any
> > feedback on it?
> Sorry I assumed it was folded in the one sent by Simon as PULL request.
> Can you please resend

I guess SYS-DAC is now supported by Laurent's rcar-dma.
Because it needs to support modern feature, like IOMMU/LPAE...
addint it on shdma-base is difficult, I guess

Best regards
---
Kuninori Morimoto
