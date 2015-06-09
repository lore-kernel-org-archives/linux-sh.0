From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 09 Jun 2015 21:02:00 +0000
Subject: Re: [PATCH v5] ARM: smp: Only expose /sys/.../cpuX/online if hotpluggable
Message-Id: <20150609210200.GI7557@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1428705191-15670-1-git-send-email-sboyd@codeaurora.org>
 <20150413134246.GS12732@n2100.arm.linux.org.uk>
 <557739AC.8000903@codeaurora.org>
In-Reply-To: <557739AC.8000903@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jun 09, 2015 at 12:08:28PM -0700, Stephen Boyd wrote:
> On 04/13/2015 06:42 AM, Russell King - ARM Linux wrote:
> > On Fri, Apr 10, 2015 at 03:33:11PM -0700, Stephen Boyd wrote:
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Nicolas Pitre <nico@linaro.org>
> >> Cc: Dave Martin <Dave.Martin@arm.com>
> >> Acked-by: Simon Horman <horms@verge.net.au> [shmobile portion]
> >> Tested-by: Simon Horman <horms@verge.net.au>
> >> Cc: Magnus Damm <magnus.damm@gmail.com>
> >> Cc: <linux-sh@vger.kernel.org>
> >> Cc: Tyler Baker <tyler.baker@linaro.org>
> >> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> >> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > Let's see some more acks for this...
> >
> 
> Nobody else has acked this so far. Shall I put it in the patch tracker
> now? Or is there someone more specific we need an ack from?

I guess if people haven't responded by now, they're never going to respond,
and I guess we take their non-response as tacit approval for the change.

Maybe we ought to have tacit-acked-by: which we can add when someones
been Cc'd and hasn't responded. :)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
