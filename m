From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 30 Mar 2012 07:26:53 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7372 DT IRQ prototype
Message-Id: <CANqRtoQoO5BJZKpyonAHfHbBnDdjCSm+hD9sYvNu2P3_E0wCNA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20120328103920.24945.11255.sendpatchset@w520>
In-Reply-To: <20120328103920.24945.11255.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hello Arnd,

On Thu, Mar 29, 2012 at 10:06 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 29 March 2012, Magnus Damm wrote:
>
>> > Hi Magnus,
>> >
>> > I'm trying to find my way through your patches, but I still have
>> > a little trouble figuring out how it all fits together.
>>
>> Right, sorry for spitting out patches to the left and to the right. =3D)
>>
>> So the full dependencies for "base DT support" are:
>>
>> renesas.git a6e24019468009a21b674e392d74283a90f415dd (origin/master)
>> [PATCH 00/06] mach-shmobile device tree preparation patches V2
>> [PATCH] ARM: mach-shmobile: sh7372 generic board support via DT V2
>>
>> The patches above are rather ready IMO, and they've got Signed-off-by.
>>
>> To get prototype level support of IRQs you will also need the following:
>> [PATCH] sh: INTC IRQ domain and DT support prototype
>> [PATCH] ARM: mach-shmobile: sh7372 DT IRQ prototype
>>
>> The two patches above are experimental with Not-yet-signed-off-by.
>>
>> There are more patches as well, but most depend on the prototype IRQ cod=
e above.
>
> Do you have a public git tree that has all of them applied?

Sorry, there is no such thing. I believe Rafael will pick up the ones
with Signed-off-by and put them in a branch based on v3.4-rc1. He may
be able to pull in other more experimental patches based on that tree,
but I am somewhat hesitant since I don't want to give people the false
impression that the code is ready when it's certainly not. The
experimental code will change a lot, that's a fact.

> The separate patches are good for reviewing when one already
> knows the code, but in trying to get the big picture, I'
> prefer to look at the state after the patches.

I understand. I suppose the branch created by Rafael will take you
half-way at least.

>> > My feeling is that the soc specific parts can be done better
>> > if you generalize the interrupt controller bindings so that
>> > you can describe the controller(s) as a single device, and
>> > allow all the information that is now in the intc-*.c files
>> > to be moved into device tree attributes to be parsed at boot
>> > time, or from the translate() function of the interrupt controller
>> > driver.
>>
>> For sh7372 and most other of our SoCs I believe it will be difficult
>> to use a single device for interrupts. This since there are a few
>> different interrupt controllers working together, and they have
>> different interrupt ranges associated with them. They fit quite well
>> with IRQ domains and the ->dt_translate() callback and gluing them
>> back together would sort of defeat the point with IRQ domains to begin
>> with. It would also make it more difficult to implement proper power
>> management.
>
> Right. It wasn't clear to what degree they are actually separate bits
> of hardware. If the controllers are nested in some way, you should
> definitely describe them as individual device nodes.

Good!

>> However, the idea that you'd like to describe the controller with the
>> device tree is interesting. At this point I'm unsure how to do that.
>> Also, I do wonder if it makes sense to do so at all - most new parts
>> use the GIC as the main interrupt controller anyway. I do agree with
>> the plan of separating configuration from code, and in our INTC case
>> we've sort of already done so about 5 years ago. At that point I
>> converted a few separate random implementations to the current table
>> driven INTC code base. Since then we have soon close to 100 different
>> users in arch/sh and arch/arm/mach-shmobile. Each is different. Feel
>> free to grep for "register_intc_controller" to explore by yourself. It
>> would be fun to try to use the device tree for this, but I wonder how
>> we can describe anything half-complex without a preprocessor. Both the
>> INTC code and the PFC used for GPIO and pinmux use C enums a lot.
>
> Ah, so the vast majority of these are not for shmobile but for arch/sh
> and I support you have no plans to move those to DT along with shmobile,
> right?

Most use cases are still on SH, but for mach-shmobile we make use of
either GIC of INTCA together with a cascaded INTCS. We also have IRQ
pins that can be controlled from either INTCA or INTCS or just
level/edge trigger configuration in front of GIC. In some cases we
have an interrupt controller called PINT. Some PFC/GPIO controllers
have built-in interrupt controllers, and some GPIOs have their
interrupts tied into the INTC as IRQ pins. There is a big jambalaya of
hardware IP with history from Mitsubishi, Hitachi and NEC, plus the
usual not-so-exotic ones.

So with this in mind I believe we will need INTC support for
mach-shmobile in the future as well. The INTC controllers seem to
become more like leaf nodes these days though. =3D)

