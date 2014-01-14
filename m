From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 14 Jan 2014 00:15:40 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790: add audio clocks
Message-Id: <87eh4bh109.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8738l1jzfv.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <8738l1jzfv.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

> > > 1. Add the old style clocks to Lager
> > > 2. Add the new style clocks to BockW
> > > 3. Add the new style clocks to Lager
> > > 4. Modify the ADG driver to use the new style clocks
> > > 5. Remove the old style clocks from BockW
> > > 6. Remove the old style clocks from Lager
(snip)
> My point is that you need to add the new style clocks to platform code before 
> you modify the ADG driver. If adding old style clocks will get merged during 
> the same merge window as the new style clocks and the ADG driver changes, I 
> don't think there's a point to add them.

OK
I send v2 patch-set which has above old/new style clocks soon.
Thank you for your help

Best regards
---
Kuninori Morimoto
