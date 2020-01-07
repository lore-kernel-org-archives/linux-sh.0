From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 07 Jan 2020 13:54:16 +0000
Subject: Re: [PATCH] sh: clk: Fix discarding const qualifier warning
Message-Id: <CAK8P3a1EiHCVo0aJzwsv_kbT9ENMScnxfWM7Zoc08fd7bL=D1g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1578399963-2229-1-git-send-email-krzk@kernel.org>
 <CAMuHMdULcBE1inRzTRFJeRDToT1wW+nrMEfiUs7DxMLR0tqb3w@mail.gmail.com>
 <CAJKOXPcbUfUcmU2O50M5Hs2y6ggg-m5qU-AJ6HjSL9dFTCp64A@mail.gmail.com> <20200107133256.GA648@pi3>
In-Reply-To: <20200107133256.GA648@pi3>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

arch/powerpc/kernel/iomap.cOn Tue, Jan 7, 2020 at 2:33 PM Krzysztof
Kozlowski <krzk@kernel.org> wrote:
> On Tue, Jan 07, 2020 at 02:05:14PM +0100, Krzysztof Kozlowski wrote:
> > On Tue, 7 Jan 2020 at 14:00, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Since this is a SuperH driver, I adjusted it to the SuperH
> > implementation - lack of const. However iIndeed it makes sense to have
> > them all taking "const"... Let me check, if I can fix it (without the
> > real HW).
>
> That will be non-trivial because many platforms define ioreadX() with
> non-const. For example entire alpha with many its implementations of
> ioread(). Even include/asm-generic/iomap.h defines them as non-const...

I found these instances:

arch/alpha/include/asm/io.h
arch/alpha/kernel/io.c
arch/parisc/include/asm/io.h
arch/parisc/lib/iomap.c
arch/sh/kernel/iomap.c
arch/powerpc/kernel/iomap.c
lib/iomap.c
include/asm-generic/iomap.h

At least the last four file would have to be done at the same time as
the header is shared, but the actual conversion should be trivial.

       Arnd
