From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 09 May 2019 06:09:36 +0000
Subject: Re: [PATCH v2] sh: vsyscall: drop unnecessary cc-ldoption
Message-Id: <fc61a1c2-5503-b18d-e178-491952e059f6@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <CAK7LNASLBQ=w9YFBD80s7dit1bd_Tr+ggVyRNms0jf1pR9k=ZA@mail.gmail.com>
 <20190424180223.253025-1-ndesaulniers@google.com>
 <CAKwvOd=5SVBFsfEgYc9Dpgr--h+pQgCwOnpAjg9B4HG2VY6kFg@mail.gmail.com>
 <CAKwvOdkpjwgt3pP9rjZtm=rEK9MhEfQdc6PEr91Bnb9tMVDBEA@mail.gmail.com>
 <CAK7LNASL+oNNbZ4YaPtGnwka06sRr3Pz8HjjM7oxUC-JkvqF2Q@mail.gmail.com>
In-Reply-To: <CAK7LNASL+oNNbZ4YaPtGnwka06sRr3Pz8HjjM7oxUC-JkvqF2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Nick Desaulniers <ndesaulniers@google.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Andy Lutomirski <luto@kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Linux-sh list <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 5/9/19 2:44 AM, Masahiro Yamada wrote:
> On Thu, May 9, 2019 at 5:13 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>>
>> bumping for review, as the merge window is now open.
> 
> 
> sh is not very active these days.

We're still supporting SH with an up-to-date kernel and userland in Debian, so
if your patch broke something, we will notice that soonish. This also applies
to ia64 and many other architectures.

So, if in doubt, there are folks in Debian which can test your kernel patch
if you fear that it breaks something.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
