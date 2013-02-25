From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 25 Feb 2013 00:17:46 +0000
Subject: Re: [PATCH 3/3] ARM: shmobile: armadillo800eva: enable NEON on defconfig
Message-Id: <87k3pxfdqw.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1346808893-14124-4-git-send-email-horms@verge.net.au>
In-Reply-To: <1346808893-14124-4-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > The application / library will be stopped by illegal instruction
> > on current Armaddilo800eva board,
> > since defconfig doesn't have CONFIG_NEON.
> > This patch enabled it.
> > Special thanks to Ishiyama-san
> 
> I assume this relates to using a userspace that makes use of NEON
> instructions. As such I am quite happy to accept this change. But
> I wonder if it is also relevant to other shmobile defconfigs.
> Do any of the shmobile SoCs not support NEON (in a useful way)?

Thank you.
kzm9g_defconfig seems have NEON support,
but I'm not sure detail of other board.

Anyway, we can enable it on other SoC/board when we need it.

Best regards
---
Kuninori Morimoto
