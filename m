From: Simon Horman <horms@verge.net.au>
Date: Fri, 13 Nov 2015 00:51:58 +0000
Subject: Re: [PATCH v2 3/3] ARM: shmobile: gose: Add QSPI device to DT
Message-Id: <20151113005157.GF20462@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1447291763-27527-1-git-send-email-horms+renesas@verge.net.au>
 <1447291763-27527-4-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdWi=uTAtNvhSA54JDms_pLW0zjKQ_VH8xU3eY6BGiwV5A@mail.gmail.com>
In-Reply-To: <CAMuHMdWi=uTAtNvhSA54JDms_pLW0zjKQ_VH8xU3eY6BGiwV5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Nov 12, 2015 at 11:44:15AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Thu, Nov 12, 2015 at 2:29 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Enable the QSPI controller in the gose device tree.
> >
> > Based similar work for the silk board by by Vladimir Barinov and
> > Sergei Shtylyov.
> >
> > Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> > Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > ---
> > Tested: Read /dev/mtd0 with 512K blocks at 1.7MB/s
> 
> That's slow: I get 6.7 MB/s on koelsch (69.9 Mbps for Quad Read according
> to my in-kernel QSPI debug code). Is this with SYS-DMAC enabled?

Yes it does seem very small.

I think that the problem is that /dev/mtd0 is very small, only 262kB.
And I do not see any interrupts for dma-controllers when reading from hit.

/dev/mdt1 is much later, 4.2MB.
dd reads that at ~7MB/s using 512kB blocks.
In that test I see interrupts for one of the dma-controllers.

I plan to go ahead and apply this series.
