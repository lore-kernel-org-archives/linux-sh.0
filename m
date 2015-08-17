From: Simon Horman <horms@verge.net.au>
Date: Mon, 17 Aug 2015 15:47:27 +0000
Subject: Re: [PATCH 0/7] Bock-W legacy excision
Message-Id: <20150817154727.GA6110@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1439560268-4935-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1439560268-4935-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 17, 2015 at 11:44:33AM +0200, Geert Uytterhoeven wrote:
> Hi Uli,
> 
> On Fri, Aug 14, 2015 at 3:51 PM, Ulrich Hecht
> <ulrich.hecht+renesas@gmail.com> wrote:
> > This eliminates the last shmobile legacy platform, Bock-W, and with it a
> > number of other things that have thus become obsolete.
> 
> Thanks!
> 
> > Ulrich Hecht (7):
> >   ARM: shmobile: bockw: remove legacy board file and config
> >   ARM: shmobile: r8a7778: remove obsolete setup code
> >   ARM: shmobile: Kconfig: remove obsolete option ARCH_R8A7778
> >   ARM: shmobile: r8a7778: remove legacy clock implementation
> >   ARM: shmobile: remove ARCH_SHMOBILE_LEGACY option
> >   ARM: shmobile: bockw: remove legacy defconfig
> >   MAINTAINERS: remove references to dropped marzen and bockw defconfigs
> 
> You forgot to remove
>   - the small ARCH_SHMOBILE_LEGACY hunk with r8a7778-bockw.dtb
>     in arch/arm/boot/dts/Makefile,
>   - the ARCH_SHMOBILE section with the now unused Kconfig symbol
>     SHMOBILE_TIMER_HZ in arch/arm/mach-shmobile/Kconfig.
> 
> With those fixed:
> Acked-by: by: Geert Uytterhoeven <geert+renesas@glider.be>

Ulrich, thanks for the patches and
Geert, thanks for the review.

It seems to me that the above two changes could be separate patches.
With that in mind:

* Geert, would you mind if I queueing up the patchset as-is with your Acks
  with a view to your concerned being addressed by follow-up patches?
* Ulrich, could you prepare some follow up patches?

