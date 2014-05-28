From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 28 May 2014 04:23:24 +0000
Subject: Re: [PATCH] ARM: shmobile: armadillo800eva: fixup HDMI sound flags setting
Message-Id: <874n0awmyu.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fw7w38mf.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fw7w38mf.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > c7a507eea1db1430476289f525f9c853d5d485e8
> > (ASoC: fsi: fixup SND_SOC_DAIFMT_CBx_CFx flags)
> > fixuped FSI driver's behavior
> > which didn't match to ALSA flags.
> > 
> > But, it didn't care about armadillo800eva HDMI sound flags.
> > This patch fixed it.
> > 
> > Reported-by: Bui Duc Phuc(Fukuda) <bd-phuc@jinso.co.jp>
> > Reported-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> > >> Simon
> > 
> > This patch is needed on latest linus/master tree
> 
> Thanks I have queued this up as a fix for v3.16.
> Even though it is a fix I think it is too late for it to be included in v3.15.
> Instead I will ask for it to be added to stable (LTSI) for v3.15.
> And likewise for v3.14 where the problem first appeared (I think).

Thank you

But, don't use this patch to v3.14.
v3.14 doesn't have this problem.
First appeared version is v3.15 (not released yet)

Best regards
---
Kuninori Morimoto
