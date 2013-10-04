From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 04 Oct 2013 19:39:55 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: armadillo800eva: Fix RX packets errors on sh_eth
Message-Id: <524F279A.4040307@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1340189605-22074-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1340189605-22074-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 04-10-2013 7:39, Nguyen Hong Ky wrote:

    The patch is wrongly named (since it's the network driver patch, not ARM 
patch) and wrongly addressed: you should have sent it to 
netdev@vger.kernel.org where David Miller could apply it.

> This patch will fix RX packets errors when receiving big size
> of data by set bit RNC = 1.

> RNC - Receive Enable Control

> 0: Upon completion of reception of one frame, the E-DMAC writes
> the receive status to the descriptor and clears the RR bit in
> EDRRR to 0.

    As far as I know, it's the setting most of the other SoC Ethers use.

> 1: Upon completion of reception of one frame, the E-DMAC writes
> (writes back) the receive status to the descriptor. In addition,
> the E-DMAC reads the next descriptor and prepares for reception
> of the next frame.

> Signed-off-by: Nguyen Hong Ky <nh-ky@jinso.co.jp>
> ---
>   drivers/net/ethernet/renesas/sh_eth.c |    4 ++++
>   1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
> index a753928..11d34f0 100644
> --- a/drivers/net/ethernet/renesas/sh_eth.c
> +++ b/drivers/net/ethernet/renesas/sh_eth.c
> @@ -649,12 +649,16 @@ static struct sh_eth_cpu_data r8a7740_data = {
>   	.eesr_err_check	= EESR_TWB1 | EESR_TWB | EESR_TABT | EESR_RABT |
>   			  EESR_RFE | EESR_RDE | EESR_RFRMER | EESR_TFE |
>   			  EESR_TDE | EESR_ECI,
> +	.fdr_value	= 0x0000070f,
> +	.rmcr_value	= 0x00000001,
>
>   	.apr		= 1,
>   	.mpr		= 1,
>   	.tpauser	= 1,
>   	.bculr		= 1,
>   	.hw_swap	= 1,
> +	.rpadir		= 1,
> +	.rpadir_value   = 2 << 16,

   Your patch seems to change much more than is described in the changelog...

WBR, Sergei

