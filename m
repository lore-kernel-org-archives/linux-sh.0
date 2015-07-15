From: Simon Horman <horms@verge.net.au>
Date: Wed, 15 Jul 2015 00:17:54 +0000
Subject: Re: [PATCH 0/3] ARM: shmobile: add sound missing parts on DT
Message-Id: <20150715001752.GD30642@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <877fq3basy.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877fq3basy.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Tue, Jul 14, 2015 at 04:55:25AM +0000, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> These patches are not so important, but useful, especially
> for debug/test.
> 1), 2) add missing sound label on DTS.
> 3) enables DPCM related sound card driver which is not used in upstream.
> But, it is needed if customer wants advanced sound feature.
> 
> Kuninori Morimoto (3):
>       1) ARM: shmobile: lager: add sound label on DTS
>       2) ARM: shmobile: koelsch: add sound label on DTS
>       3) ARM: shmobile: defconfig: add Renesas DPCM Sound Card

Thanks, I have queued these up.

Please consider posting a follow-up patch to enable
CONFIG_SND_SOC_RSRC_CARD in multi_v7_defconfig.

>  arch/arm/boot/dts/r8a7790-lager.dts   | 2 +-
>  arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
>  arch/arm/configs/shmobile_defconfig   | 1 +
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> 
> Best regards
> ---
> Kuninori Morimoto
> 
