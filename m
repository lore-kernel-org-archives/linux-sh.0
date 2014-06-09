From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 09 Jun 2014 10:58:33 +0000
Subject: Re: [PATCH 1/2] net: sh_eth: Fix receive packet "exceeded" condition in sh_eth_rx()
Message-Id: <53959359.1060407@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <53958ED5.8070108@renesas.com>
In-Reply-To: <53958ED5.8070108@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: SH-Linux <linux-sh@vger.kernel.org>

Hello.

On 09-06-2014 14:39, Yoshihiro Shimoda wrote:

> This patch fixes the packet "exceeded" condition in sh_eth_rx() when
> RACT in an RX descriptor is not set and the "quota" is 0.
> Otherwise, kernel panic happens because the "&n->poll_list" is deleted
> twice in sh_eth_poll() which calls napi_complete() and net_rx_action().

> Signed-off-by: Kouei Abe <kouei.abe.cp@renesas.com>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>   drivers/net/ethernet/renesas/sh_eth.c |    8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)

> diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
> index 08ed9a3..ad0b5bd 100644
> --- a/drivers/net/ethernet/renesas/sh_eth.c
> +++ b/drivers/net/ethernet/renesas/sh_eth.c
[...]
> @@ -1508,7 +1506,7 @@ static int sh_eth_rx(struct net_device *ndev, u32 intr_status, int *quota)
>   		sh_eth_write(ndev, EDRRR_R, EDRRR);
>   	}
>
> -	return exceeded;
> +	return (*quota <= 0);

    Parens not needed here.

WBR, Sergei

