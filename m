From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 05 Aug 2013 07:57:55 +0000
Subject: Re: [PATCH 0/4] ARM: shmobile: ape6evm: support GPIO switches and LEDs
Message-Id: <87zjswsh6p.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1375149543-27564-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1375149543-27564-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi Simon

> This short series adds support for GPIO swtiches and LEDS to
> the ape6evm board.
> 
> Applies on top of renesas-devel-20130726.
> 
> Simon Horman (4):
>   ARM: shmobile: ape6evm: support GPIO switches
>   ARM: shmobile: ape6evm: Enable gpio-keys in defconfig
>   ARM: shmobile: ape6evm: Add GPIO LEDs
>   ARM: shmobile: ape6evm: Enable gpio-leds in defconfig
> 
>  arch/arm/configs/ape6evm_defconfig     |  6 +++-
>  arch/arm/mach-shmobile/board-ape6evm.c | 60 ++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+), 1 deletion(-)

For all patches

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Best regards
---
Kuninori Morimoto
