From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 25 Sep 2013 07:23:54 +0000
Subject: Re: [PATCH 1/3] ARM: shmobile: r8a7778: cleanup registration of vin
Message-Id: <87r4cdl5yx.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8738ousqlk.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738ousqlk.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > vin driver which needs platform data at the time of
> > registration is used from BockW only.
> > Now, ARM/shmobile aims to support DT,
> > and the C code base board support will be removed
> > if DT support is completed.
> > Current driver registration method which needs platform data
> > and which is not shared complicates codes.
> > This means legacy C code cleanup after DT supporting
> > will be more complicated
> > This patch registers it on board code as cleanup C code
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> I have manually applied the following.
> Please verify it is correct.

looks OK for me
Thank you for your hard work

Best regards
---
Kuninori Morimoto
