From: Simon Horman <horms@verge.net.au>
Date: Tue, 05 Mar 2013 05:31:10 +0000
Subject: Re: [PATCH 1/3] ARM: shmobile: r8a7779: fixup dtsi typo
Message-Id: <20130305053108.GC22698@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <8738wbr664.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738wbr664.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Mar 03, 2013 at 11:11:03PM -0800, Kuninori Morimoto wrote:
> r8a7779 is not r8a7740 chip
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/boot/dts/r8a7779.dtsi |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
> index 0016302..c73eb37 100644
> --- a/arch/arm/boot/dts/r8a7779.dtsi
> +++ b/arch/arm/boot/dts/r8a7779.dtsi
> @@ -1,5 +1,5 @@
>  /*
> - * Device Tree Source for Renesas r8a7740
> + * Device Tree Source for Renesas r8a7779
>   *
>   * Copyright (C) 2013 Renesas Solutions Corp.
>   * Copyright (C) 2013 Simon Horman

Thanks, applied to the soc5 branch of the renesas tree
and thus included in its next branch and queued up for v3.10.

