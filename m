From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 30 May 2020 08:47:11 +0000
Subject: Re: [GIT PULL] sh: remove sh5 support
Message-Id: <CAMuHMdWsdV83C0JiGUqUDsoFpuwsfuR5Z+XLM-X28ipN4GV8JA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200424221948.1120587-1-arnd@arndb.de> <20200507143552.GA28683@infradead.org>
 <20200528054600.GA29717@infradead.org> <20200528161416.GY1079@brightrain.aerifal.cx>
 <20200529143059.GA25475@infradead.org> <20200529175335.GK1079@brightrain.aerifal.cx>
 <e86e1d78-9597-811a-da0e-42a910b0c9fe@physik.fu-berlin.de>
In-Reply-To: <e86e1d78-9597-811a-da0e-42a910b0c9fe@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Rob Landley <rob@landley.net>, Linus Torvalds <torvalds@linux-foundation.org>

On Sat, May 30, 2020 at 10:08 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 5/29/20 7:53 PM, Rich Felker wrote:
> > Frustratingly, I _still_ don't have an official tree on kernel.org for
> > the purpose of being the canonical place for linux-next to pull from,
> > due to policies around pgp keys and nobody following up on signing
> > mine. This is all really silly since there are ridiculously many
> > independent channels I could cryptographically validate identity
> > through with vanishing probability that they're all compromised. For
> > the time being I'll reactivate my repo on git.musl-libc.org.
>
> May I suggest to pick up these patches, for example? There might be
> more I missed, but getting these merged should already help a lot with
> the clean-up of arch/sh.

And https://marc.info/?l=linux-arch&m3337991312146&w=2

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
