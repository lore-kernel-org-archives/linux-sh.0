From: Simon Horman <horms@verge.net.au>
Date: Fri, 30 Oct 2015 07:17:46 +0000
Subject: Re: [PATCH v5 2/5] arm64: dts: r8a7795: add EthernetAVB device node
Message-Id: <20151030071745.GA31252@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1444891698-8780-1-git-send-email-horms+renesas@verge.net.au>
 <1444891698-8780-3-git-send-email-horms+renesas@verge.net.au>
 <CANqRtoQLXQENVxvpMB_pymu7B+F6MhL0CBqPC4EscFTxOYt07Q@mail.gmail.com>
In-Reply-To: <CANqRtoQLXQENVxvpMB_pymu7B+F6MhL0CBqPC4EscFTxOYt07Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Oct 29, 2015 at 05:42:43PM +0900, Magnus Damm wrote:
> On Thu, Oct 15, 2015 at 3:48 PM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> >
> > Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> > [horms: minor updates]
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

[snip]

> Hi Simon,
> 
> Thanks for your efforts with the ethernet controller. In general all
> seems good to me, but this I came across the contents of this patch
> when I was browsing the SoC DTSI file. What is the reason to put this
> node in between dmac0 and dmac1? I don't know where is the best
> location, but it would be good to keep the dmac nodes together I
> think.

I think its just an artifact of the way the patch has been updated.
I'll see about cleaning it up.
