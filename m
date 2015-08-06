From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 06 Aug 2015 08:46:04 +0000
Subject: Re: [PATCH 05/13 v4][RFC] arm64: renesas: Add SCIF2 support on r8a7795
Message-Id: <877fp8yfi3.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87pp30yhby.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87pp30yhby.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Shimoda-san

> > +    - "renesas,scifa-r8a7795" for R8A7795 (R-Car H3) SCIFA compatible UART.
> > +    - "renesas,scifb-r8a7795" for R8A7795 (R-Car H3) SCIFB compatible UART.
> 
> The R8A7795 doesn't have SCIFA and SCIFB.
> (In other words, it has SCIF and HSCIF.)

Grr !!
Thank you for pointing it. will fix in v5

Best regards
---
Kuninori Morimoto
