From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 20 Jun 2011 02:01:32 +0000
Subject: Re: [Update][PATCH 8/8] ARM / shmobile: Support for I/O power domains for SH7372 (v6)
Message-Id: <20110620020125.GA26125@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201106112223.04972.rjw@sisk.pl> <BANLkTi=u_eyGZt9e0CuVpyz9B08HarEyVw@mail.gmail.com> <201106160106.40553.rjw@sisk.pl> <201106200007.47828.rjw@sisk.pl>
In-Reply-To: <201106200007.47828.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Alan Stern <stern@rowland.harvard.edu>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org

On Mon, Jun 20, 2011 at 12:07:47AM +0200, Rafael J. Wysocki wrote:
> +static int pd_power_down(struct generic_pm_domain *genpd)
> +{
> +	struct sh7372_pm_domain *sh7372_pd = to_sh7372_pd(genpd);
> +	unsigned int mask = 1 << sh7372_pd->bit_shift;
> +
> +	if (__raw_readl(PSTR) & mask) {
> +		__raw_writel(mask, SPDCR);
> +
> +		while (__raw_readl(SPDCR) & mask)
> +			cpu_relax();
> +
> +		pr_debug("sh7372 power domain down 0x%08x -> PSTR = 0x%08x\n",
> +			 mask, __raw_readl(PSTR));
> +	}
> +
> +	return 0;
> +}
> +
> +static int pd_power_up(struct generic_pm_domain *genpd)
> +{
> +	struct sh7372_pm_domain *sh7372_pd = to_sh7372_pd(genpd);
> +	unsigned int mask = 1 << sh7372_pd->bit_shift;
> +
> +	if (!(__raw_readl(PSTR) & mask)) {
> +		__raw_writel(mask, SWUCR);
> +
> +		while (__raw_readl(SWUCR) & mask)
> +			cpu_relax();
> +
> +		pr_debug("sh7372 power domain up 0x%08x -> PSTR = 0x%08x\n",
> +			 mask, __raw_readl(PSTR));
> +	}
> +
> +	return 0;
> +}
> +
Given that these functions can return errors, it's probably more prudent
to implement some timeout logic on top of the busy loop. Hardware does
get stuck, after all.
