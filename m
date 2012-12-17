From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 17 Dec 2012 01:01:29 +0000
Subject: Re: [PATCH 0/2] Preliminary Armadillo DT support
Message-Id: <87sj75ija1.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1355666066-25649-1-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1355666066-25649-1-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Bastian

> This is a minimal setup for DT booting Armadillo boards. It's based on Simon
> Horman's reference implementation for the kz9mg board.
> 
> The only device added so far is the ethernet controller sh_eth. For this the
> driver is enhanced to support DT-based probing in the 2nd patch.
> 
> Care should be taken as the lines
> -       /* armadillo 800 eva extal1 is 24MHz */
> -       clk_set_rate(xtal1, 24000000);
> are removed and the r8a7740 code uses 25MHz by default. I'm unsure if just some clock
> calculations get incorrect or if we overclock our board somewhere.
> 
> The patches are based on git://git.kernel.org/pub/scm/linux/kernel/git/horms/devel/of
> revision 9fcbfcfd31c782840ebb57f283c174c749467434.
> 
> Bastian Hecht (2):
>   ARM: shmobile: Armadillo800eva: DT boot testcase with ethernet
>     support
>   net: sh_eth: Add Device Tree support
> 
>  arch/arm/boot/dts/r8a7740-armadillo800eva.dts  |    7 +
>  arch/arm/mach-shmobile/board-armadillo800eva.c | 1167 +-----------------------
>  arch/arm/mach-shmobile/clock-r8a7740.c         |    1 +
>  arch/arm/mach-shmobile/include/mach/common.h   |    2 +
>  drivers/net/ethernet/renesas/sh_eth.c          |   72 +-
>  5 files changed, 86 insertions(+), 1163 deletions(-)

Preliminary Armadillo800eva DT support itself is very good.
But I guess these patches kill off "current" Armadillo800eva users who are using many devices ?

How about this ?
  1) add new file like board-armadillo800eva-dt.c for DT support
  2) keep adding new DT suuport on board-armadillo800eva-dt.c
  3) If board-armadillo800eva-dt.c has full-support,
     remove old board-armadillo800eva.c

Best regards
---
Kuninori Morimoto
