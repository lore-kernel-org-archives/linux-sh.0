From: Rich Felker <dalias@libc.org>
Date: Fri, 18 Mar 2016 22:43:33 +0000
Subject: Re: [GIT PULL] arch/sh updates for 4.6
Message-Id: <20160318224333.GR21636@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20160317220453.GA889@brightrain.aerifal.cx>
 <CA+55aFzXUoh6ktJ+wWmwdg6ERjHJWbvrKQ5CoRCy-Sw620Ex+g@mail.gmail.com>
In-Reply-To: <CA+55aFzXUoh6ktJ+wWmwdg6ERjHJWbvrKQ5CoRCy-Sw620Ex+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Yoshinori Sato <ysato@users.sourceforge.jp>

On Thu, Mar 17, 2016 at 08:18:25PM -0700, Linus Torvalds wrote:
> On Thu, Mar 17, 2016 at 3:04 PM, Rich Felker <dalias@libc.org> wrote:
> >
> > Using git.libc.org for the sh tree is only temporary until we get one
> > setup on kernel.org, which is pending getting signatures on my key. I
> > hope to resolve that at ELC next month. Let me know if there's
> > anything you'd like me to do in the mean time to establish some
> > alternate basis of trust for these commits; hopefully it's less of an
> > issue being that they're not touching anything but a previously
> > unmaintained arch.
> 
> I really want to see signed tags when pulling from non-kernel.org places.
> 
> Even if you don't have signatures I can check on your keys, I want to
> see your key used for signing anyway, so that when your next pull
> request comes in I see that it's the same key (and hopefully you
> _will_ have signatures on your key eventually).
> 
> So please send me a signed tag to pull rather than just a branchname, ok?

Completely understandable; that's the kind of alternative I was
looking for but not aware of. How is this, signed by my key with
fingerprint 692E B65A D341 FC5A 807F  B458 B710 F922 056F C1DA:

The following changes since commit b562e44f507e863c6792946e4e1b1449fbbac85d:

  Linux 4.5 (2016-03-13 21:28:54 -0700)

are available in the git repository at:

  git://git.libc.org/linux-sh tags/tag-sh-for-4.6

for you to fetch changes up to b15d53d009558d14c4f394a6d1fa2039c7f45c43:

  sched/preempt, sh: kmap_coherent relies on disabled preemption (2016-03-17 19:46:14 +0000)

----------------------------------------------------------------
arch/sh changes for 4.6. They include minor cleanups, a fix for a
crash that likely affects all sh models with MMU, and introduction of
a framework for boards described by device tree, which sets the stage
for future J2 support.

----------------------------------------------------------------
David Hildenbrand (1):
      sched/preempt, sh: kmap_coherent relies on disabled preemption

Rich Felker (5):
      sh: provide unified syscall trap compatible with all SH models
      sh: make MMU-specific SMP code conditional on CONFIG_MMU
      sh: remove arch-specific localtimer and use generic one
      sh: add device tree support and generic board using device tree
      sh: add SMP method selection to device tree pseudo-board

Stephen Boyd (1):
      sh: Use generic clkdev.h header

Yoshinori Sato (2):
      sh: Disable trace for kernel uncompressing.
      sh: New gcc support

 Documentation/devicetree/booting-without-of.txt |  13 ++
 arch/sh/Kconfig                                 |   1 +
 arch/sh/boards/Kconfig                          |  15 ++
 arch/sh/boards/Makefile                         |   2 +
 arch/sh/boards/of-generic.c                     | 196 ++++++++++++++++++++++++
 arch/sh/boot/compressed/Makefile                |   2 +-
 arch/sh/include/asm/Kbuild                      |   1 +
 arch/sh/include/asm/clkdev.h                    |  33 ----
 arch/sh/include/asm/smp.h                       |  10 ++
 arch/sh/kernel/Makefile                         |   1 -
 arch/sh/kernel/cpu/sh2/entry.S                  |   8 +-
 arch/sh/kernel/cpu/sh2a/entry.S                 |   8 +-
 arch/sh/kernel/entry-common.S                   |  21 ++-
 arch/sh/kernel/head_32.S                        |  13 ++
 arch/sh/kernel/localtimer.c                     |  60 --------
 arch/sh/kernel/setup.c                          |  27 ++++
 arch/sh/kernel/sh_ksyms_32.c                    |   3 +
 arch/sh/kernel/smp.c                            |  24 +--
 arch/sh/lib/ashlsi3.S                           |  35 +++--
 arch/sh/lib/ashrsi3.S                           |  33 ++--
 arch/sh/lib/lshrsi3.S                           |  34 ++--
 arch/sh/mm/kmap.c                               |   2 +
 22 files changed, 397 insertions(+), 145 deletions(-)
 create mode 100644 arch/sh/boards/of-generic.c
 delete mode 100644 arch/sh/include/asm/clkdev.h
 delete mode 100644 arch/sh/kernel/localtimer.c
