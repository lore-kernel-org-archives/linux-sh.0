From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 03 Aug 2011 04:45:42 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7372 generic suspend/resume support
Message-Id: <CANqRtoR3C742triXtGbR=uTa6fdBJ_mJARrAG_COjujRPxhSvw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110707134813.22370.25948.sendpatchset@t400s>
In-Reply-To: <20110707134813.22370.25948.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, Jul 13, 2011 at 9:34 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jul 13, 2011 at 08:05:04PM +0900, Magnus Damm wrote:
>> On Thu, Jul 7, 2011 at 10:50 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Thu, Jul 07, 2011 at 10:48:13PM +0900, Magnus Damm wrote:
>> >> From: Magnus Damm <damm@opensource.se>
>> >>
>> >> Convert the sh7372 Core Standby code to make use
>> >> of the new generic ARM cpu suspend/resume code.
>> >
>> > Thanks. =A0Only thing which stands out is:
>> >
>> >> + =A0 =A0 .global sh7372_resume_core_standby
>> >> +sh7372_resume_core_standby:
>> >> + =A0 =A0 ldr =A0 =A0 pc, 1f
>> >> +1: =A0 .long =A0 cpu_resume - PAGE_OFFSET + PLAT_PHYS_OFFSET
>> >
>> > Is this because sh7372_resume_core_standby must be ARM stuff, but
>> > cpu_resume may be Thumb?
>>
>> That may have something to do with it, but I suspect not. Perhaps you
>> wonder why I'm not pointing the reset vector directly to cpu_resume()
>> - that's because we need the reset vector to be aligned to 4k.
>
> Wouldn't a simple branch instruction do here? =A0Branches are relative
> (within 24-bit) so you wouldn't need any games with v:p stuff. =A0You
> may have to put that in .data so that it can reach cpu_resume if
> you're using a large initramfs image.

Thanks, your suggestion certainly makes sense. I vaguely recall that i
actually tried a regular branch instruction before by myself, but
giving up since I couldn't get it to work for some unknown reason.

So after spending a few more minutes digging deeper this time it seems
that the PC value is not setup properly. Not what I expected - the CPU
starts executing at the specified reset vector but if I read out the
PC value with the first instruction i get this:

pc =3D 0x00000008

I expect it to be 0x404d2008 which is the reset vector 0x404d2000 plus 8.

No wonder the relative jump doesn't work.

I know that there is some magic remapping hardware that implements the
reset translation logic. Perhaps the CPU core itself still believes it
executes starting from 0 but some bus logic converts that to whatever
is specified in the reset vector register. That theory makes sense
since the hardware also allows you to specify the size of the
translated area.

So with that in mind I'd prefer to keep the code as-is. Unless you
have any suggestion how to deal with this in a better way... =3D)

Thanks,

/ magnus
