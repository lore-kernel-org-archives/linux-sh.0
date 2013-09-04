From: David Miller <davem@davemloft.net>
Date: Wed, 04 Sep 2013 18:56:11 +0000
Subject: Re: [PATCH] sh_eth: fix napi_{en|dis}able() calls racing against interrupts
Message-Id: <20130904.145611.744777528462788964.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201309040241.27834.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201309040241.27834.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 4 Sep 2013 02:41:27 +0400

> While implementing NAPI for the driver, I overlooked the race conditions where
> interrupt  handler might have called napi_schedule_prep() before napi_enable()
> was called or after napi_disable() was called. If RX interrupt happens, this
> would cause the endless interrupts and messages like:
> 
> sh-eth eth0: ignoring interrupt, status 0x00040000, mask 0x01ff009f.
> 
> The interrupt wouldn't even be masked by the kernel eventually since the handler
> would return IRQ_HANDLED all the time.
> 
> As a fix, move napi_enable() call before request_irq() call and napi_disable()
> call after free_irq() call.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied and queued up for -stable, thanks!
