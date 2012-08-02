From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 02 Aug 2012 02:24:25 +0000
Subject: Re: [PATCH 0/2] Add SDHI to Marzen board
Message-Id: <87d33ac9pm.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1342526039-11128-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1342526039-11128-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi

> Phil Edworthy (2):
>   r8a7779: add SDHI clock support
>   marzen: add SDHI0 support
> 
>  arch/arm/mach-shmobile/board-marzen.c  |   48 ++++++++++++++++++++++++++++++++
>  arch/arm/mach-shmobile/clock-r8a7779.c |   13 ++++++--
>  2 files changed, 58 insertions(+), 3 deletions(-)

both patches

Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

It is better if 2nd patch updates defconfig :)

Best regards
---
Kuninori Morimoto
