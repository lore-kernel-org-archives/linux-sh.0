From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 15 Mar 2012 06:09:39 +0000
Subject: Re: [PATCH] sh-sci: fix a race of DMA submit_tx on transfer
Message-Id: <20120315060938.GB10046@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4F5DC485.8020607@renesas.com>
In-Reply-To: <4F5DC485.8020607@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 14, 2012 at 04:14:43PM +0900, Takashi Yoshii wrote:
>     serial: sh-sci: fix a race of DMA submit_tx on transfer
>     
>     When DMA is enabled, sh-sci transfer begins with
>      uart_start()
>       sci_start_tx()
>         if (cookie_tx < 0) schedule_work()
>     Then, starts DMA when wq scheduled, -- (A)
>      process_one_work()
>       work_fn_rx()
>        cookie_tx = desc->submit_tx()
>     And finishes when DMA transfer ends, -- (B)
>      sci_dma_tx_complete()
>       async_tx_ack()
>       cookie_tx = -EINVAL
>       (possible another schedule_work())
>     
>     This A to B sequence is not reentrant, since controlling variables
>     (for example, cookie_tx above) are not queues nor lists. So, they
>     must be invoked as A B A B..., otherwise results in kernel crash.
>     
>     To ensure the sequence, sci_start_tx() seems to test if cookie_tx < 0
>     (represents "not used") to call schedule_work().
>     But cookie_tx will not be set (to a cookie, also means "used") until
>     in the middle of work queue scheduled function work_fn_tx().
>     
>     This gap between the test and set allows the breakage of the sequence
>     under the very frequently call of uart_start().
>     Another gap between async_tx_ack() and another schedule_work() results
>     in the same issue, too.
>     
>     This patch introduces a new condition "cookie_tx = 0" just to mark
>     it is "busy" and assign it within spin-locked region to fill the gaps.
>     
>     Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
>     Reviewed-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Looks good to me. I'll apply it unless Guennadi has any other concerns.
