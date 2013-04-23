From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 23 Apr 2013 05:08:45 +0000
Subject: Re: [PATCH 2/2 v7] sudmac: add support for SUDMAC
Message-Id: <87a9op6dgm.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5174FDF3.8060809@renesas.com>
In-Reply-To: <5174FDF3.8060809@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Shimoda-san

> it can choose the SH_DMAE_BASE only, but we will use
> "SH_DMAE_BASE && SH_DMAE" or "SH_DMAE_BASE && SH_SUDMAC".
> So, I intend to modify the Kconfig like the "config DMA_ENGINE":
> 
> --- Kconfig ---
> config SH_DMAE
> 	xxx
> 	select SH_DMAE_BASE
> 
> config SUDMAC
> 	xxx
> 	select SH_DMAE_BASE
> ---------------
> 
> What do you think about this?


Thank you

Selecting SH_DMAE_BASE only is not so strange for me,
and (as you mentioned F2F), some driver already depends on it.
So this SH_DMAE_BASE should be y, and SH_DMAE/SUDMAC should depend
on it.

I guess this is naturally Kconfig for me

config SH_DMAE_BASE
	bool xxx
	default y if (SH_MOBLE && SH)

config SH_DMAE
        xxxx
	depends on SH_DMAE_BASE

config SUDMAC
        xxxx
	depends on SH_DMAE_BASE

BTW, "SH_DMAE" is mismatch naming, I guess "SHDMAC" is better ?

Best regards
---
Kuninori Morimoto
