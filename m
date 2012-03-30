From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 30 Mar 2012 14:38:59 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7372 DT IRQ prototype
Message-Id: <201203301438.59693.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20120328103920.24945.11255.sendpatchset@w520>
In-Reply-To: <20120328103920.24945.11255.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Friday 30 March 2012, Magnus Damm wrote:

> >> However, the idea that you'd like to describe the controller with the
> >> device tree is interesting. At this point I'm unsure how to do that.
> >> Also, I do wonder if it makes sense to do so at all - most new parts
> >> use the GIC as the main interrupt controller anyway. I do agree with
> >> the plan of separating configuration from code, and in our INTC case
> >> we've sort of already done so about 5 years ago. At that point I
> >> converted a few separate random implementations to the current table
> >> driven INTC code base. Since then we have soon close to 100 different
> >> users in arch/sh and arch/arm/mach-shmobile. Each is different. Feel
> >> free to grep for "register_intc_controller" to explore by yourself. It
> >> would be fun to try to use the device tree for this, but I wonder how
> >> we can describe anything half-complex without a preprocessor. Both the
> >> INTC code and the PFC used for GPIO and pinmux use C enums a lot.
> >
> > Ah, so the vast majority of these are not for shmobile but for arch/sh
> > and I support you have no plans to move those to DT along with shmobile,
> > right?
> 
> Most use cases are still on SH, but for mach-shmobile we make use of
> either GIC of INTCA together with a cascaded INTCS. We also have IRQ
> pins that can be controlled from either INTCA or INTCS or just
> level/edge trigger configuration in front of GIC. In some cases we
> have an interrupt controller called PINT. Some PFC/GPIO controllers
> have built-in interrupt controllers, and some GPIOs have their
> interrupts tied into the INTC as IRQ pins. There is a big jambalaya of
> hardware IP with history from Mitsubishi, Hitachi and NEC, plus the
> usual not-so-exotic ones.
> 
> So with this in mind I believe we will need INTC support for
> mach-shmobile in the future as well. The INTC controllers seem to
> become more like leaf nodes these days though. =)

Ok, I see

> > From my reading of the source code, your INTCA and INTCS controllers
> > all follow the same basic model, but they all differ in the mapping
> > between interrupt vectors to register locations.
> 
> All INTC tables are unique. So the INTCS in sh7372 is not the same as
> the INTCS in sh7367. Some parts of the tables may look similar, but
> low hanging fruit such as external IRQ pin handling has been broken
> out into reusable components already.

What I meant was that the table structure is always the same, even
if the contents are are different. It's fairly easy to replace
data from the kernel sources with data in the device tree, but
replacing code from the kernel with data is much harder.

> > I would probably not try to describe this mapping in the interrupt
> > controller node, but instead use a more elaborate way to describe
> > an interrupt than just the vector.
> 
> That's certainly one way to split out the information, but I wonder if
> that's the right way to go. I worry that with such setup the
> correctness of the mappings between vectors and register fields is
> dependent on the system integrator doing proper copy-paste
> "development". One character wrong and you will have a silent error
> somewhere with the wrong interrupt being masked by accident for
> instance.

All the bits describing the interrupt controller node specific
to one soc should be able to go into the .dtsi file for that soc,
so that a system integrator only needs to hook up the devices that
are outside of the soc.

> > Taking the sh7372 USB0_USB0I0 interrupt as an arbitrary example,
> > you could encode it as
> >
> >        interrupts = <0x1ca0     /* vector */
> >                        0xa4 5   /* mask register offset and bit position */
> >                        0x4c 1>; /* prio register offset and bit position */
> >
> > An interrupt controller that only needs these (no sense/ack registers),
> > would set #interrupt-cells=<5>;, while other interrupt controllers would
> > use a larger number of interrupt cells to also encode the extra data.
> 
> Thanks for showing this example. I think your proposal is interesting.
> I believe I get the big picture, but I wonder if it is that simple
> after all. In this specific example the USB0_USB0I0 interrupt source
> also needs a 0xe4 associated with the mask register. Some mask
> registers come in pairs with one clear and one set register. We also
> have the width of the register and width of the priority field as
> data. Of course the actual register mapping with such information
> could be kept together with the INTC configuration data for the
> interrupt controller, and we can for instance use register offset and
> bit field index to locate the actual bit field or bit. This becomes
> quite close to how INTC is working today though, with the exception
> that we use enums with the same names as the data sheet. I don't see
> how this can be done in Device Tree lingo.

There are two places where you could put that information. The one
I described above is the interrupts property, but if you have to
add many more fields, this gets impractical.

The other place would be sub-nodes of the interrupt controller node
that don't get translated into individual platform devices.

You can have one node per interrupt line, like this:

	intc@6940000 {
		#address-cells = <2>;
		#size-cells = <0>;
		reg = <0x6940000 0x1000>;
		ranges = <1 0  0x6940000 0x54   /* prio */
			  2 0  0x6940080 0x3c   /* mask */
			  3 0  0x69400c0 0x3c>; /* unmask /

		/* common properties for priority nodes,
		   could get overridden if necessary */
		prio-reg-width = <16>;
		prio-width = <4>;

		iprta3 {
			#address-cells = <2>;
			#size-cells = <0>;
			ranges;

			reg = <1 0x4c> /* priority reg 0x4c */

			usb0_usb0i0 {
				reg = <0 0x1ca0  /* vector 0x1ca0 */
					1 0x34   /* mask   0x80 + 0x34 */
					2 0x34>; /* unmask 0xc0 + 0x34 */
				reg-mask = <0x04>; /* bitmask for registers */
			};
		};
	};

> > I don't understand what your interrupt groups are, or whether you need
> > even more attributes somewhere.
> 
> The groups are used to link together multiple interrupt sources
> (enums) that share a priority setting.
> 
> Anyway, just to be clear, at this point i mainly wanted to enable DT
> support on the mach-shmobile subarch and sh7372 in particular. So in
> my mind this excludes reworking the INTC and PFC tables. Such
> activities will take quite some time due to them being shared with SH.
> Of course we should work in that direction, but at this point I 'd
> like to focus on getting other people to work with DT support in the
> drivers. So because of that I spent time on getting interrupts going
> with the device tree instead of figuring out how to replace the INTC
> tables with something else. Step by step.
> 
> I assume that your current merge policy is that boards should be
> implemented in DT, but we can still merge new SoCs with current style
> of INTC and PFC tables as usual?

Yes, that sounds ok. The part that I would not want to see though
is having a preliminary binding for INTC that you later have to
replace by another binding, breaking all device tree files that
were produced at first.

It's ok if you add more data to the intc nodes at a later
point while incrementally moving stuff into dts files, but I think
you should decide on how to represent an interrupt line in the devices
using intc.

	Arnd
