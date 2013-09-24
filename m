From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 24 Sep 2013 08:05:55 +0000
Subject: Re: [PATCH] ARM: shmobile: bockw: tidyup select SND_SOC_xxx on Kconfig
Message-Id: <87ppryr6e8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8761tqsqs7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8761tqsqs7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > > is this a fix for v3.12?
> > 
> > Yes, Bock-W can't use sound without this patch
> 
> Hi Morimoto-san,
> 
> I looked a little closer and it seems that
> bf622b33d6fd40f720430ec2fe3c62a8aee19ee8 is queued up for v3.13
> rather than v3.12. (i.e. its not present in v3.12-rc1).
> 
> With this in mind I will queue up this patch for v3.13.
> This will most likely occur tomorrow.

Oops, sorry, yes, it was v3.13 fixup
Thank you for your help

Best regards
---
Kuninori Morimoto
