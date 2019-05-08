From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 08 May 2019 19:22:20 +0000
Subject: Re: [PATCH v2] sh: vsyscall: drop unnecessary cc-ldoption
Message-Id: <CAKwvOdkpjwgt3pP9rjZtm=rEK9MhEfQdc6PEr91Bnb9tMVDBEA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAK7LNASLBQ=w9YFBD80s7dit1bd_Tr+ggVyRNms0jf1pR9k=ZA@mail.gmail.com>
 <20190424180223.253025-1-ndesaulniers@google.com> <CAKwvOd=5SVBFsfEgYc9Dpgr--h+pQgCwOnpAjg9B4HG2VY6kFg@mail.gmail.com>
In-Reply-To: <CAKwvOd=5SVBFsfEgYc9Dpgr--h+pQgCwOnpAjg9B4HG2VY6kFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, dalias@libc.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andy Lutomirski <luto@kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

bumping for review, as the merge window is now open.

On Tue, Apr 30, 2019 at 1:26 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Apr 24, 2019 at 11:02 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Towards the goal of removing cc-ldoption, it seems that --hash-style> > was added to binutils 2.17.50.0.2 in 2006. The minimal required version
> > of binutils for the kernel according to
> > Documentation/process/changes.rst is 2.20.
> >
> > Link: https://gcc.gnu.org/ml/gcc/2007-01/msg01141.html
> > Cc: clang-built-linux@googlegroups.com
> > Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> > Changes V1 -> V2:
> > * update commit subject and message as per Masahiro/Geert.
> >
> > To Geert's question about minimum binutils versions; no change needed to
> > binutils.
> >
> >
> >  arch/sh/kernel/vsyscall/Makefile | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/sh/kernel/vsyscall/Makefile b/arch/sh/kernel/vsyscall/Makefile
> > index 5db6579bc44c..6e8664448048 100644
> > --- a/arch/sh/kernel/vsyscall/Makefile
> > +++ b/arch/sh/kernel/vsyscall/Makefile
> > @@ -15,8 +15,7 @@ quiet_cmd_syscall = SYSCALL $@
> >
> >  export CPPFLAGS_vsyscall.lds += -P -C -Ush
> >
> > -vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1 \
> > -               $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
> > +vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1 -Wl,--hash-style=sysv
> >
> >  SYSCFLAGS_vsyscall-trapa.so    = $(vsyscall-flags)
> >
> > --
> > 2.21.0.593.g511ec345e18-goog
> >
>
> bumping for review
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
