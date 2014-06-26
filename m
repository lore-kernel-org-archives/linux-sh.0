From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 26 Jun 2014 11:10:19 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7791: fixup GPIO6/7 register address
Message-Id: <87egycncyf.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87y4wko5rp.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87y4wko5rp.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert

> > Sorry, I didn't.
> > I just checked latest datasheet (H2/M2).
> > I'm asking correct address to HW team.
> > Please wait.
> 
> Thanks!
> 
> P.S. In case something needs to be changed: the GPIO base addresses are
>      also in arch/arm/mach-shmobile/setup-r8a7791.c.

According to HW team,
latest datasheet address was degraded.
I'm so sorry, this patch is not needed.

Best regards
---
Kuninori Morimoto
