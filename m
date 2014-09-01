From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 01 Sep 2014 13:21:42 +0000
Subject: Re: [PATCH] net: sh_eth: fix driver dependencies
Message-Id: <540472E6.7020901@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <3693021.H9Y3NelqF1@amdc1032>
In-Reply-To: <3693021.H9Y3NelqF1@amdc1032>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "David S. Miller" <davem@davemloft.net>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, netdev@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 9/1/2014 5:15 PM, Bartlomiej Zolnierkiewicz wrote:

> Renesas SuperH Ethernet support should be available only on
> Renesas ARM SoCs and SuperH architecture.

> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> ---
>   drivers/net/ethernet/renesas/Kconfig |    1 +
>   1 file changed, 1 insertion(+)

> Index: b/drivers/net/ethernet/renesas/Kconfig
> =================================> --- a/drivers/net/ethernet/renesas/Kconfig	2014-07-30 14:31:20.479522692 +0200
> +++ b/drivers/net/ethernet/renesas/Kconfig	2014-09-01 14:45:36.160544016 +0200
> @@ -5,6 +5,7 @@
>   config SH_ETH
>   	tristate "Renesas SuperH Ethernet support"
>   	depends on HAS_DMA
> +	depends on ARCH_SHMOBILE || ARCH_SH || COMPILE_TEST

    s/ARCH-SH/SUPERH/ perhaps?

WBR, Sergei

