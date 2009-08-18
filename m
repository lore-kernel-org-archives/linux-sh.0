From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 18 Aug 2009 12:19:29 +0000
Subject: Re: [PATCH] kfr2409: add FLLFRQ value
Message-Id: <20090818121929.GB16502@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <ueir9y5qn.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <ueir9y5qn.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Aug 18, 2009 at 03:51:28PM +0900, Kuninori Morimoto wrote:
> FLLFRQ setting is needed to use correct PLL clock for kfr2409.

On Tue, Aug 18, 2009 at 03:51:47PM +0900, Kuninori Morimoto wrote:
> This patch modify divisors value becouse FRQCRA :: IFC can use b'0001

On Tue, Aug 18, 2009 at 04:00:20PM +0900, Kuninori Morimoto wrote:
> Current heartbeat driver has the possibility
> to change area that is not LED.
> This patch add bit mask operation to not change it.

Next time please include an 'sh: ' at the beginning of the patch
description so I don't have to go and add it manually. All applied now,
thanks!
