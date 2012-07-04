From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 04 Jul 2012 10:45:13 +0000
Subject: Re: [PATCH 2/7] ARM: shmobile: r8a7740: add basic pm domain support
Message-Id: <20120704104513.GB15679@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87mx3gtc2d.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mx3gtc2d.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 03, 2012 at 08:55:25PM -0700, Kuninori Morimoto wrote:
> +void r8a7740_init_pm_domain(struct r8a7740_pm_domain *r8a7740_pd)
> +{
> +	struct generic_pm_domain *genpd = &r8a7740_pd->genpd;
> +	struct dev_power_governor *gov = r8a7740_pd->gov;
> +
> +	pm_genpd_init(genpd, gov ? : &simple_qos_governor, false);
> +	genpd->dev_ops.stop		= r8a7740_stop_dev;
> +	genpd->dev_ops.start		= r8a7740_start_dev;
> +	genpd->dev_ops.active_wakeup	= pd_active_wakeup;
> +	genpd->dev_irq_safe		= true;
> +	genpd->power_off		= pd_power_down;
> +	genpd->power_on			= pd_power_up;
> +	__pd_power_up(r8a7740_pd, false);
> +}
> +
This pd_ naming really needs to go, it clashes too much with the generic
code and it is far more confusing than it needs to be. If this is an
r8a7740 specific routine then prefix with r8a7740 accordingly.
