From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 10 Feb 2010 13:14:48 +0000
Subject: Re: [PATCH] sh: extend INTC with optional ioremap() support
Message-Id: <aec7e5c31002100514g67cab9f2s4def790f7fdef1e5@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100210111739.11145.92334.sendpatchset@rxone.opensource.se>
In-Reply-To: <20100210111739.11145.92334.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, Feb 10, 2010 at 9:55 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Wed, Feb 10, 2010 at 08:17:39PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Add the member "io_window" to intc_desc to allow
>> passing a physical memory window to the INTC code.
>> The INTC code will ioremap the window if present.
>>
>> Required to support INTCS on SH-Mobile G-series.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>> ---
>>
>> =A0drivers/sh/intc.c =A0 =A0 =A0 | =A0 14 ++++++++++++++
>> =A0include/linux/sh_intc.h | =A0 =A03 +++
>> =A02 files changed, 17 insertions(+)
>>
>> --- 0006/drivers/sh/intc.c
>> +++ work/drivers/sh/intc.c =A0 =A02010-02-10 19:31:14.000000000 +0900
>> @@ -45,6 +45,8 @@ struct intc_handle_int {
>>
>> =A0struct intc_desc_int {
>> =A0 =A0 =A0 struct list_head list;
>> + =A0 =A0 unsigned long virt_base;
>> + =A0 =A0 unsigned long phys_base;
>> =A0 =A0 =A0 struct sys_device sysdev;
>> =A0 =A0 =A0 pm_message_t state;
>> =A0 =A0 =A0 unsigned long *reg;
>
> phys_base can be a phys_addr_t, while virt_base wants to be a
> void __iomem *.

Right, I almost converted the code to use void __iomem *.

>> @@ -800,6 +808,12 @@ void __init register_intc_controller(str
>> =A0 =A0 =A0 INIT_LIST_HEAD(&d->list);
>> =A0 =A0 =A0 list_add(&d->list, &intc_list);
>>
>> + =A0 =A0 if (desc->io_window) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 d->phys_base =3D desc->io_window->start;
>> + =A0 =A0 =A0 =A0 =A0 =A0 d->virt_base =3D (unsigned long)ioremap_nocach=
e(d->phys_base,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0resource_size(desc->io_window));
>> + =A0 =A0 }
>> +
> Error handling?

There is basically no error handling in the INTC code except some
BUG()s. Reworking the code a bit to get better error handling sounds
like a good plan.

>> --- 0006/include/linux/sh_intc.h
>> +++ work/include/linux/sh_intc.h =A0 =A0 =A02010-02-10 19:31:14.00000000=
0 +0900
>> @@ -71,6 +73,7 @@ struct intc_hw_desc {
>>
>> =A0struct intc_desc {
>> =A0 =A0 =A0 char *name;
>> + =A0 =A0 struct resource *io_window;
>> =A0 =A0 =A0 intc_enum force_enable;
>> =A0 =A0 =A0 struct intc_hw_desc hw;
>> =A0};
>
> io_window is pretty much completely lacking in meaning. Why does this
> platform want to pass in a resource that gets remapped while others do
> not?

Yes. I'm open to naming suggestions, but I don't think that's what
you're after. On G-series the INTCA block is covered by the 1:1 mapped
virt:phys, so it does not need to be ioremapped. The INTCS block OTOH,
it's not covered by any 1:1 mapping and therefore needs ioremap()
badly.

> This all looks terribly fragile. You're basically counting on the fact
> that all addresses are going to be covered by this window, which seems
> like a pretty lofty assumption given how some of the INTC2 registers were
> mapped out. It's also pretty ambiguous, given that this is obviously a
> an MMIO resource yet is named like a PIO one.

In some cases we may have multiple separate interrupt controllers that
happen to be covered by a single INTC table. It's of course possible
to have multiple ranges, but since it's not directly required for
INTCS support I thought I'd go with the simplest possible solution to
begin with. If the user is accessing registers outside the window then
it's a programming error - very similar to anyone accessing outside
ioremapped memory areas. Just don't. I guess you'd like to see some
range checking in the cold paths.

> Special casing the remapping is really just crap. Each of the register
> ranges wants to be remapped, while on SH given that these are in the P4
> space nothing of much note will happen. You are better off throwing in
> void __iomem * pointers for each of the register ranges that you are
> passing in and permit the data structures to use offsets in to that. This
> can be done incrementally for the SH parts, since remapping isn't going
> to change the underlying address.

So how exactly do you propose that we change the INTC data structures?
Interrupt controller code from the days before INTC used base
addresses and offsets if I'm not mistaken, and that was both hard to
read and quite error prone. I'm of course open to improve the INTC
code, but I don't see any obvious way to extend the tables as they are
today.

/ magnus
