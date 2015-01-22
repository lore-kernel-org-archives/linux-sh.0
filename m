From: Simon Horman <horms@verge.net.au>
Date: Thu, 22 Jan 2015 02:23:16 +0000
Subject: Re: ARM: shmobile: r8a73a4: Instantiate GIC from C board code in legacy builds
Message-Id: <20150122022316.GB31170@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20150120113800.11062.65299.sendpatchset@little-apple>
In-Reply-To: <20150120113800.11062.65299.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 21, 2015 at 11:04:10AM +0000, Marc Zyngier wrote:
> On 21/01/15 10:38, Geert Uytterhoeven wrote:
> > On Wed, Jan 21, 2015 at 11:15 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> >>> arch_timer: No interrupt available, giving up
> >>> sched_clock: 32 bits at 128 Hz, resolution 7812500ns, wraps every 16777216000000000ns
> >>> Console: colour dummy device 80x30
> >>> Calibrating delay loop...
> >>
> >> That's because you seems to be using a horrible mix of DT devices (arch
> >> timers, for example), and hardcoded devices, with the added complexity
> >> of having secondary interrupt controllers.
> >>
> >> The only workaround I can think of is to patch the hardcoded interrupts
> >> at boot time with something similar to what I cooked there:
> >>
> >> http://www.spinics.net/lists/linux-omap/msg114814.html
> >>
> >> At the moment, you either end-up with no interrupts for the DT devices
> >> (as above), or with an exploding system because the hardcoded interrupts
> >> completely wrong (as in the original post).
> >>
> >> I don't have access to such hardware, but I'm happy to help.
> > 
> > Thanks!
> > 
> > That solution looks convoluted to me, especially since we do have patches
> > available to convert r8a73a4 to multiplatform-only.
> 
> If you don't mind having a cycle with a broken board, my vote is to go
> for full multiplatform. It makes my job much easier! ;-)
> 
> > That won't make it in v3.19 this late in the cycle, but if we push hard, v3.20
> > should be doable IMHO.
> 
> OK. In any case, let me know if I can help you with this transition.

My feeling is that it is also too late for v3.20.
But that we should let this problem go as multiplatform is on its way.

Magnus may have a different opinion on this.
