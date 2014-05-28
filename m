From: Simon Horman <horms@verge.net.au>
Date: Wed, 28 May 2014 04:06:13 +0000
Subject: Re: [PATCH] ARM: shmobile: armadillo800eva: fixup HDMI sound flags setting
Message-Id: <20140528040611.GB28249@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87fw7w38mf.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fw7w38mf.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, May 27, 2014 at 07:57:16PM -0700, Kuninori Morimoto wrote:
> c7a507eea1db1430476289f525f9c853d5d485e8
> (ASoC: fsi: fixup SND_SOC_DAIFMT_CBx_CFx flags)
> fixuped FSI driver's behavior
> which didn't match to ALSA flags.
> 
> But, it didn't care about armadillo800eva HDMI sound flags.
> This patch fixed it.
> 
> Reported-by: Bui Duc Phuc(Fukuda) <bd-phuc@jinso.co.jp>
> Reported-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> >> Simon
> 
> This patch is needed on latest linus/master tree

Thanks I have queued this up as a fix for v3.16.
Even though it is a fix I think it is too late for it to be included in v3.15.
Instead I will ask for it to be added to stable (LTSI) for v3.15.
And likewise for v3.14 where the problem first appeared (I think).

>  arch/arm/mach-shmobile/board-armadillo800eva.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
> index 92d24a4..deb3b38 100644
> --- a/arch/arm/mach-shmobile/board-armadillo800eva.c
> +++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
> @@ -1051,7 +1051,7 @@ static struct asoc_simple_card_info fsi2_hdmi_info = {
>  	.platform	= "sh_fsi2",
>  	.cpu_dai = {
>  		.name	= "fsib-dai",
> -		.fmt	= SND_SOC_DAIFMT_CBM_CFM,
> +		.fmt	= SND_SOC_DAIFMT_CBS_CFS,
>  	},
>  	.codec_dai = {
>  		.name = "sh_mobile_hdmi-hifi",
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
