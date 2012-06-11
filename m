From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 11 Jun 2012 09:48:24 +0000
Subject: Re: [PATCH 01/27] ARM: shmobile: sh73a0: bugfix: SY-DMAC number
Message-Id: <87ipeyp4bf.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87lijuqzfs.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87lijuqzfs.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon
Cc Magnus

Thank you for your reply

> > 681e1b3eeb3606e06a7c4984e8058df84296f8bb
> > (ARM: mach-shmobile: sh73a0 DMA Engine support for SY-DMAC)
> > adds SY-DMAC, but it is 218, not 318
> > 
> > This patch is based on v2.0 manual
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Hi Morimoto-san,
> 
> I am unsure of how to test this change.
> Is checking that DMAE works with FSI using subsequent patches
> in this series a sufficient test?

I'm not sure how to test.
Because
 - original patch (681e1b3eeb3606e06a7c4984e8058df84296f8bb) has mistake
 - SY-DMAC was default ON

This is bug fix patch, but it didn't run mischief

Magnus

Can you please review thsi patch ?

Best regards
---
Kuninori Morimoto
