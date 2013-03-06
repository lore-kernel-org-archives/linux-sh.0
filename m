From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 06 Mar 2013 07:58:11 +0000
Subject: Re: [PATCH] sh-pfc: r8a7779: fixup INDTx address
Message-Id: <87boaxklip.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87lia3pn80.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87lia3pn80.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon, Phil

> > > No, it is not in my tree.
> > > I would be happy to add it if Laurent is happy with it.
> > > Or for him to include it in his forthcoming pinctrl patch set(s).
> > Paul gave the patch a quick review & pointed out that I really needed to 
> > use clearer nomenclature. He also suggested that it might be better to use 
> > a single mapping for both INDT and OUTDT registers in the pfc driver. 
> > Whilst the latter is easy enough to fix if the order of INDT and OUTDT are 
> > always the same, I don't know if this is the case for all/upcoming 
> > devices.
> 
> Thanks, I understand.
> 
> Perhaps Morimoto-san could revise the patch?

I see.
I thought that it was just bug, but I'm busy for now...
sorry

> > Anyhow, I don't think that Morimoto-san's "sh-pfc: r8a7779: fixup INDTx 
> > address" patch should be used as it changes the functionality (not what it 
> > says in the description) and doesn't fix the underlying issue.
> 
> Agreed.

OK
But, this means that I should modify R-Car M1's GPIO INDTx address...

Best regards
---
Kuninori Morimoto
