From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 30 Mar 2012 04:01:28 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7372 DT IRQ prototype
Message-Id: <20120330040128.GB26543@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20120328103920.24945.11255.sendpatchset@w520>
In-Reply-To: <20120328103920.24945.11255.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 29, 2012 at 01:06:38PM +0000, Arnd Bergmann wrote:
> On Thursday 29 March 2012, Magnus Damm wrote:
> > However, the idea that you'd like to describe the controller with the
> > device tree is interesting. At this point I'm unsure how to do that.
> > Also, I do wonder if it makes sense to do so at all - most new parts
> > use the GIC as the main interrupt controller anyway. I do agree with
> > the plan of separating configuration from code, and in our INTC case
> > we've sort of already done so about 5 years ago. At that point I
> > converted a few separate random implementations to the current table
> > driven INTC code base. Since then we have soon close to 100 different
> > users in arch/sh and arch/arm/mach-shmobile. Each is different. Feel
> > free to grep for "register_intc_controller" to explore by yourself. It
> > would be fun to try to use the device tree for this, but I wonder how
> > we can describe anything half-complex without a preprocessor. Both the
> > INTC code and the PFC used for GPIO and pinmux use C enums a lot.
> 
> Ah, so the vast majority of these are not for shmobile but for arch/sh
> and I support you have no plans to move those to DT along with shmobile,
> right?
> 
At the moment the main priority is really just the shared SoC blocks, so
things like the interrupt controllers, serial driver, pfc/pinmux/gpios,
dmaengine, etc. The interrupt controller subystem that we use for all of
our cases is sufficiently complex that it's really not an ideal choice in
terms of low-hanging fruit for DT support, in fact, it's probably the
worst possible place to start.

I'm in the middle of irqdomain refactoring for it now, which will also
entail quite a lot of rework with regards to how we deal with our virtual
IRQs, radix tree utilization, and so forth. What sort of information we
need to still keep around ultimately won't be known until we have a
clearer picture of how the irqdomain tie-in will look for the existing
cases. Only after that does it really make any sense to start on anything
but the most trivial of DT bindings.

Beyond that, while the vast majority of the INTC cases are in arch/sh
today, infrastructure-wise everything is sufficiently coupled together
that it wouldn't make things any simpler to treat INTCA/INTCS specially.

Once we start seeing DT bindings in shared infrastructure (especially
drivers/sh and so on) then I'll probably start gradually migrating
arch/sh users over to it, too. For the majority of users we don't really
have any sort of coherent boot ABI, which means that we're more than
likely going to always have to link the blob in to the kernel directly,
but that's another matter.

The GPIO/PFC pinmux/pinctrl bits are likewise quite complex and in flux
while I work on pinctrl migration (some work done now, but more
realistically after the irqdomain rework has happened), so it's not worth
spending any time on DT bindings there for the moment either.

At the moment pretty much any other platform device is orders of
magnitude more simplistic and workable though. I'm not sure why DT
prototyping didn't start there, instead.
