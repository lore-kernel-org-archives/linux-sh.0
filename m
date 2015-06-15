From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 Jun 2015 23:58:11 +0000
Subject: Re: [PATCH 3/6][RFC] clk: shmobile: add Renesas R-Car Gen3 CPG support
Message-Id: <87ioaojzlt.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <871thdwp4d.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871thdwp4d.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi khiemnguyen

> > --- /dev/null
> > +++ b/drivers/clk/shmobile/clk-rcar-gen3.c
> > @@ -0,0 +1,243 @@
> > +/*
> > + * rcar_gen3 Core CPG Clocks
> > + *
> > + * Based on rcar_gen2 Core CPG Clocks driver.
> 
> I believe that we should have a copyright statement here,
> similar to patch no. 5.

Good catch !
Will do in v2


Best regards
---
Kuninori Morimoto
