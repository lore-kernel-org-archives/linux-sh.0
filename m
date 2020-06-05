From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 05 Jun 2020 18:23:07 +0000
Subject: Re: [GIT PULL] sh: remove sh5 support
Message-Id: <CAMuHMdVTWz33sbn2PPvcNW8KnAcNFvv31yj-z5V3VJ87Xv=tjQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200528054600.GA29717@infradead.org> <20200528161416.GY1079@brightrain.aerifal.cx>
 <20200529143059.GA25475@infradead.org> <20200529175335.GK1079@brightrain.aerifal.cx>
 <e86e1d78-9597-811a-da0e-42a910b0c9fe@physik.fu-berlin.de>
 <20200601181259.GV1079@brightrain.aerifal.cx> <20200602013332.GY1079@brightrain.aerifal.cx>
 <0af28795-b27a-2dd9-0d0f-c2a8d4b8d512@physik.fu-berlin.de>
 <20200605154343.GU1079@brightrain.aerifal.cx> <c4900bf6-99b3-c9b9-4fd0-7f491bd46de6@physik.fu-berlin.de>
 <20200605155954.GV1079@brightrain.aerifal.cx> <25e0729d-8158-94a4-f081-ccdfa50ecb1d@physik.fu-berlin.de>
In-Reply-To: <25e0729d-8158-94a4-f081-ccdfa50ecb1d@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Rob Landley <rob@landley.net>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>

Hi Adrian,

On Fri, Jun 5, 2020 at 7:58 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 6/5/20 5:59 PM, Rich Felker wrote:
> >> Ah, sorry, I missed that. You're right, it should probably go through
> >> someone else's tree then.
> >
> > Do you know if it's needed to un-break sh4? If so we should push to
> > get whoever has jurisdiction over it to include it; otherwise I'm
> > indifferent.

I think the above is about the asm-generic/vmlinux.lds.h patch?
https://marc.info/?l=linux-sh&m8429470221261&w=2

That one falls under Arnd's jurisdiction.
And AFAIUC, it matters for recent binutils only? So Arnd should know.

> No, the patch is only necessary when enabling Infiniband support with
> CONFIG_INFINIBAND_USER_ACCESS enabled.
>
> However, according to Geert, every architecture is supposed to have
> 64-bit get_user() these days, therefore my patch is required anyways,
> but it's not an acute problem.

This is about a different patch.  Still a build failure, but who cares about
Infiniband? (I still care more about SH ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
