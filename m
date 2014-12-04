From: Simon Horman <horms@verge.net.au>
Date: Thu, 04 Dec 2014 06:36:24 +0000
Subject: Re: [PATCH 0/5] ARM: shmobile: ape6evm: multiplatform support
Message-Id: <20141204063624.GE19568@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1417509439-31739-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1417509439-31739-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 02, 2014 at 10:20:01PM +0100, Geert Uytterhoeven wrote:
> Hi Ulrich,
> 
> On Tue, Dec 2, 2014 at 9:37 AM, Ulrich Hecht
> <ulrich.hecht+renesas@gmail.com> wrote:
> > This series implements multiplatform support for the APE6EVM board, and
> > eliminates both legacy platforms.  Suggestions on how to sequence these
> > changes in a more attractive fashion are welcome.
> 
> Thanks for your series!
> 
> Attractive sequencing can be complicated, if you want to split up at
> SoC / board / DTS boundaries.
> 
> Probably [4/5] should be squashed into [3/5], though?

Indeed.

Usually I handle multiplatform enablement series in a special branch
because the normal SoC / board / DTS boundaries don't work out
very well. I plan to do that for this series too. And I think
the order of the patches is already reasonable for such a branch.

> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > Ulrich Hecht (5):
> >   ARM: shmobile: r8a73a4: Multiplatform support
> >   ARM: shmobile: r8a73a4: Add r8a73a4-ape6evm-reference.dtb to
> >     ARCH_SHMOBILE_MULTI
> >   ARM: shmobile: ape6evm reference: Remove C board code
> >   ARM: shmobile: r8a73a4: Remove r8a73a4-ape6evm-reference.dtb from
> >     ARCH_SHMOBILE_LEGACY
> >   ARM: shmobile: r8a73a4: ape6evm: replace legacy with multiplatform
