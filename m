From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 13 Jul 2011 11:05:04 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7372 generic suspend/resume support
Message-Id: <CANqRtoS8UwaMHo4P_SBTevesrTQXs_2u_F6fndQELQS1rEQLsg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110707134813.22370.25948.sendpatchset@t400s>
In-Reply-To: <20110707134813.22370.25948.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Thu, Jul 7, 2011 at 10:50 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jul 07, 2011 at 10:48:13PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Convert the sh7372 Core Standby code to make use
>> of the new generic ARM cpu suspend/resume code.
>
> Thanks. =A0Only thing which stands out is:
>
>> + =A0 =A0 .global sh7372_resume_core_standby
>> +sh7372_resume_core_standby:
>> + =A0 =A0 ldr =A0 =A0 pc, 1f
>> +1: =A0 .long =A0 cpu_resume - PAGE_OFFSET + PLAT_PHYS_OFFSET
>
> Is this because sh7372_resume_core_standby must be ARM stuff, but
> cpu_resume may be Thumb?

That may have something to do with it, but I suspect not. Perhaps you
wonder why I'm not pointing the reset vector directly to cpu_resume()
- that's because we need the reset vector to be aligned to 4k.

> I suspect we should make cpu_resume always be ARM instructions because I'd
> imagine a lot of firmware won't cope with Thumb entry.

So I can't guarantee this is 100% true, but I strongly suspect that
the code above is what runs directly out of reset. No firmware
involved.

I simply nicked the PA->VA conversion code from the SMP entry code in heads=
mp.S:

	.align  12
ENTRY(shmobile_secondary_vector)
	ldr     pc, 1f
1:	.long   secondary_startup - PAGE_OFFSET + PLAT_PHYS_OFFSET

Any suggestions?

Thanks for your help!

/ magnus
