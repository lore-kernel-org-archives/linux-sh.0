From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 27 Jun 2012 00:49:10 +0000
Subject: Re: [PATCH 01/13 v2] sh: ecovec: switch MMC power control to regulators
Message-Id: <20120627004910.GG24033@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1340751009-18663-2-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1340751009-18663-2-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jun 27, 2012 at 12:49:57AM +0200, Guennadi Liakhovetski wrote:
> Power on the CN11 and CN12 SD/MMC slots on ecovec is controlled by GPIOs,
> which makes it possible to use the fixed voltage regulator driver to switch
> card power on and off.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> v2: request the SD/MMC power-switching GPIO not in the board initialisation 
> routine, but in the .set_pwr() callback similar to ag5evm.
> 
That looks fine, but..

>  static void sdhi0_set_pwr(struct platform_device *pdev, int state)
>  {
> +	static int power_gpio = -EINVAL;
> +
> +	if (power_gpio < 0) {
> +		int ret = gpio_request(GPIO_PTB6, NULL);
> +		if (!ret) {
> +			power_gpio = GPIO_PTB6;
> +			gpio_direction_output(power_gpio, 0);
> +		}

You do have the platform device available here, so there's no reason to
have a NULL label for gpio_request(). Even just wrapping to dev_name()
will be more helpful.

> -#if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
> -/* SDHI1 */
> -static void sdhi1_set_pwr(struct platform_device *pdev, int state)
> +static void cn12_set_pwr(struct platform_device *pdev, int state)
>  {
> +	static int power_gpio = -EINVAL;
> +
> +	if (power_gpio < 0) {
> +		int ret = gpio_request(GPIO_PTB7, NULL);

Likewise.
