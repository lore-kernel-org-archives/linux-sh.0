From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 12 Jun 2012 01:35:58 +0000
Subject: Re: [PATCH 23/27] ARM: shmobile: armadillo800eva: enable DMAEngine on USB
Message-Id: <87ehplxqf8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87pq96pkis.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87pq96pkis.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > It is possible to reduce CPU load if USB used DMAEngine.
> > This patch enabled it.
> 
> Hi Morimoto-san,
> 
> I am having a little trouble exercising this.
> Could you propose a test scenario?

How about to use g_mass_storage.ko ?

insmod g_mass_storage.ko file=xxxx
and read/write it

dma3 will be used

Best regards
---
Kuninori Morimoto
