From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 09 Jul 2012 04:34:44 +0000
Subject: Re: [PATCH 0/12 v2] ARM: shmobile: r8a7740: add basic pm domain support
Message-Id: <87mx39ft7i.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8762a2r4zo.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8762a2r4zo.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Rafael

> > Kuninori Morimoto (12):
> >        1 ARM: shmobile: add R-mobile PM domain common APIs
> >        2 ARM: shmobile: r8a7740: fixup: MSEL1CR 7bit control
> >        3 ARM: shmobile: r8a7740: add A4S pm domain support
> >        4 ARM: shmobile: r8a7740: add A3SP pm domain support
> >        5 ARM: shmobile: r8a7740: add A4LC pm domain support
> >        6 ARM: shmobile: armadillo800eva: USB Func enables external IRQ mode
> >        7 ARM: shmobile: armadillo800eva: A4LC domain includes LCDC
> >        8 ARM: shmobile: armadillo800eva: A3SP domain includes USB
> >        9 ARM: shmobile: sh7372: add pm-rmobile domain support
> >       10 ARM: shmobile: mackerel: switch to using pm-rmobile API
> >       11 ARM: shmobile: ap4evb: switch to using pm-rmobile API
> >       12 ARM: shmobile: sh7372: completely switch over to using pm-rmobile API
> 
> The patch series has been applied, but there were a few merge conflicts.
> Please check the soc-core, r8a7740, sh7372, armadillo, and next branches for
> correctness.

In my quick check, it seems correct.
Thank you

Best regards
---
Kuninori Morimoto
