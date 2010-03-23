From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 23 Mar 2010 04:36:14 +0000
Subject: Re: [PATCH] sh: Remove long unused mid_sched macro
Message-Id: <20100323043614.GG13417@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100320003800.GA7568@amos.infernal>
In-Reply-To: <20100320003800.GA7568@amos.infernal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Mar 20, 2010 at 01:38:01AM +0100, Andreas Bombe wrote:
> interruptible_sleep_on() is referenced for use in the mid_sched macro
> which is not used anywhere.  Remove reference and macro as well as the
> comment which appears to belong with them.
> 
> Signed-off-by: Andreas Bombe <aeb@debian.org>
> ---
> 
> At least the mid_sched name does not appear anywhere else.  It doesn't
> even appear to have been in use at any time during the kernel's git
> history.
> 
It definitely predates git, but the sh64 bits haven't had that much work
done on them since the BK days, so it's expected that there are still
some remnants.

Applied, thanks.
