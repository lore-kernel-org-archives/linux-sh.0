From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 06 Aug 2013 00:30:30 +0000
Subject: Re: [PATCH 3/4] ARM: shmobile: bockw: add missing __initdata
Message-Id: <87siynhd98.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87siys98q9.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87siys98q9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > This patch adds missing __initdata to driver data/resource
> > which are used from platform_device_register_xxx()
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Hi Morimoto-san,
> 
> I have queued this up in v3.12 in the cleanup4 branch.
> I had to resolve a minor conflict in the last hunk,
> specifically, the cleanup4 branch has "/* MMC */" but
> the devel branch, which I assume you based this patch on,
> does not - probably due to a miss-merge.
> 
> In any case, I have queued up the following.
> Please check that it is correct.
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> ARM: shmobile: bockw: add missing __initdata
> 
> This patch adds missing __initdata to driver data/resource
> which are used from platform_device_register_xxx()
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> [horms+renesas@verge.net.au: Resolved minor conflict]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Thank you for your help
it looks very good for me

Best regards
---
Kuninori Morimoto
