From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 30 Apr 2015 16:04:49 +0000
Subject: Re: [RFC PATCH 5/7] mmc: sh_mobile_sdhi: Add UHS-I mode support
Message-Id: <554252A1.6070302@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430396995.5802.39.camel@xylophone.i.decadent.org.uk> <1430397136.5802.44.camel@xylophone.i.decadent.org.uk>
In-Reply-To: <1430397136.5802.44.camel@xylophone.i.decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Hutchings <ben.hutchings@codethink.co.uk>, Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@lists.codethink.co.uk

Hello.

On 04/30/2015 03:32 PM, Ben Hutchings wrote:

> Implement voltage switch, supporting modes up to SDR-50.

> Based on work by Shinobu Uehara, Rob Taylor, William Towle and Ian Molton.

> This uses two voltage regulators, one external and one on the pfc.

> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> ---
>   drivers/mmc/host/sh_mobile_sdhi.c |   48 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)

> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 92a58c6007fe..c8538a256e22 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
[...]
> @@ -148,6 +150,41 @@ static void sh_mobile_sdhi_set_clk_div(struct platform_device *pdev, int clk)
>   	}
>   }
>
> +static int sh_mobile_sdhi_start_signal_voltage_switch(
> +	struct tmio_mmc_host *host, unsigned char signal_voltage)
> +{
> +	struct sh_mobile_sdhi *priv = host_to_priv(host);
> +	int min_uV, max_uV;
> +	int ret;
> +
> +	if (signal_voltage = MMC_SIGNAL_VOLTAGE_330) {
> +		min_uV = 2700000;
> +		max_uV = 3600000;
> +	} else if (signal_voltage = MMC_SIGNAL_VOLTAGE_180) {
> +		min_uV = 1700000;
> +		max_uV = 1950000;
> +	} else {
> +		return -EINVAL;
> +	}

    The above is asking to be a *switch* statement.

[...]

WBR, Sergei

