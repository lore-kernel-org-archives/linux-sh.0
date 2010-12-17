From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 17 Dec 2010 11:39:15 +0000
Subject: Re: [PATCH 01/03] ARM: mach-shmobile: SMP base support
Message-Id: <AANLkTi=ziv-ejjEbQaV-vKj8mytHNesjxL_+-H9iu4ey@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20101214075647.11275.25933.sendpatchset@t400s>
	<20101214075655.11275.95963.sendpatchset@t400s>
	<20101217084211.GZ9937@n2100.arm.linux.org.uk>
In-Reply-To: <20101217084211.GZ9937@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Fri, Dec 17, 2010 at 5:42 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Dec 14, 2010 at 04:56:55PM +0900, Magnus Damm wrote:
>> +/*
>> + * Reset vector for secondary CPUs.
>> + * This will be mapped at address 0 by SBAR register.
>> + * We need _long_ jump to the physical address.
>> + */
>> + =A0 =A0 .align =A012
>> +ENTRY(shmobile_secondary_vector)
>> + =A0 =A0 ldr =A0 =A0 pc, 1f
>> +1: =A0 .long =A0 secondary_startup - CONFIG_PAGE_OFFSET + CONFIG_MEMORY=
_START
>
> BTW, why not use - PAGE_OFFSET + PHYS_OFFSET here? =A0Both these macros
> are available for use in assembly code - just include asm/memory.h.

Sure, good point. This was actually the only part of this series that
I wasn't 100% satisfied with.

Will send a patch on top of this series during early next week.

Thanks,

/ magnus
