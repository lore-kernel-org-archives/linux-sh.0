From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 29 May 2020 10:21:04 +0000
Subject: Re: Build fails with unknown symbol __get_user_unknown with InifiniBand enabled
Message-Id: <CAMuHMdVep67j96taE6aaBO3r+Vo2kBXn-zt653YU0iTiDnH8Xg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8945f9b7-d4d3-851e-dc4f-2d05ed94c169@physik.fu-berlin.de>
In-Reply-To: <8945f9b7-d4d3-851e-dc4f-2d05ed94c169@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Adrian,

On Fri, May 29, 2020 at 12:13 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 5/29/20 11:59 AM, Geert Uytterhoeven wrote:
> >> sh-next branch [2] but I couldn't figure out where __get_user_unknown() is actually
> >> defined within the kernel.
> >
> > "git grep __get_user_unknown" tells you ;-)
> > See __get_user_size in arch/sh/include/asm/uaccess_32.h
> >
> >> Does anyone know how to fix this problem?
> >
> > __get_user_size() lacks a case for 64-bit values.
> > Interestingly, __put_user_size() has one, cfr. __put_user_u64().
>
> Ah, so this is the problem then? I'm surprised that this issue has
> surfaced only recently.
>
> Would this be fixed by Arnds patch series to remove SH-5 support by any chance?

No, it won't. As this is uaccess_32.h, i.e. for sh32.
All architectures are supposed to implement 64-bit get_user() accesses.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
