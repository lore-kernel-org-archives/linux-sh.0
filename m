From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 06 Aug 2014 00:39:44 +0000
Subject: Re: [PATCH] clk: shmobile: add missing 0x0100 for SDCKCR
Message-Id: <8761i6lacy.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ppgf1kgv.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87ppgf1kgv.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > It is added on v3.14.
> > I can send v2 patch (or can you add it on log area ?)
(snip)
> > This fixes hidden bug.
> > No board/SoC doesn't have issue without this patch.
> 
> Thanks. Please send v2 with the above information.
> Also please include the id and subject of the commit that added
> the problem. e.g. 0123456789abcdef ("clk: shmobile: blah").
> 
> And I think that this patch needs to go via
> Mike Turquette <mturquette@linaro.org> (CCed),
> so please include him when you post v2.
> 
> > > 3. Should we also fix clock-r8a7790.c and clock-r8a7791.c?
> > >    If so I can make a patch or I am happy for you to do so.
> > 
> > I can do it, but is it possible ?
> > I'm afraid that clock-r8axxx is used for legacy (= non-DT)
> > But, I'm happy to send it if you say "Yes"
> 
> Good point.
> 
> My not very strong feeling at this point is that if it is a fix then we
> should add it.  Even if it is legacy code.

I see, will send v2 which includes legacy side fix patch

Best regards
---
Kuninori Morimoto
