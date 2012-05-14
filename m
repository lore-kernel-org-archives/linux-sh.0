From: David Brown <davidb@codeaurora.org>
Date: Mon, 14 May 2012 16:46:25 +0000
Subject: Re: [PATCH] Removal of last remaining useless system.h includes
Message-Id: <20120514164625.GA20592@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20120514114503.GC10453@n2100.arm.linux.org.uk>
In-Reply-To: <20120514114503.GC10453@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, May 14, 2012 at 12:45:03PM +0100, Russell King - ARM Linux wrote:
> mach/system.h is no longer included by anything that matters.  Most of
> the includes have already gone, and we're left with just four platforms
> which still have them (for various reasons.)  Let's remove them as
> they're now unused.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> This is more a reminder for those maintainers who still haven't responded
> to the work from about five months ago reworking the ARM restart support,
> and who need to do some work to get restart support working again for
> their platforms.
> 
>  arch/arm/mach-msm/board-sapphire.c           |    1 -
>  arch/arm/mach-msm/include/mach/system.h      |   19 -------------------
>  arch/arm/mach-msm/proc_comm.c                |    1 -
>  arch/arm/mach-msm/smd.c                      |    1 -

Acked-by: David Brown <davidb@codeaurora.org>

I'm going to poke around here and see if I can get someone to actually
implement restart.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
