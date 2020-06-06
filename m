From: Andrew Morton <akpm@linux-foundation.org>
Date: Sat, 06 Jun 2020 00:50:30 +0000
Subject: Re: [GIT PULL] sh: remove sh5 support
Message-Id: <20200605175030.feba7dc6fc1233b815c72afb@linux-foundation.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20200528054600.GA29717@infradead.org>
        <20200528161416.GY1079@brightrain.aerifal.cx>
        <20200529143059.GA25475@infradead.org>
        <20200529175335.GK1079@brightrain.aerifal.cx>
        <e86e1d78-9597-811a-da0e-42a910b0c9fe@physik.fu-berlin.de>
        <20200601181259.GV1079@brightrain.aerifal.cx>
        <20200602013332.GY1079@brightrain.aerifal.cx>
        <0af28795-b27a-2dd9-0d0f-c2a8d4b8d512@physik.fu-berlin.de>
        <20200605154343.GU1079@brightrain.aerifal.cx>
        <c4900bf6-99b3-c9b9-4fd0-7f491bd46de6@physik.fu-berlin.de>
        <20200605155954.GV1079@brightrain.aerifal.cx>
        <25e0729d-8158-94a4-f081-ccdfa50ecb1d@physik.fu-berlin.de>
        <CAMuHMdVTWz33sbn2PPvcNW8KnAcNFvv31yj-z5V3VJ87Xv=tjQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVTWz33sbn2PPvcNW8KnAcNFvv31yj-z5V3VJ87Xv=tjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Rob Landley <rob@landley.net>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, 5 Jun 2020 20:23:07 +0200 Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Adrian,
> 
> On Fri, Jun 5, 2020 at 7:58 PM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > On 6/5/20 5:59 PM, Rich Felker wrote:
> > >> Ah, sorry, I missed that. You're right, it should probably go through
> > >> someone else's tree then.
> > >
> > > Do you know if it's needed to un-break sh4? If so we should push to
> > > get whoever has jurisdiction over it to include it; otherwise I'm
> > > indifferent.
> 
> I think the above is about the asm-generic/vmlinux.lds.h patch?
> https://marc.info/?l=linux-sh&m8429470221261&w=2
> 
> That one falls under Arnd's jurisdiction.
> And AFAIUC, it matters for recent binutils only? So Arnd should know.
> 

Aligning RO_AFTER_INIT_DATA is simply a no-brainer:

--- a/include/asm-generic/vmlinux.lds.h~include-asm-generic-vmlinuxldsh-align-ro_after_init
+++ a/include/asm-generic/vmlinux.lds.h
@@ -374,6 +374,7 @@
  */
 #ifndef RO_AFTER_INIT_DATA
 #define RO_AFTER_INIT_DATA						\
+	. = ALIGN(8);							\
 	__start_ro_after_init = .;					\
 	*(.data..ro_after_init)						\
 	JUMP_TABLE_DATA							\

So I'll send this in to Linus for 5.8-rc1.  And I think I'll add a cc:stable to
it, so people can use older kernels with newer toolchains.


I still have a few other sh patches sitting here:

https://ozlabs.org/~akpm/mmotm/broken-out/sh-clkfwk-remove-r8-r16-r32.patch
https://ozlabs.org/~akpm/mmotm/broken-out/sh-remove-call-to-memset-after-dma_alloc_coherent.patch
https://ozlabs.org/~akpm/mmotm/broken-out/sh-use-generic-strncpy.patch
https://ozlabs.org/~akpm/mmotm/broken-out/sh-add-missing-export_symbol-for-__delay.patch

What should I do with those?
