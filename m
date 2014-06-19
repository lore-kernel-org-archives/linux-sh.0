From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 19 Jun 2014 00:54:03 +0000
Subject: Re: [PATCH 09/12] ASoC: rsnd: enable SRC setting via DT
Message-Id: <87r42l90sz.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d2e6zjhf.wl%kuninori.morimoto.gx@gmail.com>
	<87zjhay4s6.wl%kuninori.morimoto.gx@renesas.com>
	<53A1A022.1020801@cogentembedded.com>
In-Reply-To: <53A1A022.1020801@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-sh@vger.kernel.org


Hi Sergei

> > @@ -640,6 +640,16 @@ static void rsnd_of_parse_src(struct platform_device *pdev,
> >   	info->src_info		= src_info;
> >   	info->src_info_nr	= nr;
> >
> > +	i = 0;
> > +	for_each_child_of_node(src_node, np) {
> > +		src_info = info->src_info + i;
> > +
> > +		of_property_read_u32(src_node, "convert-rate",
> 
>     Are you sure it's 'src_node' here, not 'np'?

Grr..
Nice catch !
Thank you for pointing it.
I will fix it in v2

Best regards
---
Kuninori Morimoto
