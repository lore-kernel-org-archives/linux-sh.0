From: Saravana Kannan <skannan@codeaurora.org>
Date: Wed, 12 Jan 2011 01:54:42 +0000
Subject: Re: Locking in the clk API
Message-Id: <4D2D09E2.5030305@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201101111016.42819.jeremy.kerr@canonical.com>	<201101111744.59712.jeremy.kerr@canonical.com>	<20110111101314.GA774@linux-sh.org>	<201101111830.18597.jeremy.kerr@canonical.com>
	<20110111121816.GB774@linux-sh.org>
In-Reply-To: <20110111121816.GB774@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 01/11/2011 04:18 AM, Paul Mundt wrote:
> Again, you are approaching it from the angle that an atomic clock is a
> special requirement rather than the default behaviour. Sleeping for
> lookup, addition, and deletion are all quite acceptable, but
> enable/disable pairs have always been intended to be usable from atomic
> context. Anyone that doesn't count on that fact is either dealing with
> special case clocks (PLLs, root clocks, etc.) or simply hasn't bothered
> implementing any sort of fine grained runtime power management for their
> platform.

Paul,

I see you repeating this point a couple of times and I'm a bit confused 
how you handle the clock tree/dependencies.

Does your clock driver NOT hide the details of what root clock/PLL a 
branch clock is sourced from? If you do hide the details of the root/PLL 
source, how do you get the branch clk_enable() to be done atomically if 
the root/PLL enables are not possible in atomic context?

Is it simply a matter of your hardware having PLLs and root clocks that 
can be turned on/off quickly?

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
