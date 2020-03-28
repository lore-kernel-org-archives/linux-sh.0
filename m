From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 28 Mar 2020 10:29:13 +0000
Subject: Re: [PATCH 2/2] include/asm-generic: vmlinux.lds.h
Message-Id: <CAMuHMdV2BPUua6T7Bgu2mRj5De7mwUKm=hqNAs3_jZK4fZnXtg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200315175108.9694-2-romain.naour@gmail.com>
In-Reply-To: <20200315175108.9694-2-romain.naour@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

CC arnd

On Fri, Mar 27, 2020 at 11:00 PM Rob Landley <rob@landley.net> wrote:
> On 3/26/20 3:42 PM, Rich Felker wrote:
> > On Sun, Mar 15, 2020 at 06:51:08PM +0100, Romain Naour wrote:
> >> Since the patch [1], building the kernel using a toolchain built with
> >> Binutils 2.33.1 prevent booting a sh4 system under Qemu.
> >> Apply the patch provided by Alan Modra [2] that fix alignment of rodat=
a.
> >>
> >> [1] https://sourceware.org/git/gitweb.cgi?p=3Dbinutils-gdb.git;h=EBd22=
63ba9a9124d93bbc0ece63d7e0fae89b40e
> >> [2] https://www.sourceware.org/ml/binutils/2019-12/msg00112.html
> >>
> >> Signed-off-by: Romain Naour <romain.naour@gmail.com>
> >> Cc: Alan Modra <amodra@gmail.com>
> >
> > Acked-by: Rich Felker <dalias@libc.org>
>
> Is there any way to get this into sunday's release?

Not if the maintainer isn't in CC.

> Acked-by: Rob Landley <rob@landley.net>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
