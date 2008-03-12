From: "Kieran Bingham" <kieranbingham@gmail.com>
Date: Wed, 12 Mar 2008 18:41:57 +0000
Subject: Re: Fixing up unaligned userspace access
Message-Id: <82bcfa4d0803121141n20f5d186k8ba7144a99bdacff@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1204900215.12315.174.camel@atlas.mpc-data.co.uk>
In-Reply-To: <1204900215.12315.174.camel@atlas.mpc-data.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Think I found the fault ! :)


On 07/03/2008, Adrian McMenamin <adrian@newgolddream.dyndns.info> wrote:
> On Fri, March 7, 2008 2:30 pm, Kieran Bingham wrote:
>  >
>  > Fixing up unaligned userspace access in "sh" pidH pc=0x0ccda168
>  > ins=0x60f0
>  >
>  > Fixing up unaligned userspace access in "sh" pidH pc=0x0ccd9eac
>  > ins=0x9015
>  > Mainly I'm confused though, as looking at the assembly the instructions
>  > aren't unaligned ? and don't seem to be trying to do anything
>  > un-aligned ? - Is there something else that could be going on here?

> My experience - admittedly with SH4 - is that these errors are almost
>  always caused by a memory leak, or access to uninitialized memory, elsewhere
>  in the kernel.

The instructions don't look like they perform anything bad, because they don't!

They are the wrong instructions. ... would seem that the address error
trap handler is adding 4 to the regs pointer before it calls
do_address_error, so regs->pc was actually returning the PR!!


Does anyone know why this code adds 4 ?
Can we remove it if its incorrect (patch below)

I'm working on SH2a, so I don't know if its an SH2 specific thing
thats been put in ?



Remove erroneous offset on SH2a address error handling

Signed-off-by: Kieran Bingham <kbingham@mpc-data.co.uk>
---

diff --git a/arch/sh/kernel/cpu/sh2/entry.S b/arch/sh/kernel/cpu/sh2/entry.S
index 7a26569..0fc8906 100644
--- a/arch/sh/kernel/cpu/sh2/entry.S
+++ b/arch/sh/kernel/cpu/sh2/entry.S
@@ -267,7 +267,6 @@ ENTRY(sh_bios_handler)

 ENTRY(address_error_trap_handler)
        mov     r15,r4                          ! regs
-       add     #4,r4
        mov     #OFF_PC,r0
        mov.l   @(r0,r15),r6                    ! pc
        mov.l   1f,r0
