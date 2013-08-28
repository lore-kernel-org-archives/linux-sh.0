From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 28 Aug 2013 15:05:46 +0000
Subject: Re: [PATCH net-next 2/2] sh_eth: Enable Rx descriptor word 0 shift for r8a7790
Message-Id: <521E11CA.1020503@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1377650589-20960-1-git-send-email-horms+renesas@verge.net.au> <1377650589-20960-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1377650589-20960-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms+renesas@verge.net.au>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Kouei Abe <kouei.abe.cp@renesas.com>

Hello.

On 08/28/2013 04:43 AM, Simon Horman wrote:

> From: Kouei Abe <kouei.abe.cp@renesas.com>

> This corrects an oversight when r8a7790 support was added to sh_eth.

    No wonder it was overseen -- it's undocumented as of version 0.60 of the 
manual.

> Signed-off-by: Kouei Abe <kouei.abe.cp@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   drivers/net/ethernet/renesas/sh_eth.c | 1 +
>   1 file changed, 1 insertion(+)

> diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
> index f386a8f..095ca8e 100644
> --- a/drivers/net/ethernet/renesas/sh_eth.c
> +++ b/drivers/net/ethernet/renesas/sh_eth.c
> @@ -416,6 +416,7 @@ static struct sh_eth_cpu_data r8a7790_data = {
>   	.tpauser	= 1,
>   	.hw_swap	= 1,
>   	.rmiimode	= 1,
> +	.shift_rd0	= 1,

    I've seen the corresponding code in a Renesas BSP but wanted to double 
check before sending...

WBR, Sergei

