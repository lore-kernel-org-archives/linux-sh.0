From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 May 2015 00:06:16 +0000
Subject: Re: [PATCH v2 2/2] pwm: Add support for R-Car PWM Timer
Message-Id: <87d21w3yio.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1432032159-704-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1432032159-704-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1432032159-704-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-pwm@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org


Hi Shimoda-san

I guess previous Geert's opinion about compatible is...

> +Required Properties:
> +- compatible: should be one of the following.
> + - "renesas,pwm-r8a7778": for R-Car M1A
> + - "renesas,pwm-r8a7779": for R-Car H1
> + - "renesas,pwm-r8a7790": for R-Car H2
> + - "renesas,pwm-r8a7791": for R-Car M2-W
> + - "renesas,pwm-r8a7794": for R-Car E2
(snip)
> +static const struct of_device_id rcar_pwm_of_table[] = {
> +	{ .compatible = "renesas,pwm-r8a7778", },
> +	{ .compatible = "renesas,pwm-r8a7779", },
> +	{ .compatible = "renesas,pwm-r8a7790", },
> +	{ .compatible = "renesas,pwm-r8a7791", },
> +	{ .compatible = "renesas,pwm-r8a7794", },
> +	{ },
> +};

- compatible: should be one of the following.
 - "renesas,pwm-rcar": for R-Car  < ... /* we need gen1 / gen2 here ? */
 - "renesas,pwm-r8a7778": for R-Car M1A
 - "renesas,pwm-r8a7779": for R-Car H1
 - "renesas,pwm-r8a7790": for R-Car H2
 - "renesas,pwm-r8a7791": for R-Car M2-W
 - "renesas,pwm-r8a7794": for R-Car E2

static const struct of_device_id rcar_pwm_of_table[] = {
	{ .compatible = "renesas,pwm-rcar", }, <	{ },

Best regards
---
Kuninori Morimoto
