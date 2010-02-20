From: Drasko DRASKOVIC <drasko.draskovic@gmail.com>
Date: Sat, 20 Feb 2010 00:24:38 +0000
Subject: Re: Unaligned kernel access for __udivsi3_i4i
Message-Id: <5ec3d7931002191624p4f6aa568q4c57516fa1457d06@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5ec3d7931002191551g21c0cda9le17729529b1afd78@mail.gmail.com>
In-Reply-To: <5ec3d7931002191551g21c0cda9le17729529b1afd78@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Sat, Feb 20, 2010 at 1:08 AM, Matt Fleming <matt@console-pimps.org> wrot=
e:
> On Sat, Feb 20, 2010 at 12:51:38AM +0100, Drasko DRASKOVIC wrote:
>> Hi all,
>> I am getting Unaligned kernel access on 0x809b7662
>
> Hi Drasko,
>
> I suspect that the reason that you're seeing these unaligned accesses is
> because you are dividing by zero. That's what happens when you divide by
> zero when using the libgcc softfpu divide functions; an unaligned access
> is intentionally generated because SH has no other way of signalling
> that an error occurred while doing the division.
>
> To quote from gcc/config/sh/lib1func.asm in the GCC source,
>
> "/* Lookup table translating positive divisor to index into table of
> =A0 normalized inverse. =A0N.B. the '0' entry is also the last entry of t=
he
> =A0previous table, and causes an unaligned access for division by zero. =
=A0*/"
>

Thanks Matt,
I saw this comment in uClibc source, but it did not make much sense to
me, because I did not know that SH4 will not go to some exception
state.

Does that mean that we can do division by zero that goes completely
unnoticed, unless we turn up the warnings (as kernel will fix these
unalignments without even reporting it)?

Doing: echo 1 > /proc/cpu/kernel_alignement, I saw that the kernel
unaligned access was reported. Would that say that some module is
trying division by zero, and not the application itself (because I did
echo 1 > /proc/cpu/alignment at the same time, and it was not reported
as User fault)? I am trying to isolate guilty party, so I would like
to know if it comes from the user space or kernel module (or kernel
itself).

Do you have some ah hoc ideas what would be best strategy to trace
this call back?

Thank you for your help and best regards,
Drasko
