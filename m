From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 07 May 2010 09:33:16 +0000
Subject: Re: [PATCH] sh: add sh7757lcr board support
Message-Id: <20100507093316.GD14009@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4BE3DCDC.5090506@renesas.com>
In-Reply-To: <4BE3DCDC.5090506@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, May 07, 2010 at 06:26:52PM +0900, Yoshihiro Shimoda wrote:
> +static void sh7757lcr_power_off(void)
> +{
> +	while (1)
> +		cpu_relax();
> +}
> +
If you don't have anything useful to do here, then don't bother defining
it.
