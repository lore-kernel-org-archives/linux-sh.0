From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 07 Jan 2020 13:32:56 +0000
Subject: Re: [PATCH] sh: clk: Fix discarding const qualifier warning
Message-Id: <20200107133256.GA648@pi3>
List-Id: <linux-sh.vger.kernel.org>
References: <1578399963-2229-1-git-send-email-krzk@kernel.org>
 <CAMuHMdULcBE1inRzTRFJeRDToT1wW+nrMEfiUs7DxMLR0tqb3w@mail.gmail.com>
 <CAJKOXPcbUfUcmU2O50M5Hs2y6ggg-m5qU-AJ6HjSL9dFTCp64A@mail.gmail.com>
In-Reply-To: <CAJKOXPcbUfUcmU2O50M5Hs2y6ggg-m5qU-AJ6HjSL9dFTCp64A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>

On Tue, Jan 07, 2020 at 02:05:14PM +0100, Krzysztof Kozlowski wrote:
> On Tue, 7 Jan 2020 at 14:00, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Krzysztof,
> >
> > On Tue, Jan 7, 2020 at 1:26 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > ioreadX() accepts pointer to non-const memory.  This fixes warnings
> > > like:
> > >
> > >     drivers/sh/clk/cpg.c: In function ‘r8’:
> > >     drivers/sh/clk/cpg.c:41:17: warning: passing argument 1 of ‘ioread8’
> > >         discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/sh/clk/cpg.c
> > > +++ b/drivers/sh/clk/cpg.c
> > > @@ -36,17 +36,17 @@ static void sh_clk_write(int value, struct clk *clk)
> > >                 iowrite32(value, clk->mapped_reg);
> > >  }
> > >
> > > -static unsigned int r8(const void __iomem *addr)
> > > +static unsigned int r8(void __iomem *addr)
> > >  {
> > >         return ioread8(addr);
> > >  }
> >
> > Isn't the real issue that some implementations of ioreadX() take const,
> > while others don't?
> >
> > Even the generic ones disagree:
> >
> >     include/asm-generic/io.h:static inline u8 ioread8(const volatile
> > void __iomem *addr)
> >     include/asm-generic/iomap.h:extern unsigned int ioread8(void __iomem *);
> >
> > IMHO they all should take "const volatile void __iomem *".
> 
> Since this is a SuperH driver, I adjusted it to the SuperH
> implementation - lack of const. However iIndeed it makes sense to have
> them all taking "const"... Let me check, if I can fix it (without the
> real HW).

That will be non-trivial because many platforms define ioreadX() with
non-const. For example entire alpha with many its implementations of
ioread(). Even include/asm-generic/iomap.h defines them as non-const...

Best regards,
Krzysztof
