From: Simon Horman <horms@verge.net.au>
Date: Mon, 14 Apr 2014 03:48:52 +0000
Subject: Re: [PATCH] ARM: shmobile: armadillo800eva: fixup SND_SOC_DAIFMT_CBx_CFx flags
Message-Id: <20140414034850.GB1948@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87fw7w38mf.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fw7w38mf.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Apr 13, 2014 at 05:59:47PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> c7a507eea1db1430476289f525f9c853d5d485e8
> (ASoC: fsi: fixup SND_SOC_DAIFMT_CBx_CFx flags)
> exchanged sound flags, but armadillo800eva flags needs IB_NF.
> The recorded sound will be noise without this patch.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, I will queue this up as a fix for v3.15.

> ---
>  arch/arm/mach-shmobile/board-armadillo800eva.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
> index 2858f38..486063d 100644
> --- a/arch/arm/mach-shmobile/board-armadillo800eva.c
> +++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
> @@ -992,6 +992,7 @@ static struct asoc_simple_card_info fsi_wm8978_info = {
>  	.platform	= "sh_fsi2",
>  	.daifmt		= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM,
>  	.cpu_dai = {
> +		.fmt	= SND_SOC_DAIFMT_IB_NF,
>  		.name	= "fsia-dai",
>  	},
>  	.codec_dai = {
> -- 
> 1.7.9.5
> 
