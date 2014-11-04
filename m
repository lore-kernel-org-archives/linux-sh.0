From: Simon Horman <horms@verge.net.au>
Date: Tue, 04 Nov 2014 00:11:26 +0000
Subject: Re: [PATCH 0/2] ARM: shmobile: r8a7790: Fix SD3CKCR address
Message-Id: <20141104001125.GB20174@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1414648677-31104-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdWS1M24vngxvrf3mRGfVwKvmgsXnqZ6xq_hJuPC=KqqWQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWS1M24vngxvrf3mRGfVwKvmgsXnqZ6xq_hJuPC=KqqWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Oct 30, 2014 at 10:51:56AM +0100, Geert Uytterhoeven wrote:
> On Thu, Oct 30, 2014 at 6:57 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > This short series corrects the SD3CKCR address in both C and DT
> >
> > Based on the renesas-devel-20141030-v3.18-rc2 branch of my renesas tree
> >
> > Shinobu Uehara (2):
> >   ARM: shmobile: r8a7790: Fix SD3CKCR address
> >   ARM: shmobile: r8a7790: Fix SD3CKCR address to device tree
> 
> This  matches my copy of the datasheet, so

Mine too :)

> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> But it would be good to know this has been verified on actual hardware.

As these came from the BSP my assumption is that they have
been verified on actual hardware. I will queue up these changes.
