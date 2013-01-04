From: Tony Prisk <linux@prisktech.co.nz>
Date: Fri, 04 Jan 2013 01:12:06 +0000
Subject: Re: [PATCH 1/9] sh-pfc: Add OF support
Message-Id: <1357261926.25326.2.camel@gitbox>
List-Id: <linux-sh.vger.kernel.org>
References: <1357260060-32164-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	 <1357260060-32164-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1357260060-32164-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>, Phil Edworthy <phil.edworthy@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, devicetree-discuss@lists.ozlabs.org, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Fri, 2013-01-04 at 01:40 +0100, Laurent Pinchart wrote:
> +- #gpio-cells: Should be 2. The first cell is the pin number and the second cell
> +  is used to specify optional parameters (currently unused).
...
> +	gpio: pfc@e6050000 {
> +		compatible = "renesas,pfc-sh73a0";
> +		reg = <0xe6050000 0x8000>,
> +		      <0xe605801c 0x1c>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +
> +Example 2: A GPIO LED node that references a GPIO
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		led1 {
> +			gpios = <&gpio 20 1>; /* Active low */
> +		};
> +	};
> +

The second cell of gpio is '(currently unused)' but the example shows it
being used?

Regards
Tony Prisk

