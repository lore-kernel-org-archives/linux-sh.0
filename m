From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 21 Oct 2013 04:44:04 +0000
Subject: Re: [PATCH 0/2 v3] ARM: shmobile: QSPI support for R8a7790
Message-Id: <87sivvb5db.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1382326020-10558-1-git-send-email-cm-hiep@jinso.co.jp>
In-Reply-To: <1382326020-10558-1-git-send-email-cm-hiep@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi

> Here's version number three(v3) of the patchs add QSPI support to R8a7790 SOC. 
> This QSPI attaches to SPI Flash Memory (Spansion S25FL512SAGMFIG11 64Mb)
> I have updated the patch of 0002 as Sergei pointed out to me and use 
> __initconst instead of __initdata in order to match to the same style in this
> board file. these patches are based on the branch renesas 
> "renesas-devel-v3.12-rc5-20131017" and have tested on the Lager board.
> 
> the qspi patch is on topic/rspi (5ce0ba8 and cb52c67) in the SPI tree:
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
> 
> Best Regards,
> Hiep Cao Minh.
> 
> Hiep Cao Minh (2):
>   ARM: shmobile: r8a7790: add QSPI support
>   ARM: shmobile: Lager:add SPI FLASH support on QSPI
> 
>  arch/arm/mach-shmobile/board-lager.c   |   64 ++++++++++++++++++++++++++++++++
>  arch/arm/mach-shmobile/clock-r8a7790.c |    4 +-
>  2 files changed, 67 insertions(+), 1 deletion(-)

For all patches

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Best regards
---
Kuninori Morimoto
