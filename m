From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 May 2014 10:22:04 +0000
Subject: Re: [PATCH v2 12/17] clk: shmobile: mstp: Fix the is_enabled() operation
Message-Id: <6169201.Ty7rNI3ZDf@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1397565253-22741-13-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1397565253-22741-13-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tuesday 13 May 2014 08:47:29 Geert Uytterhoeven wrote:
> On Tue, May 13, 2014 at 12:20 AM, Laurent Pinchart wrote:
> > On Tuesday 15 April 2014 14:34:08 Geert Uytterhoeven wrote:
> >> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> >> 
> >> The MSTP[SC]R registers have clock stop bits, not clock enable bits. The
> >> bit value should thus be inverted in the is_enabled() operation.
> >> 
> >> Signed-off-by: Laurent Pinchart
> >> <laurent.pinchart+renesas@ideasonboard.com>
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> Cc: Mike Turquette <mturquette@linaro.org>
> >> ---
> >> This depends on the actual fixes, so either we need Mike's ack, or this
> >> has to wait until the fixes have landed in mainline.
> > 
> > What's the status of this patch ? Do you still carry it in your tree and
> > plan to push it upstream at some point ?
> 
> Yes, I still have it locally.
> 
> It depends on "[PATCH v4] drivers: sh: compile drivers/sh/pm_runtime.c
> if ARCH_SHMOBILE_MULTI", so we have to wait until that one hits
> mainline.
> 
> I think the only ill effects of not having it is that some clocks may not be
> disabled properly?

Correct. It's not so urgent, I was just going through my pending patches 
yesterday to make sure none got forgotten.

-- 
Regards,

Laurent Pinchart

