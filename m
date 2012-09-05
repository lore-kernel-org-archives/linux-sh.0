From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 05 Sep 2012 05:45:22 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: sh73a0: enable PMU(Performance Monitoring Unit)
Message-Id: <20120905054521.GA13568@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1346813317-4030-2-git-send-email-koba@kmckk.co.jp>
In-Reply-To: <1346813317-4030-2-git-send-email-koba@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Sep 05, 2012 at 11:48:36AM +0900, Tetsuyuki Kobayshi wrote:
> +#ifdef CONFIG_HW_PERF_EVENTS
> +static struct resource pmu_resources[] = {
> +	[0] = {
> +		.start	= gic_spi(55),
> +		.end	= gic_spi(55),
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +	[1] = {
> +		.start	= gic_spi(56),
> +		.end	= gic_spi(56),
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device pmu_device = {
> +	.name		= "arm-pmu",
> +	.id		= ARM_PMU_DEVICE_CPU,
> +	.num_resources	= ARRAY_SIZE(pmu_resources),
> +	.resource	= pmu_resources,
> +};
> +#endif
> +
There is no need for the ifdef for any of these, if perf events aren't
enabled then the arm-pmu driver to claim the platform device won't exist
and this is all harmless, as with every other platform device.

In general you should try to avoid adding ifdefs as much as possible, as
they make things not only uglier, but they lock you down to one static
configuration, while all the infrastructure exists to manage thingn for
you in a dynamic fashion.
