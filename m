From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 29 Mar 2012 05:29:24 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7372 DT IRQ prototype
Message-Id: <CANqRtoSJBSVY3BLVjBwbkpqrajBcmRkSs+A3jJxKToh55mfvFw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20120328103920.24945.11255.sendpatchset@w520>
In-Reply-To: <20120328103920.24945.11255.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hello Arnd,

On Wed, Mar 28, 2012 at 10:15 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 28 March 2012, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> This prototype patch extends the sh7372 DT support with actual
>> IRQ support. The heavy lifting is all done by the prototype patch
>> =A0"[PATCH] sh: INTC IRQ domain and DT support prototype".
>>
>> It is worth noting that we have 3 root interrupt controllers on
>> sh7372 and to set the parent pointer to NULL we let the device
>> tree point to itself as interrupt-parent. Seems a bit overly
>> complex so perhaps it is not the right way forward.
>>
>> All root interrupt controllers are using IRQ domains but their
>> allocation is kept the same as the non-DT case to allow us to
>> leave the demux code as-is without any modifications. So in
>> the DT case INTCA, IRQ16L and IRQ16H are kept at their original
>> IRQ positions. INTCS is allocated dynamically in case of DT
>> and at a fixed location as usual for non-DT boards.
>>
>> Anyone that wants to play with DT with interrupts on sh7372
>> will need to include this patch. The INTC IRQ domain patch above
>> needs further work which will delay the merge.
>>
>> Not-yet-signed-off-by: Magnus Damm <damm@opensource.se>
>
> Hi Magnus,
>
> I'm trying to find my way through your patches, but I still have
> a little trouble figuring out how it all fits together.

Right, sorry for spitting out patches to the left and to the right. =3D)

So the full dependencies for "base DT support" are:

renesas.git a6e24019468009a21b674e392d74283a90f415dd (origin/master)
[PATCH 00/06] mach-shmobile device tree preparation patches V2
[PATCH] ARM: mach-shmobile: sh7372 generic board support via DT V2

The patches above are rather ready IMO, and they've got Signed-off-by.

To get prototype level support of IRQs you will also need the following:
[PATCH] sh: INTC IRQ domain and DT support prototype
[PATCH] ARM: mach-shmobile: sh7372 DT IRQ prototype

The two patches above are experimental with Not-yet-signed-off-by.

There are more patches as well, but most depend on the prototype IRQ code a=
bove.

> My feeling is that the soc specific parts can be done better
> if you generalize the interrupt controller bindings so that
> you can describe the controller(s) as a single device, and
> allow all the information that is now in the intc-*.c files
> to be moved into device tree attributes to be parsed at boot
> time, or from the translate() function of the interrupt controller
> driver.

For sh7372 and most other of our SoCs I believe it will be difficult
to use a single device for interrupts. This since there are a few
different interrupt controllers working together, and they have
different interrupt ranges associated with them. They fit quite well
with IRQ domains and the ->dt_translate() callback and gluing them
back together would sort of defeat the point with IRQ domains to begin
with. It would also make it more difficult to implement proper power
management.

However, the idea that you'd like to describe the controller with the
device tree is interesting. At this point I'm unsure how to do that.
Also, I do wonder if it makes sense to do so at all - most new parts
use the GIC as the main interrupt controller anyway. I do agree with
the plan of separating configuration from code, and in our INTC case
we've sort of already done so about 5 years ago. At that point I
converted a few separate random implementations to the current table
driven INTC code base. Since then we have soon close to 100 different
users in arch/sh and arch/arm/mach-shmobile. Each is different. Feel
free to grep for "register_intc_controller" to explore by yourself. It
would be fun to try to use the device tree for this, but I wonder how
we can describe anything half-complex without a preprocessor. Both the
INTC code and the PFC used for GPIO and pinmux use C enums a lot.

> That feeling may of course be completely wrong. Do you have
> a link to a data sheet describing how that controller actually
> works, or can you explain what the various arrays are needed
> for today, and how the various interrupt controllers you register
> fit together?

Sorry to say this, but I doubt that there are any public documents for
our ARM based SoCs. Next time we meet face to face perhaps we can
discuss about providing a board and documentation to you?

I'd be happy to try to describe how the INTC code works and how the
sh7372 interrupt controllers are hooked together. Perhaps we can
combine this with a chat for some more interactivity?

Thanks for your help!

Cheers,

/ magnus
