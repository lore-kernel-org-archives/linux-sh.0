From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 07 Aug 2012 02:12:02 +0000
Subject: Re: [PATCH 0/2 v2] Add SDHI to Marzen board
Message-Id: <87zk67tpqn.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1344256265-9802-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1344256265-9802-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi

> Phil Edworthy (2):
>   r8a7779: add SDHI clock support
>   marzen: add SDHI0 support
> 
>  arch/arm/configs/marzen_defconfig      |    4 +-
>  arch/arm/mach-shmobile/board-marzen.c  |   52 +++++++++++++++++++++++++++++++-
>  arch/arm/mach-shmobile/clock-r8a7779.c |   11 ++++++-
>  3 files changed, 63 insertions(+), 4 deletions(-)

It works well

Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Best regards
---
Kuninori Morimoto
