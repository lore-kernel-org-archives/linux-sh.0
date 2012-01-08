From: Paul Mundt <lethal@linux-sh.org>
Date: Sun, 08 Jan 2012 23:21:41 +0000
Subject: Re: [PATCH 1/2] sh: add platform_device for SUDMAC in setup-sh7757
Message-Id: <20120108232141.GB25648@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4E803B21.1030701@renesas.com>
In-Reply-To: <4E803B21.1030701@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 05, 2012 at 02:41:44PM +0900, Shimoda, Yoshihiro wrote:
> +static struct sh_dmae_pdata sudmac00_platform_data = {
> +	.slave		= sh7757_sudmac00_slaves,
> +	.slave_num	= ARRAY_SIZE(sh7757_sudmac00_slaves),
> +	.channel	= sh7757_sudmac_channel,
> +	.channel_num	= 1,
> +	.no_dmars	= 1,
> +	.no_error_irq	= 1,
> +	.sudmac		= 1,
> +};

You will have to re-spin this patch with the updated support patch
dropping the no_error_irq member.
