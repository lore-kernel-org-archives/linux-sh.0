From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 08 May 2009 14:30:54 +0000
Subject: Re: [PATCH] sh: clock framework update, fix count and kill off kref
Message-Id: <20090508143054.GA12373@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090508082329.30220.74580.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090508082329.30220.74580.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, May 08, 2009 at 05:23:29PM +0900, Magnus Damm wrote:
> This patch updates the clock framework use count code.
> With this patch the enable() and disable() callbacks
> only get called when counting from and to zero.
> While at it the kref stuff gets replaced with an int.

On Fri, May 08, 2009 at 05:27:19PM +0900, Magnus Damm wrote:
> This patch enables the TMU clocksource on sh7722.
> To prioritize TMU over CMT we also adjust the CMT
> clock source rating.

On Fri, May 08, 2009 at 05:32:18PM +0900, Magnus Damm wrote:
> This patch adds TMU platform data for sh7723. Both clockevent
> and clocksource support is enabled. While at it, adjust the
> CMT clocksource rating to prioritize the TMU.

Applied, thanks.
