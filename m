From: Matt Fleming <matt@console-pimps.org>
Date: Tue, 15 Sep 2009 08:39:44 +0000
Subject: Re: User mode address error problems on 7763
Message-Id: <20090915083944.GA6518@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <6e6aa1a80909111106l6dbcfccag4e9e7a3abb922688@mail.gmail.com>
In-Reply-To: <6e6aa1a80909111106l6dbcfccag4e9e7a3abb922688@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Sep 14, 2009 at 08:54:31AM -0500, Dale Larson wrote:
> On Mon, Sep 14, 2009 at 8:14 AM, Matt Fleming <matt@console-pimps.org> wrote:
>
> >There was an issue a few weeks ago
> > where we were unneccessarily reporting unaligned fix ups. It was fixed
> > by this commit,
> 
> I think later changes may have changed that. There are now a couple
> global variables used to control kernel and user messages having to do
> with address fixups in traps_32.c.:
> 
> /* bitfield: 1: warn 2: fixup 4: signal -> combinations 2|4 && 1|2|4
> are not valid! */
> static int se_usermode = 3;
> /* 0: no warning 1: print a warning message */
> static int se_kernmode_warn = 0;  /* WAS 1 - DLL20090914 */
> 

Ah, OK, I missed that change.

> 
> Log of kernel run:
> 

[...]

> Starting network...
> ip: RTNETLINK answers: File exists
> [   17.040000] Unaligned userspace access in "sh" pid9
> pc=0x295583d0 ins=0x60b2
> [   17.044000] Fixing up unaligned userspace access in "sh" pid9
> pc=0x295583d0 ins=0x60b2
> [   17.048000] Sending SIGBUS to "sh" due to unaligned access (PC
> a0042955 PR 295583da)
> Starting dropbear sshd: generating rsa key... generating dsa key... OK
> [   45.608000] Unaligned userspace access in "syslogd" pid9
> pc=0x295583d0 ins=0x60b2
> [   45.612000] Fixing up unaligned userspace access in "syslogd"
> pid9 pc=0x295583d0 ins=0x60b2
> [   45.624000] Sending SIGBUS to "syslogd" due to unaligned access (PC
> a0042955 PR 295583da)
> 

OK, these are unexpected fixups and similar to the issues I've been
seeing. The current train of thought is that these unaligned accesses
are a symptom of having aliases in the D-cache. I've been trawling
through the cache/tlb code for SH4 and so far haven't found the bug.

As a little experiment, could you try bumping the page size from 4K to
8K and see if the unaligned accesses go away? If they are caused by
D-cache aliasing, in theory, they should disappear with 8K pages.

The option in menuconfig is under,

    System type --->
    	   Memory management options --->
	   	  Kernel page size --->

> [  108.736000] ------------[ cut here ]------------
> [  108.736000] Kernel BUG at 8804492e [verbose debug info unavailable]
> [  108.736000] Kernel BUG: 003e [#1]
> [  108.736000]
> [  108.736000] Pid : 198, Comm:                 sh
> [  108.736000] CPU : 0                  Not tainted  (2.6.31-rc9 #5)
> [  108.736000]
> [  108.736000] PC is at cache_alloc_refill+0xc2/0x39c
> [  108.736000] PR is at kmem_cache_alloc+0x52/0xb0
> [  108.736000] PC  : 8804492e SP  : 8f903e94 SR  : 400080f1 TEA : 00485a14
> [  108.736000] R0  : 00000023 R1  : 0000002e R2  : 0000002e R3  : 8f8e2e48
> [  108.736000] R4  : 00000010 R5  : 8f8029a0 R6  : 8f8e2000 R7  : 0000002f
> [  108.736000] R8  : 8f8029a8 R9  : 8f809400 R10 : 8f8029b0 R11 : 8f800a20
> [  108.736000] R12 : 0000000f R13 : 00000001 R14 : 8f903e94
> [  108.736000] MACH: 00000000 MACL: 00000d74 GBR : 00000000 PR  : 88044d2a
> [  108.736000]
> [  108.736000] Call trace:
> [  108.736000]  [<88044d2a>] kmem_cache_alloc+0x52/0xb0
> [  108.736000]  [<88011790>] dup_mm+0x150/0x2cc
> [  108.736000]  [<88011e64>] copy_process+0x518/0xa9c
> [  108.736000]  [<880bc614>] memcpy+0x0/0x28c
> [  108.736000]  [<880124d6>] do_fork+0xee/0x250
> [  108.736000]  [<88003bac>] sys_fork+0x0/0x28
> [  108.736000]  [<88003bc8>] sys_fork+0x1c/0x28
> [  108.736000]  [<88003bac>] sys_fork+0x0/0x28
> [  108.736000]  [<88007226>] syscall_call+0xc/0x10
> [  108.736000]
> [  108.736000] Code:
> [  108.736000]   88044928:  mov.l     @(28,r11), r1
> [  108.736000]   8804492a:  cmp/hs    r1, r2
> [  108.736000]   8804492c:  bf        8804495a
> [  108.736000] ->8804492e:  trapa     #62
> [  108.736000]   88044930:  bra       8804495c
> [  108.736000]   88044932:  mov       r12, r4
> [  108.736000]   88044934:  mov.l     @(16,r11), r3
> [  108.736000]   88044936:  mov.l     @(20,r6), r1
> [  108.736000]   88044938:  mov.l     @r9, r2
> [  108.736000]
> [  108.736000] Process: sh (pid: 198, stack limit = 8f902001)
> [  108.736000] Stack: (0x8f903e94 to 0x8f904000)
> [  108.736000] 3e80:
> 000000d0 000000d0 00000000
> [  108.736000] 3ea0: 88044d2a 8f903ec0 8f95248c 8f8d5ba0 8f800a20
> 000000d0 00000001 00000000
> [  108.736000] 3ec0: 88011790 8f903ed8 8f8fff44 8f8d5380 00000001
> 8f952470 8f952488 8f95247c
> [  108.736000] 3ee0: 8f8d53b4 8f8d5bd4 88011e64 8f903f08 8f865900
> 8f867840 8f86793c 880bc614
> [  108.736000] 3f00: fffffff4 00000000 8f865940 00000000 8f903fa4
> 7bdf09d8 00000011 8f867954
> [  108.736000] 3f20: 00000000 8f44ec38 00000000 880124d6 8f903f58
> 00000000 00000000 00000011
> [  108.736000] 3f40: 00000071 00000000 88003bac 00000000 00000000
> 00000000 00000000 8f903fa4
> [  108.736000] 3f60: 7bdf09d8 00000000 00456fd0 10000000 00481e4c
> 88003bc8 8f903f9c ffffffff
> [  108.736000] 3f80: 295da3b8 00000000 00000071 00000100 88003bac
> 00000000 00000000 88007226
> [  108.736000] 3fa0: 7bdf09d8 00000002 00403c70 08000000 00000002
> 00485a00 00483234 00000000
> [  108.736000] 3fc0: 00000004 00483234 00485a00 00000000 004847fd
> 295da3b8 ffffffff 7bdf09d8
> [  108.736000] 3fe0: 7bdf09d8 29591782 0042403c 00000000 00000000
> 0000003e 000000c8 00000040
> [  108.740000] ---[ end trace 0313ffa0cd7d6a7f ]---
> 

Can you reliably reproduce this? A little tip when doing development is
to turn on Verbose BUG() reporting, which is located in the Kernel
Hacking menu. That'll give you a line and number in the source file.
