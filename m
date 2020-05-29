From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 29 May 2020 11:21:26 +0000
Subject: Re: Build fails with unknown symbol __get_user_unknown with InifiniBand enabled
Message-Id: <CAMuHMdV2F-RqeG7ZgO3jJy+_JobkCnYnZ_PWm__dtPRKQY2gVQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8945f9b7-d4d3-851e-dc4f-2d05ed94c169@physik.fu-berlin.de>
In-Reply-To: <8945f9b7-d4d3-851e-dc4f-2d05ed94c169@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Adrian,

On Fri, May 29, 2020 at 12:35 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 5/29/20 12:21 PM, Geert Uytterhoeven wrote:
> >> Would this be fixed by Arnds patch series to remove SH-5 support by an=
y chance?
> >
> > No, it won't. As this is uaccess_32.h, i.e. for sh32.
> > All architectures are supposed to implement 64-bit get_user() accesses.
>
> Ok, I assume we need an implementation like this then [1]?
>
> Adrian
>
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=B2f680380ddf2f003882e59e00acd6c1952f91fc

Exactly.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
