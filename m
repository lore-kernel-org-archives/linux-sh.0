From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Jan 2015 08:46:57 +0000
Subject: Re: [PATCH 0/5 v6] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE
Message-Id: <873873kxqd.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87bnlrkydd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bnlrkydd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi all

> There is no response from Vinod,
> and, I might have misunderstanding about this sound DMAC.
> But, I send latest patch-set.
> We don't need to replace rcar-audmapp if we can have Arnd's
> short term bugfix patch.
> 
> Arnd Bergmann (1):
>       dmaengine: shdma-base: enable to be non multiplexed DMAEngine driver
> 
> Kuninori Morimoto (4):
>       ARM: shmobile: r8a7790: sound enables Audio DMAC entry on DTSI
>       ARM: shmobile: r8a7791: sound enables Audio DMAC entry on DTSI
>       ARM: shmobile: r8a7790: sound enables Audio DMAC peri peri entry on DTSI
>       ARM: shmobile: r8a7791: sound enables Audio DMAC peri peri entry on DTSI

I'm sorry, but I noticed it still have bug.
Hmm...

