From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 06 Aug 2013 08:02:23 +0000
Subject: Re: [PATCH v7 0/3] ARM: shmobile: lager: enable Ether
Message-Id: <87fvungsc4.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1375775411-4545-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1375775411-4545-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi Simon

> this short series enables the on-board ethernet
> of the r8a7790 SoC for on lager board.
> 
> This series has a run-time dependency on
> "sh_eth: add support for r8a7790 SoC"
> 
> This series has been built on top of renesas-next-201300806.
> 
> Changes noted in changelogs of individual patches.
> Simon Horman (3):
>   ARM: shmobile: r8a7790: clocks for Ether support
>   ARM: shmobile: lager: enable Ether
>   ARM: shmobile: lager: enable nfsroot in DTS
> 
>  arch/arm/boot/dts/r8a7790-lager.dts    |  2 +-
>  arch/arm/mach-shmobile/board-lager.c   | 29 +++++++++++++++++++++++++++++
>  arch/arm/mach-shmobile/clock-r8a7790.c |  4 ++++
>  3 files changed, 34 insertions(+), 1 deletion(-)

For all patches

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Best regards
---
Kuninori Morimoto
