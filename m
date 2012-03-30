From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 30 Mar 2012 14:43:46 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7372 DT IRQ prototype
Message-Id: <201203301443.46685.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20120328103920.24945.11255.sendpatchset@w520>
In-Reply-To: <20120328103920.24945.11255.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Friday 30 March 2012, Paul Mundt wrote:
> On Thu, Mar 29, 2012 at 01:06:38PM +0000, Arnd Bergmann wrote:
> > On Thursday 29 March 2012, Magnus Damm wrote:
> > > However, the idea that you'd like to describe the controller with the
> > > device tree is interesting. At this point I'm unsure how to do that.
> > > Also, I do wonder if it makes sense to do so at all - most new parts
> > > use the GIC as the main interrupt controller anyway. I do agree with
> > > the plan of separating configuration from code, and in our INTC case
> > > we've sort of already done so about 5 years ago. At that point I
> > > converted a few separate random implementations to the current table
> > > driven INTC code base. Since then we have soon close to 100 different
> > > users in arch/sh and arch/arm/mach-shmobile. Each is different. Feel
> > > free to grep for "register_intc_controller" to explore by yourself. It
> > > would be fun to try to use the device tree for this, but I wonder how
> > > we can describe anything half-complex without a preprocessor. Both the
> > > INTC code and the PFC used for GPIO and pinmux use C enums a lot.
> > 
> > Ah, so the vast majority of these are not for shmobile but for arch/sh
> > and I support you have no plans to move those to DT along with shmobile,
> > right?
> > 
> At the moment the main priority is really just the shared SoC blocks, so
> things like the interrupt controllers, serial driver, pfc/pinmux/gpios,
> dmaengine, etc. The interrupt controller subystem that we use for all of
> our cases is sufficiently complex that it's really not an ideal choice in
> terms of low-hanging fruit for DT support, in fact, it's probably the
> worst possible place to start.
> 
> I'm in the middle of irqdomain refactoring for it now, which will also
> entail quite a lot of rework with regards to how we deal with our virtual
> IRQs, radix tree utilization, and so forth. What sort of information we
> need to still keep around ultimately won't be known until we have a
> clearer picture of how the irqdomain tie-in will look for the existing
> cases. Only after that does it really make any sense to start on anything
> but the most trivial of DT bindings.

In my experience, the interrupt controller bindings are among the first
things that one wants to work on, followed by the gpio bindings, because
most other things tend to depend on them. Now that doesn't mean the code
has to actually use all the information you put into the device tree,
but since it describes the hardware, it should be possible to find out
what information is really needed in there to describe each interrupt
line.

For INTC, you basically have two options of describing them:

a) As in Magnus' patch, give a separate "compatible" name to each
version, and let it be handled by its own code.

b) As I suggested, make a fully generic INTC binding that encodes
all the differences in device tree properties.

The first one has the significant advantage of requiring only
moderate changes to the source code, and you already have a prototype
for them. The second one requires much more work but has the advantage
that you can use it later to add support for new SoC versions
without having to add source code for the new instance of that
interrupt controller. If all other drivers for the new Soc are already
present in the kernel, you can even keep using the same kernel binaries,
which you would not be able to do with approach a).

You can probably defer the problem for a bit if you first do DT work
only for the SoCs that use GIC, which already has an established
binding. Also, it's possible to come up with a binding that you
expect to work and that can represent all the data you need, but
still keep using the existing code for as long as you need before
you get to convert it to actually use the data from the binding.
Just mark the node as compatible with both the generic INTC binding
as well as the specific itnerrupt controller for one of the SoCs,
so you can use the existing code with the tables in the kernel,
and ignore all the duplicate data from the device tree (possibly
checking the data to make sure it matches).

	Arnd
