From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 14 Jun 2012 23:53:39 +0000
Subject: Re: [PATCH 04/27 v2] ARM: shmobile: shareing DMAEngine definitions
Message-Id: <874nqd8n7y.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <871ulkyiv6.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871ulkyiv6.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org


Hi Magnus

Thank you for checking patch

> <kuninori.morimoto.gx@renesas.com> wrote:
> > Current shmobile have DMAEngine specific settings on each CPU code,
> > but SH-ARM DMAC use same value.
> > This patch will share DMAEngine definitions and reduce a waste of code
> > on SH-ARM architecture.
> >
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Tested-by: Simon Horman <horms@verge.net.au>
> > ---
> > v1 -> v2
> 
> Hi Morimoto-san,
> 
> Thanks for your efforts to reduce code redundancy.
> 
> >  arch/arm/mach-shmobile/include/mach/dma-register.h |   45 +++++++++++
> 
> Are these new shared constants really limited to the ARM architecture?
> Can't they be shared with SH? If so then they should be in include/
> instead of arch/arm/include/.

Unfortunately we can't share with SH.
DMAC parameter between SH / SH-ARM are different.

Best regards
---
Kuninori Morimoto
