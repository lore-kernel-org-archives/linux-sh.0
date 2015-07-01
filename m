From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 01 Jul 2015 00:28:11 +0000
Subject: Re: [PATCH v4 0/8] UHS-I support for sh_mobile_sdhi
Message-Id: <87lhf0911f.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1435683177.23818.60.camel@codethink.co.uk>
In-Reply-To: <1435683177.23818.60.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Ian Molton <ian@mnementh.co.uk>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>


Hi Ben

Thank you for your hard work

> This series adds support for UHS-I in sh_mobile_sdhi, partly implemented
> in tmio_mmc.  This does not yet include tuning for SDR-104, but SDR-50 now
> works on the R8A7790 Lager board and another development board.
> 
> The pfc block needs to be reconfigured from 3.3V to 1.8V signalling on
> the pins wired to the SD card.  This is supported by implementing the
> pinconf power-source parameter.  I expect that several SH SoCs have this
> capability, but I only have the R8A7790 data sheet so I only implemented
> it for that one.

For tmio/sh_mobile_sdhi

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Best regards
---
Kuninori Morimoto
