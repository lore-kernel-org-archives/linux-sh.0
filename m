From: kuninori.morimoto.gx@renesas.com
Date: Tue, 12 Jul 2011 10:51:54 +0000
Subject: Re: [PATCH v2] mmc: tmio: fix recursive spinlock, don't schedule with interrupts disabled
Message-Id: <87y603g4al.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1106151549050.23363@axis700.grange>
	<Pine.LNX.4.64.1106201803520.11365@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1106201803520.11365@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Chris Ball <cjb@laptop.org>, Magnus Damm <damm@opensource.se>


> Calling mmc_request_done() under a spinlock with interrupts disabled
> leads to a recursive spin-lock on request retry path and to
> scheduling in atomic context. This patch fixes both these problems
> by moving mmc_request_done() to the scheduler workqueue.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---

I tested this patch, and it solved boot hungup issue on Ecovec board.
Thanks Guennadi. (and sorry for the extended delay)

Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
