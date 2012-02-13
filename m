From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 13 Feb 2012 23:33:04 +0000
Subject: Re: [PATCH] mackerel: Do not enable TMU timer in default config
Message-Id: <20120213233304.GA19671@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1329111377-15676-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1329111377-15676-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Feb 13, 2012 at 02:36:17PM +0900, Simon Horman wrote:
> This allows the mackerel to boot using a kernel compiled
> using the mackerel default config. Without this change
> the kernel boot hangs during or immediately after SCIF
> initialisation.
> 
> SuperH SCI(F) driver initialized
> sh-sci.0: ttySC0 at MMIO 0xe6c40000 (irq = 80) is a scifa
> sh-sci sh-sci.0: start latency exceeded, new value 5416 ns
> console [ttySC0] enabled, bootconsole disabled
> console [ttySC0] enabled, bootconsole disabled
> 
> Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> ---
> 
> This resolves a regression since 3.2.
> I am unsure if there is a cleaner way to resolve this problem
> nor if other boards are affected.

That's different. Do you see the start latency exceeded thing with TMU
disabled? Perhaps there is a pinmux conflict between some of the channels
and SCIF functions, it'd be interesting to figure out what the issue is
rather than simply hiding it. You mention this as a regression, so
presumably it worked ok up until some point? Perhaps something in the
recent batch of sh-sci updates broke existing behaviour?
