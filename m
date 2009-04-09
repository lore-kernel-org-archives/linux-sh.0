From: morimoto.kuninori@renesas.com
Date: Thu, 09 Apr 2009 07:42:06 +0000
Subject: Re: Question about sh-sci on SH7723
Message-Id: <uy6ual1dd.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uk55vvebh.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uk55vvebh.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Iwamatsu

> We set function to use in PFC and it is from IO-port
> and controls them.
> 
> For example, we want to get RXD of SCIF0, setup PSELC and PTCR,
> and get value from PTDR.

Hmm....
Now I tried to watch PxDR behavior by JTAG.
Then, I can read data from PxDR if PxCR is "I/O".
But, I can not read data when PxCR is "Function".
It is always 0x00.
I think at least clock bit will change.

Do you know why ?

Best regards
--
Kuninori Morimoto
 
