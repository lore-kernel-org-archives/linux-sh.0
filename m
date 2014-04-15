From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 15 Apr 2014 12:20:48 +0000
Subject: Re: [PATCH v2 9/9] DMA: shdma: wire r8a7790
Message-Id: <534D2420.5060308@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1397511312-4845-1-git-send-email-ben.dooks@codethink.co.uk> <1397511312-4845-10-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1397511312-4845-10-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@lists.codethink.co.uk, dmaengine@vger.kernel.org
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, linux-sh@vger.kernel.org, magnus.damm@opensource.se, horms@verge.net.au, g.liakhovetski@gmx.d, kuninori.morimoto.gx@renesas.com, devicetree@vger.kernel.org

Hello.

On 15-04-2014 1:35, Ben Dooks wrote:

> Add support for R8A7790 with new device tree code.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>   drivers/dma/sh/shdmac.c | 32 +++++++++++++++++++++++++-------
>   1 file changed, 25 insertions(+), 7 deletions(-)

> diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
> index 0d765c0..eb57cf2 100644
> --- a/drivers/dma/sh/shdmac.c
> +++ b/drivers/dma/sh/shdmac.c
> @@ -342,11 +342,21 @@ static const struct sh_dmae_slave_config *dmae_find_slave(
>   			if (cfg->slave_id = match)
>   				return cfg;
>   	} else {
> -		for (i = 0, cfg = pdata->slave; i < pdata->slave_num; i++, cfg++)
> -			if (cfg->mid_rid = match) {
> +		if (!pdata->slave) {
> +			cfg = shdma_find_slave_of(shdev, match, &i);
> +			if (cfg) {
>   				sh_chan->shdma_chan.slave_id = i;
>   				return cfg;
>   			}
> +
> +			return NULL;
> +		} else

    All arms of the *if* statement should have {} if at least one arm has {}.

> +			for (i = 0, cfg = pdata->slave; i < pdata->slave_num;
> +			     i++, cfg++)
> +				if (cfg->mid_rid = match) {
> +					sh_chan->shdma_chan.slave_id = i;
> +					return cfg;
> +				}
>   	}
>
>   	return NULL;

WBR, Sergei

