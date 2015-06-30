From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 30 Jun 2015 04:43:43 +0000
Subject: Re: [PATCH v3 5/6] ARM: shmobile: lager: Set clock rates for SDHI
Message-Id: <87fv59u7vg.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1435332116.23818.7.camel@codethink.co.uk>
	<1435332230.23818.12.camel@codethink.co.uk>
	<87a8vjjas8.wl%kuninori.morimoto.gx@renesas.com>
	<1435622561.23818.43.camel@codethink.co.uk>
	<1435627793.23818.45.camel@codethink.co.uk>
	<1435627910.23818.46.camel@codethink.co.uk>
	<87zj3ieztx.wl%kuninori.morimoto.gx@renesas.com>
	<1435629999.23818.52.camel@codethink.co.uk>
In-Reply-To: <1435629999.23818.52.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Simon <horms@verge.net.au>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Linux-SH <linux-sh@vger.kernel.org>, Laurent <laurent.pinchart@ideasonboard.com>, Ian Molton <ian@mnementh.co.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@lists.codethink.co.uk, linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org


Hi Ben

> > Can you show us more detail ?
> > It seems bug...
> 
> The requested clock rate can be up to 52 MHz and the divider can be up
> to 1024.  With div = 1024 and clk = 52000000, clk * div overflows.

IMO, In such case, driver should find
 (input) 52 MHz / (divide) 1 = (request) 52 MHz
or similar.

52 GHz / 1024 = 52 MHz can be possible (from HW point),
but...
