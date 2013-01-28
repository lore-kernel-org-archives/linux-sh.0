From: Chris Ball <cjb@laptop.org>
Date: Mon, 28 Jan 2013 22:23:32 +0000
Subject: Re: [PATCH v2 02/11] mmc: deprecate redundant cd-inverted and wp-inverted DT properties
Message-Id: <874ni16j6j.fsf@laptop.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1358955158-1510-1-git-send-email-g.liakhovetski@gmx.de>
	<1358955158-1510-3-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1358955158-1510-3-git-send-email-g.liakhovetski@gmx.de>
	(Guennadi Liakhovetski's message of "Wed, 23 Jan 2013 16:32:29 +0100")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Hi Guennadi,

On Wed, Jan 23 2013, Guennadi Liakhovetski wrote:
> +cd-inverted and wp-inverted properties are deprecated ans shouldn't be used,
> +instead pleaseuse the OF_GPIO_ACTIVE_LOW flag in respective GPIO bindings. Note,
> +that the default (as defined by the SDHCI standard) CD and WP polarity is
> +active-low, so, OF_GPIO_ACTIVE_LOW should normally be set, and only be left
> +clear, if the polarity is inverted.

Please use this text for your next version, fixing typos and a newline:

cd-inverted and wp-inverted properties are deprecated and shouldn't be used,
instead please use the OF_GPIO_ACTIVE_LOW flag in respective GPIO bindings.
Note that the default (as defined by the SDHCI standard) CD and WP polarity
is active-low, so OF_GPIO_ACTIVE_LOW should normally be set, and only be
left clear if the polarity is inverted.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
