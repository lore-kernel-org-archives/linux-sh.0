From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 24 Apr 2019 06:39:31 +0000
Subject: Re: [PATCH] sh: require --Wl,--hash-style=sysv
Message-Id: <CAK7LNASLBQ=w9YFBD80s7dit1bd_Tr+ggVyRNms0jf1pR9k=ZA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20190423202907.234180-1-ndesaulniers@google.com>
 <CAMuHMdX9hKQHitf3b8861dnTt+aJOaOiytxqBzgprBdCPnL18Q@mail.gmail.com> <CAK7LNATChymboE805YWiVxiT==P0arGXVutxi_h2+b4P=_oTPg@mail.gmail.com>
In-Reply-To: <CAK7LNATChymboE805YWiVxiT==P0arGXVutxi_h2+b4P=_oTPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, Nick Desaulniers <ndesaulniers@google.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andy Lutomirsky <luto@kernel.org>, clang-built-linux@googlegroups.com, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Apr 24, 2019 at 3:37 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Wed, Apr 24, 2019 at 3:29 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Nick,
> >
> > On Tue, Apr 23, 2019 at 10:31 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > > Towards the goal of removing cc-ldoption, prefer ld-option, or better
> > > yet, require --Wl,--hash-style=sysv since the selftest for vdso's
> > > requires DT_HASH.
> > >
> > > Cc: Andy Lutomirsky <luto@kernel.org>
> > > Cc: clang-built-linux@googlegroups.com
> > > Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > Thanks for your patch!
> >
> > > --- a/arch/sh/kernel/vsyscall/Makefile
> > > +++ b/arch/sh/kernel/vsyscall/Makefile
> > > @@ -15,8 +15,7 @@ quiet_cmd_syscall = SYSCALL $@
> > >
> > >  export CPPFLAGS_vsyscall.lds += -P -C -Ush
> > >
> > > -vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1 \
> > > -               $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
> > > +vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1 -Wl,--hash-style=sysv
> > >
> > >  SYSCFLAGS_vsyscall-trapa.so    = $(vsyscall-flags)
> >
> > What impact does this have on the minimum binutils version needed to
> > compile the kernel?
> >
>
>
> See his ia64 variant:
> https://lore.kernel.org/patchwork/patch/1065347/
>
>
> He commented a stronger reason
> "it seems that --hash-style= was added to binutils 2.17.50.0.2 in 2006.
> The minimal required version of binutils for the kernel according to
> Documentation/process/changes.rst is 2.20"
>
>
> Nick,
> Why don't you rephrase the commit log like your ia64 one?
> It will clarify this change has no impact.
>
>
> BTW, I think the subject should be
> "-Wl,--hash-style=sysv" instead of
> "--Wl,--hash-style=sysv"
>
> (single hash before "Wl")

I mean "single dash"
just in case.  :)




-- 
Best Regards
Masahiro Yamada
