From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 26 Aug 2014 07:52:10 +0000
Subject: Re: [PATCH] ARM: shmobile: lager: correct memory map
Message-Id: <CAMuHMdVqZ29-jaS+kLwdVycLOMSbz9H7oJGuq3dLH2y-81mVcQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1409021623-10633-1-git-send-email-horms+renesas@verge.net.au>
 <CAOesGMieRk4Dvg=gxTgcVssARkK6DeoaVyK8619B2N5=wwo=Uw@mail.gmail.com>
 <20140826042055.GA12108@verge.net.au>
In-Reply-To: <20140826042055.GA12108@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Aug 26, 2014 at 6:20 AM, Simon Horman <horms@verge.net.au> wrote:
>> > diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
>> > index 0118cbf..84dcafa 100644
>> > --- a/arch/arm/boot/dts/r8a7790-lager.dts
>> > +++ b/arch/arm/boot/dts/r8a7790-lager.dts
>> > @@ -32,7 +32,7 @@
>> >                 reg = <0 0x40000000 0 0x40000000>;
>> >         };
>> >
>> > -       memory@180000000 {
>> > +       memory@140000000 {
>>
>> That should even be "memory@1,40000000".
>
> Two comma-separated 32bit values in the case
> where a memory range starts above 4Gb?

Yes. As #address-cells is 2, there should be two values after the "@"
(the first one may be optional if it's zero, I don't know for sure?)

> If so it looks like this will be the first user of that syntax
> (I don't see any in linux-next today).

No, "git grep '@.*,' -- arch/arm/boot/dts" shows several users.
Not all of them are 64-bit memory addresses, but some are.

> I do however see several users of memrory@64bit_value.
> Mostly other renesas fds files; ecx-2000.dts being the exception.
> Should they be fixed too?
>
> $ find -name "*.dts" | xargs grep memory@[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]
> ./arch/arm/boot/dts/r8a7791-henninger.dts:      memory@200000000 {
> ./arch/arm/boot/dts/r8a7791-koelsch.dts:        memory@200000000 {
> ./arch/arm/boot/dts/ecx-2000.dts:       memory@200000000 {
> ./arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts:      memory@200000000 {
> ./arch/arm/boot/dts/r8a7790-lager.dts:  memory@180000000 {
> ./arch/arm/boot/dts/r8a73a4-ape6evm.dts:        memory@200000000 {

Yes, these should be fixed, too.

It's a pity dtc doesn't complain about this.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
