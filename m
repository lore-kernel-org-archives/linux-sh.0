From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 17 Mar 2014 04:34:44 +0000
Subject: Re: [PATCH] ARM: shmobkle: lager: fixup SND_SOC_DAIFMT_CBx_CFx flags
Message-Id: <87fvmhv3xa.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87lhw9v7x2.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87lhw9v7x2.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> SND_SOC_DAIFMT_CBx_CFx means "codec" side master/slave mode.
> Then, rcar will be master mode if it was SND_SOC_DAIFMT_CBS_CFS.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> >> Simon
> 
> This patch is based on Mark's mark/fix/rcar branch.
> I guess it will goes to linus/master soon.

Lager sound will be supported "after" merge window.
So, I will re-post this patch after that
Thank you
