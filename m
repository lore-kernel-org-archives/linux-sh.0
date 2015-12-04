From: Manish Badarkhe <badarkhe.manish@gmail.com>
Date: Fri, 04 Dec 2015 06:33:13 +0000
Subject: Re: [PATCH 2/4] thermal: rcar: enable to use thermal-zone on DT
Message-Id: <CAKDJKT47kHx9vNO_L_h085cJs3ACndiA9sQL7e2K5PtYySWJxA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <871tb2hpn2.wl%kuninori.morimoto.gx@renesas.com>
	<87y4dagb0i.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y4dagb0i.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi


> +static int rcar_thermal_of_get_temp(void *data, int *temp)
> +{
> +       struct rcar_thermal_priv *priv = data;
> +
> +       *temp = rcar_thermal_get_current_temp(priv);
> +
> +       return 0;
> +}
> +
> +static int rcar_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
> +{
> +       struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
> +
> +       *temp = rcar_thermal_get_current_temp(priv);
> +
>         return 0;
>  }
>

Above two function, always returns 0. Can it possible to handle error
and log some messages.

Regards
Manish Badarkhe
