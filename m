From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 28 Apr 2009 09:14:28 +0000
Subject: Re: [PATCH] clocksource: improve sh_cmt clocksource overflow handling
Message-Id: <20090428091427.GA23203@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090428081754.16592.85760.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090428081754.16592.85760.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 28, 2009 at 05:17:54PM +0900, Magnus Damm wrote:
> This patch improves the sh_cmt clocksource handling.
> 
> Currently the counter value is ignored in the case of
> overflow. With this patch the overflow flag is read
> before and after reading the counter, removing any
> counter value and overflow flag mismatch issues.

On Tue, Apr 28, 2009 at 05:19:50PM +0900, Magnus Damm wrote:
> This patch moves the SuperH timer setup code from time_init()
> to late_time_init(). Good things about this change:
>  - interrupts: they are enabled at late_time_init()
>  - mm: regular kmalloc() can be used at late_time_init()
> 
> Together with moving to late_time_init() this patch changes
> the sh_cmt driver to always allocate with kmalloc(). This
> simplifies the code a bit and also fixes section mismatches.

Applied to the sh-2.6.31 queue.
