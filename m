From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 09 May 2019 08:44:45 +0000
Subject: Re: [PATCH v2] sh: vsyscall: drop unnecessary cc-ldoption
Message-Id: <fd075ea4-5fc9-a015-e4ae-180451f9bea0@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <CAK7LNASLBQ=w9YFBD80s7dit1bd_Tr+ggVyRNms0jf1pR9k=ZA@mail.gmail.com>
 <20190424180223.253025-1-ndesaulniers@google.com>
 <CAKwvOd=5SVBFsfEgYc9Dpgr--h+pQgCwOnpAjg9B4HG2VY6kFg@mail.gmail.com>
 <CAKwvOdkpjwgt3pP9rjZtm=rEK9MhEfQdc6PEr91Bnb9tMVDBEA@mail.gmail.com>
 <CAK7LNASL+oNNbZ4YaPtGnwka06sRr3Pz8HjjM7oxUC-JkvqF2Q@mail.gmail.com>
 <fc61a1c2-5503-b18d-e178-491952e059f6@physik.fu-berlin.de>
 <CAK7LNATEizpakgj_UT4-OyUy8cs7C_kz8wEWDJAdoftfVK=uKw@mail.gmail.com>
In-Reply-To: <CAK7LNATEizpakgj_UT4-OyUy8cs7C_kz8wEWDJAdoftfVK=uKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Andy Lutomirski <luto@kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Linux-sh list <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hi Masahiro!

On 5/9/19 9:07 AM, Masahiro Yamada wrote:
>> So, if in doubt, there are folks in Debian which can test your kernel patch
>> if you fear that it breaks something.
> 
> Thanks for taking care of them in Debian.
> 
> I am talking about the sh sub-system in the kernel here.

Yes, I'm aware of that :).

> SH patches occasionally fly around in LKML, but
> the SH maintainers are not picking up them these days.

Rich was normally the one maintaining the SH tree and collecting the patches,
not sure whether he is still active. It's been a while since he sent Linus
a pull request.

Sato-san was recently a patch himself, but I think he doesn't have a tree
himself.

@Sato: Could you have a look at the patch and ack it if it's okay?

> This one is trivial from the build system point of view.
> So, I offer to apply it to my tree.

I'm fine with that. If you need to test build the kernel for SH, Debian
has an easily installable cross-compiler for SH and every other architecture
except ia64 (working on fixing that) available.

In any case, thanks for taking care of SH in this case.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
