From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 09 May 2019 07:07:54 +0000
Subject: Re: [PATCH v2] sh: vsyscall: drop unnecessary cc-ldoption
Message-Id: <CAK7LNATEizpakgj_UT4-OyUy8cs7C_kz8wEWDJAdoftfVK=uKw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAK7LNASLBQ=w9YFBD80s7dit1bd_Tr+ggVyRNms0jf1pR9k=ZA@mail.gmail.com>
 <20190424180223.253025-1-ndesaulniers@google.com> <CAKwvOd=5SVBFsfEgYc9Dpgr--h+pQgCwOnpAjg9B4HG2VY6kFg@mail.gmail.com>
 <CAKwvOdkpjwgt3pP9rjZtm=rEK9MhEfQdc6PEr91Bnb9tMVDBEA@mail.gmail.com>
 <CAK7LNASL+oNNbZ4YaPtGnwka06sRr3Pz8HjjM7oxUC-JkvqF2Q@mail.gmail.com> <fc61a1c2-5503-b18d-e178-491952e059f6@physik.fu-berlin.de>
In-Reply-To: <fc61a1c2-5503-b18d-e178-491952e059f6@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Andy Lutomirski <luto@kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Linux-sh list <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, May 9, 2019 at 3:11 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> On 5/9/19 2:44 AM, Masahiro Yamada wrote:
> > On Thu, May 9, 2019 at 5:13 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >>
> >> bumping for review, as the merge window is now open.
> >
> >
> > sh is not very active these days.
>
> We're still supporting SH with an up-to-date kernel and userland in Debian, so
> if your patch broke something, we will notice that soonish. This also applies
> to ia64 and many other architectures.
>
> So, if in doubt, there are folks in Debian which can test your kernel patch
> if you fear that it breaks something.

Thanks for taking care of them in Debian.

I am talking about the sh sub-system in the kernel here.

SH patches occasionally fly around in LKML, but
the SH maintainers are not picking up them these days.

This one is trivial from the build system point of view.
So, I offer to apply it to my tree.

Thanks.




> Adrian
>
> --
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer - glaubitz@debian.org
> `. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913



-- 
Best Regards
Masahiro Yamada
