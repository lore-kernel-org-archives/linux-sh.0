From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 03 Jun 2020 07:35:12 +0000
Subject: Re: [PATCH v2] sh: Implement __get_user_u64() required for 64-bit get_user()
Message-Id: <CAMuHMdV-Par79SYe75HzJsEd2cwEDhGPK+Nj0zUD8eAy9aDj1A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200531104715.2512247-1-glaubitz@physik.fu-berlin.de> <b6271c7a-1eaf-61d9-9eb6-061aa8a13ac8@physik.fu-berlin.de>
In-Reply-To: <b6271c7a-1eaf-61d9-9eb6-061aa8a13ac8@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Adrian,

On Wed, Jun 3, 2020 at 9:20 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 5/31/20 12:47 PM, John Paul Adrian Glaubitz wrote:
> >  Changes since v1:
> >  - Replace single mov instruction for exception handling
> >    in case of invalid load
>
> Yutaka Niibe has had a look at my patch and he says, we might have to add
> an entry for the fault handling of the upper word.
>
> Quote:
>
> > (1) I think that there is possibility that the second access to user
> > space fails (while the first access succeeds).  IIUC, it's good have
> > an entry in __ex_tables for the second access too, like:
> >     ".long 1b+2, 3b\n\t"
> > I don't know if the expression "1b+2" is correct, my intention is
> > detecting the failure in the seccond access.

So just add another numeric label, like is done on m68k.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
