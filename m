From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 06 Mar 2013 08:36:48 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: clock-r8a7779: add DIV4 clock support
Message-Id: <874ngolyar.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87hakpkuyg.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87hakpkuyg.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus

> > Thank you for pointing it.
> >
> > This patch doesn't support clkz, since it is not DIV4 clock on R-Car M1.
> > I will support it in additional patch.
> 
> Sounds good, thanks.
> 
> I know you are very busy right now, but later if you have a free
> moment, please add this to r8a7779 too.

I Will do for R8A7778 soon.
And it is already supported on R8A7779

-------------------------------------------------------------------
916b1f8c81ea563611288d1a9b082df3f723e4fe
Author: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date:   Tue Dec 20 00:53:52 2011 -0800

    ARM: mach-shmobile: clock-r8a7779: clkz/clkzs support
    
    Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    Signed-off-by: Paul Mundt <lethal@linux-sh.org>
-------------------------------------------------------------------


Best regards
---
Kuninori Morimoto
