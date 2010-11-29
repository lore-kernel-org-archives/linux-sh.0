From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Nov 2010 06:03:43 +0000
Subject: Re: [PATCH 3/5] ARM: mach-shmobile: mackerel: Add LCDC support
Message-Id: <w3paaks4qf4.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3peia450p5.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3peia450p5.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus

Thank you for checking patch

> Hm, it looks like you are requesting too few pins here.
> 
> Today you request 18 data pins (LCDD0 -> LCDD17) for the pinmux, but
> the platform data for the LCDC is set to RGB24.
> 
> With RGB24 I think you should select 24 data pins (LCDD0 -> LCDD23).

Ohh. sorry.
Thats my miss.
I send modification patch soon

Best regards
--
Kuninori Morimoto
