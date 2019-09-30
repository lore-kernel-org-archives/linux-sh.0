From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 30 Sep 2019 10:08:36 +0000
Subject: Re: [PATCH] sh: remove unneeded uapi asm-generic wrappers
Message-Id: <CAK7LNATpUhRiYy_f9FaAVRhMR-h2anoA8Z46soenxGw1saC4Ug@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20190723113036.14576-1-yamada.masahiro@socionext.com> <87o91fpp29.wl-ysato@users.sourceforge.jp>
In-Reply-To: <87o91fpp29.wl-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon Horman <horms+renesas@verge.net.au>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Sato-san,

On Sat, Jul 27, 2019 at 10:47 PM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
>
> On Tue, 23 Jul 2019 20:30:36 +0900,
> Masahiro Yamada wrote:
> >
> > These are listed in include/uapi/asm-generic/Kbuild, so Kbuild will
> > automatically generate them.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  arch/sh/include/uapi/asm/setup.h | 2 --
> >  arch/sh/include/uapi/asm/types.h | 2 --
> >  2 files changed, 4 deletions(-)
> >  delete mode 100644 arch/sh/include/uapi/asm/setup.h
> >  delete mode 100644 arch/sh/include/uapi/asm/types.h
> >
> > diff --git a/arch/sh/include/uapi/asm/setup.h b/arch/sh/include/uapi/asm/setup.h
> > deleted file mode 100644
> > index 4bd19f80f9b0..000000000000
> > --- a/arch/sh/include/uapi/asm/setup.h
> > +++ /dev/null
> > @@ -1,2 +0,0 @@
> > -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > -#include <asm-generic/setup.h>
> > diff --git a/arch/sh/include/uapi/asm/types.h b/arch/sh/include/uapi/asm/types.h
> > deleted file mode 100644
> > index 68100e108ea6..000000000000
> > --- a/arch/sh/include/uapi/asm/types.h
> > +++ /dev/null
> > @@ -1,2 +0,0 @@
> > -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > -#include <asm-generic/types.h>
> > --
> > 2.17.1
> >
>
> Applied sh-next.
> Thanks.
>
> --
> Yosinori Sato


I think you have not sent pull requests for sh or h8300.
Would you send ones in this MW?

-- 
Best Regards
Masahiro Yamada
