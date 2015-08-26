From: Simon Horman <horms@verge.net.au>
Date: Wed, 26 Aug 2015 00:27:25 +0000
Subject: Re: [PATCH] ARM: shmobile: remove Makefile.boot
Message-Id: <20150826002724.GA11168@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1440113264-30359-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdWYM6vVWzUQgR4u8cvoH6Jtq4XerYd2PbpvfUruDPi7-Q@mail.gmail.com>
In-Reply-To: <CAMuHMdWYM6vVWzUQgR4u8cvoH6Jtq4XerYd2PbpvfUruDPi7-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Aug 25, 2015 at 02:06:31PM +0200, Geert Uytterhoeven wrote:
> On Fri, Aug 21, 2015 at 1:27 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Now that the only multiplatform boot is supported for all
> > shmobile platforms Makefile.boot may be removed.
> >
> > This seems correct to me given:
> > * Setting MACHINE to no value in arch/arm/Makefile
> >   if CONFIG_ARCH_MULTIPLATFORM is set
> > * Not including Makefile.boot in arch/arm/boot/Makefile
> >   if MACHINE has no value
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up for v4.4.
