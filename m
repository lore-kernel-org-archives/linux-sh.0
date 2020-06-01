From: Rich Felker <dalias@libc.org>
Date: Mon, 01 Jun 2020 03:03:01 +0000
Subject: Re: [PATCH] sh: Implement __get_user_u64() required for 64-bit get_user()
Message-Id: <20200601030300.GT1079@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20200529174540.4189874-1-glaubitz@physik.fu-berlin.de>
 <20200529174540.4189874-2-glaubitz@physik.fu-berlin.de>
 <CAMuHMdWG1wudoBP0EK8FiEj1BMEoL3r5oqJMUEbt2rqRU2gQpw@mail.gmail.com>
 <ba354e30-82ab-68c2-0771-2489463c9279@physik.fu-berlin.de>
 <2ad089c1-75cf-0986-c40f-c7f3f8fd6ead@physik.fu-berlin.de>
 <CAMuHMdXzje-qFH=pGoouSuXTZYf4NvnzbaYxTm_boMek-DbWMg@mail.gmail.com>
In-Reply-To: <CAMuHMdXzje-qFH=pGoouSuXTZYf4NvnzbaYxTm_boMek-DbWMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, May 31, 2020 at 12:43:11PM +0200, Geert Uytterhoeven wrote:
> Hi Adrian,
> 
> On Sun, May 31, 2020 at 11:59 AM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > On 5/31/20 11:54 AM, John Paul Adrian Glaubitz wrote:
> > > On 5/31/20 11:52 AM, Geert Uytterhoeven wrote:
> > >> As this is the 64-bit variant, I think this single move should be
> > >> replaced by a double move:
> > >>
> > >>        "mov  #0,%R1\n\t" \
> > >>        "mov  #0,%S1\n\t" \
> > >>
> > >> Same for the big endian version below.
> > >>
> > >> Disclaimer: uncompiled, untested, no SH assembler expert.
> > >
> > > Right, this makes sense. I'll send a new patch shortly.
> >
> > Hmm, this change is not the case for __put_user_asm() vs. __put_user_u64().
> > But I have to admit, I don't know what the part below "3:\n\t" is for.
> 
> It's part of the exception handling, in case the passed (userspace) pointer
> points to an inaccessible address, and triggers an exception.
> 
> For an invalid store, nothing is done, besides returning -EFAULT.
> Hence there's no "mov #0, %1\n\t" in the put_user case.
> For an invalid load, the data is replaced by zero, and -EFAULT is returned.
> 
> > +__asm__ __volatile__( \
> > +       "1:\n\t" \
> > +       "mov.l  %2,%R1\n\t" \
> > +       "mov.l  %T2,%S1\n\t" \
> > +       "2:\n" \
> 
> (reordering the two sections for easier explanation)
> 
> > +       ".section       __ex_table,\"a\"\n\t" \
> > +       ".long  1b, 3b\n\t" \
> 
> In case an exception happens for the instruction at 1b, jump to 3b.
> 
> Note that the m68k version has two entries here: one for each half of
> the 64-bit access[*].
> I don't know if that is really needed (and thus SH needs it, too), or if
> the exception code handles subsequent instructions automatically.

Can I propose a different solution? For archs where there isn't
actually any 64-bit load or store instruction, does it make sense to
be writing asm just to do two 32-bit loads/stores, especially when
this code is not in a hot path?

What about just having the 64-bit versions call the corresponding
32-bit version twice? (Ideally this would even be arch-generic and
could replace the m68k asm.) It would return EFAULT if either of the
32-bit calls did.

Rich
