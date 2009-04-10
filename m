From: morimoto.kuninori@renesas.com
Date: Fri, 10 Apr 2009 05:24:24 +0000
Subject: Re: Question about sh-sci on SH7723
Message-Id: <uy6u9m67r.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uk55vvebh.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uk55vvebh.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul, Iwamatsu

> Now I tried to watch PxDR behavior by JTAG.
> Then, I can read data from PxDR if PxCR is "I/O".
> But, I can not read data when PxCR is "Function".
> It is always 0x00.

Is checking SCFSR::BRK (SCASSR::BRK) good idea ?
It indicate rx break.

Best regards
--
Kuninori Morimoto
 
