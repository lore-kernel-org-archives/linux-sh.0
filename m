From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 30 May 2012 08:16:20 +0000
Subject: Re: [PATCH][RFC] ARM: mach-shmobile: setup-sh7372: fixup chclr_offset base
Message-Id: <87fwai2ien.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87mx4q2qos.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mx4q2qos.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Guennadi

> > Thanks.
> > But sorry. I didn't have any problem.
> > I noticed it from source-code only, not board behavior.
> 
> Ok, but did you at least run some tests, where this code-path would be 
> entered, including (runtime-) suspend and resume? If not yet, I think, it 
> would be good to at least run a couple of short tests to make sure we're 
> not causing any obvious regressions. I'll try to find some time later 
> today or tomorrow for this.

Yes. of course I tested my patch on FSI DMAEngine.
In my test, I didn't get any issue with/without this patch.

I double-checked this issue, but sh7372 has offset bug.
This is the reason why I added [RFC] on this patch.

Best regards
---
Kuninori Morimoto
