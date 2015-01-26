From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 26 Jan 2015 01:19:09 +0000
Subject: Re: [PATCH] ARM: shmobile: salvage lost CONFIG_REGULATOR
Message-Id: <87egqibao0.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fvb2exr7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fvb2exr7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert

Thank you for your help

> > eb4513482d1c4882e3633528ccc48d77581b7bb1
> > (ARM: shmobile: Enable kzm9g board in multiplatform defconfig)
> > dropped CONFIG_REGULATOR from shmobile_defconfig.
> > So, we lost CONFIG_REGULATOR_GPIO or others REGULATORs
> > Let's salvage these
> 
> On which version did you see this problem?
> I still have CONFIG_REGULATOR_GPIO=y in the generated .config.
> 
> My first guess was that there's a select in -next (and thus in renesas-drivers,
> where I generated the patch), that's not yet in renesas-devel (selects are evil,
> and cause havoc when combined with savedefconfig).
> 
> However, I can't reproduce it on
> renesas-devel-20150119-v3.19-rc5 (which still has kzm9g multiplatform),
> renesas-drivers-2015-01-19-v3.19-rc5 (which still has kzm9g multiplatform),
> renesas-devel-20150123-v3.19-rc5 (which lost kzm9g multiplatform)

Hmm...

 renesas-devel-20150122-v3.19-rc5 : I (and Magnus) used, and it was broken
 renesas-devel-20150123-v3.19-rc5 : it doens't have issue

So, this patch was not needed.
Thank you for pointing it.

Best regards
---
Kuninori Morimoto