> From my reading of the source code, your INTCA and INTCS controllers
> all follow the same basic model, but they all differ in the mapping
> between interrupt vectors to register locations.

All INTC tables are unique. So the INTCS in sh7372 is not the same as
the INTCS in sh7367. Some parts of the tables may look similar, but
low hanging fruit such as external IRQ pin handling has been broken
out into reusable components already.

> I would probably not try to describe this mapping in the interrupt
> controller node, but instead use a more elaborate way to describe
> an interrupt than just the vector.

That's certainly one way to split out the information, but I wonder if
that's the right way to go. I worry that with such setup the
correctness of the mappings between vectors and register fields is
dependent on the system integrator doing proper copy-paste
"development". One character wrong and you will have a silent error
somewhere with the wrong interrupt being masked by accident for
instance.

> Taking the sh7372 USB0_USB0I0 interrupt as an arbitrary example,
> you could encode it as
>
> =A0 =A0 =A0 =A0interrupts =3D <0x1ca0 =A0 =A0 /* vector */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00xa4 5 =A0 /* mask registe=
r offset and bit position */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x4c 1>; /* prio register =
offset and bit position */
>
> An interrupt controller that only needs these (no sense/ack registers),
> would set #interrupt-cells=3D<5>;, while other interrupt controllers would
> use a larger number of interrupt cells to also encode the extra data.

Thanks for showing this example. I think your proposal is interesting.
I believe I get the big picture, but I wonder if it is that simple
after all. In this specific example the USB0_USB0I0 interrupt source
also needs a 0xe4 associated with the mask register. Some mask
registers come in pairs with one clear and one set register. We also
have the width of the register and width of the priority field as
data. Of course the actual register mapping with such information
could be kept together with the INTC configuration data for the
interrupt controller, and we can for instance use register offset and
bit field index to locate the actual bit field or bit. This becomes
quite close to how INTC is working today though, with the exception
that we use enums with the same names as the data sheet. I don't see
how this can be done in Device Tree lingo.

If possible I'd like to keep the interrupt tables self-contained in
one place. I don't mind so much if it is kept in C or DT, but I'd like
to keep the same goals as we had with our INTC tables:
- Easy data entry straight from data sheet
- O(1) interrupt handling for timing critical interrupt handling
- Low memory consumption
- Some way to reduce risk of typos (preprocessor in case of C)

> You can also use the interrupt-map to turn these into more readable
> numbers for use by the devices.

Ok, perhaps that will remove the undesired side effects then. If so it
may be a nice idea.

> I don't understand what your interrupt groups are, or whether you need
> even more attributes somewhere.

The groups are used to link together multiple interrupt sources
(enums) that share a priority setting.

Anyway, just to be clear, at this point i mainly wanted to enable DT
support on the mach-shmobile subarch and sh7372 in particular. So in
my mind this excludes reworking the INTC and PFC tables. Such
activities will take quite some time due to them being shared with SH.
Of course we should work in that direction, but at this point I 'd
like to focus on getting other people to work with DT support in the
drivers. So because of that I spent time on getting interrupts going
with the device tree instead of figuring out how to replace the INTC
tables with something else. Step by step.

I assume that your current merge policy is that boards should be
implemented in DT, but we can still merge new SoCs with current style
of INTC and PFC tables as usual?

I hope that's the case, and if not then there is an increased risk of
out of tree SoCs development. This to be able to meet customer demand
on schedule. I'd like to keep the customer bits synchronized with
upstream, and if we can't get things merged due to lacking
dependencies then we will need to rethink how to deal with this.

Thanks for your help with the review. I very much welcome your
comments on the patches with Signed-off-by, and as for the patches
with Not-yet-signed-off-by, please note that they are work in
progress. The IRQ related bits will be reworked and upstreamed by Paul
Mundt. So I see my work in the IRQ department close to done - apart
from chatting with you about it of course.

>> > That feeling may of course be completely wrong. Do you have
>> > a link to a data sheet describing how that controller actually
>> > works, or can you explain what the various arrays are needed
>> > for today, and how the various interrupt controllers you register
>> > fit together?
>>
>> Sorry to say this, but I doubt that there are any public documents for
>> our ARM based SoCs. Next time we meet face to face perhaps we can
>> discuss about providing a board and documentation to you?
>
> Sounds good. I'll be at LinuxCon Japan in June, after the Hong Kong
> Linaro Connect.

Cool, see you then!

>> I'd be happy to try to describe how the INTC code works and how the
>> sh7372 interrupt controllers are hooked together. Perhaps we can
>> combine this with a chat for some more interactivity?
>
> Ok, let's try to meet up on IRC on #armlinux on freenode then.

Good idea. I'll contact you privately to agree on some time that works
with both meeting schedules and time zones.

Thanks,

/ magnus
