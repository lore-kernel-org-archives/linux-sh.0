From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 17 Mar 2016 18:52:32 +0000
Subject: Re: [GIT PULL] arch/sh updates for 4.6
Message-Id: <CAMuHMdVrQ9n0ZQ6XJ0Nh=JAOYBop2PaL2LvV=P2CWMEXeDNisQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20160317180253.GA24679@brightrain.aerifal.cx>
In-Reply-To: <20160317180253.GA24679@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rich,

On Thu, Mar 17, 2016 at 7:02 PM, Rich Felker <dalias@libc.org> wrote:
> These are the updates Sato-san and I have for arch/sh in this merge
> window. Aside from some small fixes and cleanup they set the stage for
> J2 support (by adding framework for boards described by device tree),
> which should only minimally touch existing files when it's added.

Thanks for preparing this!

> Could you pull these changes and send them upstream for 4.6, or let me
> know if there are problems (like stupid mistakes I made in preparing
> the branch) or if I should send the request directly to Linus? Rob
> suggested I might go through you this first time since I'm new to
> maintainer workflow and the repo (on libc.org) is temporary pending
> getting it setup on kernel.org.

It mostly looks fine to me.

I have only one real comment: if you apply a patch from someone else, you
should add your own Signed-off-by line (use the "-s" option of "git am").
As your for-4.6 branch is based on current v4.5, it won't do much harm to
"rebase -i" it to add the missing SoB-lines.

I think you should send your pull request to Linus directly. You are already
listed as SuperH maintainer in v4.5:MAINTAINERS.
As your git repository is not yet on kernel.org, you best add a signed tag
("git tag -s"), as Linus is reluctant to pull unsigned tags from other sites.

After the release of v4.6-rc1, you may want to prepare a "for-next" branch
where you commit patches that are meant for the next (v4.7) kernel version,
and inform Stephen Rothwell (CCed, as he may have more advice).
Then your "for-next" branch will be part of "linux-next", and will receive more
testing. Actually it may be a good idea to create a "for-next" branch now,
identical to "sh-for-4.6", let it be included in "linux-next" for a few days,
and send the pull request to Linus afterwards. That would catch accidentally
introduced breakage.

Thanks!

> The following changes since commit b562e44f507e863c6792946e4e1b1449fbbac85d:
>
>   Linux 4.5 (2016-03-13 21:28:54 -0700)
>
> are available in the git repository at:
>
>   git://git.libc.org/linux-sh sh-for-4.6
>
> for you to fetch changes up to aff17e9ddd7128661b24f70a92f13e0379484dc7:
>
>   sched/preempt, sh: kmap_coherent relies on disabled preemption (2016-03-17 17:35:53 +0000)
>
> ----------------------------------------------------------------
> David Hildenbrand (1):
>       sched/preempt, sh: kmap_coherent relies on disabled preemption
>
> Rich Felker (5):
>       sh: provide unified syscall trap compatible with all SH models
>       sh: make MMU-specific SMP code conditional on CONFIG_MMU
>       sh: remove arch-specific localtimer and use generic one
>       sh: add device tree support and generic board using device tree
>       sh: add SMP method selection to device tree pseudo-board
>
> Stephen Boyd (1):
>       sh: Use generic clkdev.h header
>
> Yoshinori Sato (2):
>       sh: Disable trace for kernel uncompressing.
>       SH: New gcc support
>
>  Documentation/devicetree/booting-without-of.txt |  13 ++
>  arch/sh/Kconfig                                 |   1 +
>  arch/sh/boards/Kconfig                          |  15 ++
>  arch/sh/boards/Makefile                         |   2 +
>  arch/sh/boards/of-generic.c                     | 196 ++++++++++++++++++++++++
>  arch/sh/boot/compressed/Makefile                |   2 +-
>  arch/sh/include/asm/Kbuild                      |   1 +
>  arch/sh/include/asm/clkdev.h                    |  33 ----
>  arch/sh/include/asm/smp.h                       |  10 ++
>  arch/sh/kernel/Makefile                         |   1 -
>  arch/sh/kernel/cpu/sh2/entry.S                  |   8 +-
>  arch/sh/kernel/cpu/sh2a/entry.S                 |   8 +-
>  arch/sh/kernel/entry-common.S                   |  21 ++-
>  arch/sh/kernel/head_32.S                        |  13 ++
>  arch/sh/kernel/localtimer.c                     |  60 --------
>  arch/sh/kernel/setup.c                          |  27 ++++
>  arch/sh/kernel/sh_ksyms_32.c                    |   3 +
>  arch/sh/kernel/smp.c                            |  24 +--
>  arch/sh/lib/ashlsi3.S                           |  35 +++--
>  arch/sh/lib/ashrsi3.S                           |  33 ++--
>  arch/sh/lib/lshrsi3.S                           |  34 ++--
>  arch/sh/mm/kmap.c                               |   2 +
>  22 files changed, 397 insertions(+), 145 deletions(-)
>  create mode 100644 arch/sh/boards/of-generic.c
>  delete mode 100644 arch/sh/include/asm/clkdev.h
>  delete mode 100644 arch/sh/kernel/localtimer.c

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
