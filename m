From: morimoto.kuninori@renesas.com
Date: Thu, 09 Apr 2009 04:25:18 +0000
Subject: Re: Question about sh-sci on SH7723
Message-Id: <u1vs2mp1t.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uk55vvebh.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uk55vvebh.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Iwamatsu

> > I think that this is coding miss.
> > If you check implemenation of other SH CPU's(e.g. SH7722),
> > you can understand that other CPU checked RXD bit.
> 
> If this is a just "coding miss", I can understand !!
> Thank you

Oops.
But Can we really read RXD status from IO port ?
Because when we use SCIF/SCIFA,
function modules is selected in PFC.
it is not IO port.

Best regards
--
Kuninori Morimoto
 
