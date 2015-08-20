From: Simon Horman <horms@verge.net.au>
Date: Thu, 20 Aug 2015 19:06:46 +0000
Subject: Re: [PATCH 10/17 v6][RFC] arm64: renesas: add SalvatorX board support on DTS
Message-Id: <20150820190644.GJ18990@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <878u96b9ei.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878u96b9ei.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 20, 2015 at 09:27:38AM +0000, Kuninori Morimoto wrote:
> From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> 
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[snip]

> diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> new file mode 100644
> index 0000000..2d5773d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> @@ -0,0 +1,46 @@
> +/*
> + * Device Tree Source for the SalvatorX board
> + *
> + * Copyright (C) 2015 Renesas Electronics Corp.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +#include "r8a7795.dtsi"
> +
> +/ {
> +	model = "Renesas SalvatorX board based on r8a7795";
> +	compatible = "renesas,salvator-x", "renesas,r8a7795";
> +
> +	aliases {
> +		serial0 = &scif2;
> +	};
> +
> +	chosen {
> +		bootargs = "ignore_loglevel";
> +		stdout-path = &scif2;
> +	};
> +
> +	memory@48000000 {
> +		device_type = "memory";
> +		/* first 128MB is reserved for secure area. */
> +		reg = <0x0 0x48000000 0x0 0x38000000>;
> +	};
> +};
> +
> +&pfc {
> +	scif2_pins: scif2 {
> +		renesas,groups = "scif2_data";
> +		renesas,function = "scif2";
> +       };

The line above uses spaces instead of a tab for indentation.

> +};

[snip]
