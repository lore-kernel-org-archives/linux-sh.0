From: "Kieran Bingham" <kieranbingham@gmail.com>
Date: Fri, 14 Mar 2008 14:10:59 +0000
Subject: Re: Fixing up unaligned userspace access
Message-Id: <82bcfa4d0803140710i6af92449k9ae401cf6f9f63c0@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1204900215.12315.174.camel@atlas.mpc-data.co.uk>
In-Reply-To: <1204900215.12315.174.camel@atlas.mpc-data.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hmmm couple of issues come from looking at the Address Error Exception Hand=
ling.

If I find the offending code statement in HEW and set breakpoints
before and after, and use the continue button to iterate through the
instructions, I get the exception fired on the correct line, and all
of the regs match my expectations :

root:/home/nfs/apps> ./unaligned-access

Pid : 56, Comm:      unaligned-acces
PC is at 0xcfa0112
PC  : 0cfa0112 SP  : 0cfbff34 SR  : 00000001                   Not tainted
R0  : 0cfa00f0 R1  : f2f9f1f9 R2  : 0cfbff88 R3  : 0cfbff21
R4  : 00000001 R5  : 0cfbff6c R6  : 0cfbff74 R7  : ffffffff
R8  : 0cfbff6c R9  : 0cfbff74 R10 : 00000001 R11 : 0c31ffc0
R12 : 0c3083dc R13 : 0c2e06a8 R14 : 0cfbff34
MACH: 00000000 MACL: 00000015 GBR : 00000000 PR  : 0cfa0242
Fixing up unaligned userspace access in "unaligned-acces" pidV
pc=3D0x0cfa0112 ins=3D0x6112
instruction : 6112
Fixing up a Mov.[bwl] Insa12, rm=CD35fa4, rn=CD35fa4, *rm=F2f9f1f9, count=
=3D4
calling copy_from_user(dst : cd35fa4, src : f2f9f1f9, count 4)
Killing process "unaligned-acces" due to unaligned access
SIGSEGV

execution broke at 0x0cfa0112 as expected and handler can try and deal
with the correct lines.


However, If i just let it run its course, with no interference from HEW,


Pid : 57, Comm:      unaligned-acces
PC is at 0xcfa0116
PC  : 0cfa0116 SP  : 0cfbff34 SR  : 00000001                   Not tainted
R0  : 0cfa00f0 R1  : f2f9f1f9 R2  : 0cfbff88 R3  : 0cfbff21
R4  : 00000001 R5  : 0cfbff6c R6  : 0cfbff74 R7  : ffffffff
R8  : 0cfbff6c R9  : 0cfbff74 R10 : 00000001 R11 : 0c31ffc0
R12 : 0c3083dc R13 : 0c2e06f8 R14 : 0cfbff34
MACH: 00000000 MACL: 00000015 GBR : 00000000 PR  : 0cfa0242
Fixing up unaligned userspace access in "unaligned-acces" pidW
pc=3D0x0cfa0116 ins=3D0x0009
instruction : 9

Code from above:

0CFA010A 0009              NOP
0CFA010C 0009              NOP
0CFA010E 0009              NOP
0CFA0110 51E1              MOV.L     @(H'04:4,R14),R1    # R1 is
0x4466 at this point
0CFA0112 6112              MOV.L     @R1,R1
0CFA0114 1E13              MOV.L     R1,@(H'0C:4,R14)
0CFA0116 0009              NOP
0CFA0118 0009              NOP
0CFA011A 0009              NOP


Is there some sort of timing issue here where by the time the
exception is raised, the CPU has already started to execute the
following instructions ? Something in a pipeline perhaps ? Surely when
an address error occurs - thats it - it should stop ? But maybe I'm
missing something...


Thoughts / Comments anyone?
--
Cheers
Kieran

On 13/03/2008, Paul Mundt <lethal@linux-sh.org> wrote:
> On Wed, Mar 12, 2008 at 06:41:57PM +0000, Kieran Bingham wrote:
>  > On 07/03/2008, Adrian McMenamin <adrian@newgolddream.dyndns.info> wrot=
e:
>  > > On Fri, March 7, 2008 2:30 pm, Kieran Bingham wrote:
>  > >  >
>  > >  > Fixing up unaligned userspace access in "sh" pidH pc=3D0x0ccda168
>  > >  > ins=3D0x60f0
>  > >  >
>  > >  > Fixing up unaligned userspace access in "sh" pidH pc=3D0x0ccd9eac
>  > >  > ins=3D0x9015
>  > >  > Mainly I'm confused though, as looking at the assembly the instru=
ctions
>  > >  > aren't unaligned ? and don't seem to be trying to do anything
>  > >  > un-aligned ? - Is there something else that could be going on her=
e?
>  >
>  > > My experience - admittedly with SH4 - is that these errors are almost
>  > >  always caused by a memory leak, or access to uninitialized memory, =
elsewhere
>  > >  in the kernel.
>  >
>  > The instructions don't look like they perform anything bad, because th=
ey don't!
>  >
>  > They are the wrong instructions. ... would seem that the address error
>  > trap handler is adding 4 to the regs pointer before it calls
>  > do_address_error, so regs->pc was actually returning the PR!!
>  >
>  > Does anyone know why this code adds 4 ?
>  > Can we remove it if its incorrect (patch below)
>  >
>  > I'm working on SH2a, so I don't know if its an SH2 specific thing
>  > thats been put in ?
>  >
>
> It's definitely not an SH-2 thing. I wonder if it's a left over remnant
>  from when we were placing markers on the stack in the early days of the
>  SH-2 port. Anyways, dumping the stack from the address error path makes
>  it pretty obvious that the add is forcing all of the state to be off by
>  one register, which also explains why the regs->sr check was failing.
>
>  Given that, I'll add your patch to the 2.6.25 queue. Though it seems like
>  there are still a few corruption issues outstanding, which the slab
>  caches in particular seem to hit. There's occasional garbage in regs->pc,
>  which suggests that the exceptions are nesting and we're hitting the case
>  where the saved PC value is undefined. I've been debugging this most of
>  the day, and found a number of other bugs in the nommu code, but most of
>  the corruption issues are still outstanding (using current git both on
>  the SH7203 RSK and the SH7206 SolutionEngine).
>
