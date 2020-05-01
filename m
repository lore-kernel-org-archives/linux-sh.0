From: Rob Landley <rob@landley.net>
Date: Fri, 01 May 2020 19:09:56 +0000
Subject: Re: [PATCH v2 0/5] Fix ELF / FDPIC ELF core dumping, and use mmap_sem properly in there
Message-Id: <cff13fb7-5045-4afd-e1d3-58af99d81d5a@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20200429214954.44866-1-jannh@google.com>
 <20200429215620.GM1551@shell.armlinux.org.uk>
 <CAHk-=wgpoEr33NJwQ+hqK1dz3Rs9jSw+BGotsSdt2Kb3HqLV7A@mail.gmail.com>
 <31196268-2ff4-7a1d-e9df-6116e92d2190@linux-m68k.org>
 <20200430145123.GE21576@brightrain.aerifal.cx>
 <6dd187b4-1958-fc40-73c4-3de53ed69a1e@linux-m68k.org>
In-Reply-To: <6dd187b4-1958-fc40-73c4-3de53ed69a1e@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Ungerer <gerg@linux-m68k.org>, Rich Felker <dalias@libc.org>
Cc: Mark Salter <msalter@redhat.com>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Nicolas Pitre <nico@fluxnic.net>, Linux-sh list <linux-sh@vger.kernel.org>, Jann Horn <jannh@google.com>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "Eric W . Biederman" <ebiederm@xmission.com>

On 5/1/20 1:00 AM, Greg Ungerer wrote:
>> This sounds correct. My understanding of FLAT shared library support
>> is that it's really bad and based on having preassigned slot indices
>> for each library on the system, and a global array per-process to give
>> to data base address for each library. Libraries are compiled to know
>> their own slot numbers so that they just load from fixed_reg[slot_id]
>> to get what's effectively their GOT pointer.

fdpic is to elf what binflt is to a.out, and a.out shared libraries were never
pretty. Or easy.

>> I'm not sure if anybody has actually used this in over a decade. Last
>> time I looked the tooling appeared broken, but in this domain lots of
>> users have forked private tooling that's not publicly available or at
>> least not publicly indexed, so it's hard to say for sure.
> 
> Be at least 12 or 13 years since I last had a working shared library
> build for m68knommu. I have not bothered with it since then, not that I
> even used it much when it worked. Seemed more pain than it was worth.

Shared libraries worked fine with fdpic on sh2 last I checked, it's basically
just ELF PIC with the ability to move the 4 segments (text/rodata/bss/data)
independently of each other. (4 base pointers, no waiting.)

I don't think I've _ever_ used shared binflt libraries. I left myself
breadcrumbs back when I was wrestling with that stuff:

  https://landley.net/notes-2014.html#07-12-2014

But it looks like that last time I touched anything using elf2flt was:

  https://landley.net/notes-2018.html#08-05-2018

And that was just because arm's fdpic support stayed out of tree for years so I
dug up binflt and gave it another go. (It sucked so much I wound up building
static pie for cortex-m, taking the efficiency hit, and moving on. Running pie
binaries on nommu _works_, it's just incredibly inefficient. Since the writeable
and readable segments of the ELF are all relative to the same single base
pointer, you can't share the read-only parts of the binaries without address
remapping, so if you launch 4 instances of PIE bash on nommu you've loaded 4
instances of the bash text and rodata, and of course none of it can even be
demand faulted. In theory shared libraries _do_ help there but I hit some ld.so
bug and didn't want to debug a half-assed solution, so big hammer and moved on
until arm fdpic got merged and fixed it _properly_...)

Rob

P.S. The reason for binflt is bare metal hardware engineers who are conceptually
uncomfortable with software love them, because it's as close to "objcopy -O
binary" as they can get. Meanwhile on j-core we've had an 8k ROM boot loader
that loads vmlinux images and does the ELF relocations for 5 years now, and ever
since the switch to device tree that's our _only_ way to feed a dtb to the
kernel without statically linking it in, so it's ELF all the way down for us.
