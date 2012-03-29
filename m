From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 29 Mar 2012 13:06:38 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7372 DT IRQ prototype
Message-Id: <201203291306.39275.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20120328103920.24945.11255.sendpatchset@w520>
In-Reply-To: <20120328103920.24945.11255.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thursday 29 March 2012, Magnus Damm wrote:

> > Hi Magnus,
> >
> > I'm trying to find my way through your patches, but I still have
> > a little trouble figuring out how it all fits together.
> 
> Right, sorry for spitting out patches to the left and to the right. =)
> 
> So the full dependencies for "base DT support" are:
> 
> renesas.git a6e24019468009a21b674e392d74283a90f415dd (origin/master)
> [PATCH 00/06] mach-shmobile device tree preparation patches V2
> [PATCH] ARM: mach-shmobile: sh7372 generic board support via DT V2
> 
> The patches above are rather ready IMO, and they've got Signed-off-by.
> 
> To get prototype level support of IRQs you will also need the following:
> [PATCH] sh: INTC IRQ domain and DT support prototype
> [PATCH] ARM: mach-shmobile: sh7372 DT IRQ prototype
> 
> The two patches above are experimental with Not-yet-signed-off-by.
> 
> There are more patches as well, but most depend on the prototype IRQ code above.

Do you have a public git tree that has all of them applied?
The separate patches are good for reviewing when one already
knows the code, but in trying to get the big picture, I'
prefer to look at the state after the patches.

> > My feeling is that the soc specific parts can be done better
> > if you generalize the interrupt controller bindings so that
> > you can describe the controller(s) as a single device, and
> > allow all the information that is now in the intc-*.c files
> > to be moved into device tree attributes to be parsed at boot
> > time, or from the translate() function of the interrupt controller
> > driver.
> 
> For sh7372 and most other of our SoCs I believe it will be difficult
> to use a single device for interrupts. This since there are a few
> different interrupt controllers working together, and they have
> different interrupt ranges associated with them. They fit quite well
> with IRQ domains and the ->dt_translate() callback and gluing them
> back together would sort of defeat the point with IRQ domains to begin
> with. It would also make it more difficult to implement proper power
> management.

Right. It wasn't clear to what degree they are actually separate bits
of hardware. If the controllers are nested in some way, you should
definitely describe them as individual device nodes.

> However, the idea that you'd like to describe the controller with the
> device tree is interesting. At this point I'm unsure how to do that.
> Also, I do wonder if it makes sense to do so at all - most new parts
> use the GIC as the main interrupt controller anyway. I do agree with
> the plan of separating configuration from code, and in our INTC case
> we've sort of already done so about 5 years ago. At that point I
> converted a few separate random implementations to the current table
> driven INTC code base. Since then we have soon close to 100 different
> users in arch/sh and arch/arm/mach-shmobile. Each is different. Feel
> free to grep for "register_intc_controller" to explore by yourself. It
> would be fun to try to use the device tree for this, but I wonder how
> we can describe anything half-complex without a preprocessor. Both the
> INTC code and the PFC used for GPIO and pinmux use C enums a lot.

Ah, so the vast majority of these are not for shmobile but for arch/sh
and I support you have no plans to move those to DT along with shmobile,
right?

From my reading of the source code, your INTCA and INTCS controllers
all follow the same basic model, but they all differ in the mapping
between interrupt vectors to register locations.

I would probably not try to describe this mapping in the interrupt
controller node, but instead use a more elaborate way to describe
an interrupt than just the vector.

Taking the sh7372 USB0_USB0I0 interrupt as an arbitrary example,
you could encode it as

	interrupts = <0x1ca0	 /* vector */
			0xa4 5	 /* mask register offset and bit position */
			0x4c 1>; /* prio register offset and bit position */

An interrupt controller that only needs these (no sense/ack registers),
would set #interrupt-cells=<5>;, while other interrupt controllers would
use a larger number of interrupt cells to also encode the extra data.

You can also use the interrupt-map to turn these into more readable
numbers for use by the devices.

I don't understand what your interrupt groups are, or whether you need
even more attributes somewhere.

> > That feeling may of course be completely wrong. Do you have
> > a link to a data sheet describing how that controller actually
> > works, or can you explain what the various arrays are needed
> > for today, and how the various interrupt controllers you register
> > fit together?
> 
> Sorry to say this, but I doubt that there are any public documents for
> our ARM based SoCs. Next time we meet face to face perhaps we can
> discuss about providing a board and documentation to you?

Sounds good. I'll be at LinuxCon Japan in June, after the Hong Kong
Linaro Connect.

> I'd be happy to try to describe how the INTC code works and how the
> sh7372 interrupt controllers are hooked together. Perhaps we can
> combine this with a chat for some more interactivity?

Ok, let's try to meet up on IRC on #armlinux on freenode then.

	Arnd
