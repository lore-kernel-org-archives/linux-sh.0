From: Simon Horman <horms@verge.net.au>
Date: Fri, 16 Jan 2015 02:15:54 +0000
Subject: Re: [PATCH v2 2/2] ARM: shmobile: r8a7790: Correct mask for GIC PPI interrupts
Message-Id: <20150116021551.GA19790@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1421329844-19707-1-git-send-email-geert+renesas@glider.be>
 <1421329844-19707-3-git-send-email-geert+renesas@glider.be>
 <CANqRtoQOs_VFku4+PKvyY1Gu0M56nfGXwratrP5qqVYxMCAMpA@mail.gmail.com>
In-Reply-To: <CANqRtoQOs_VFku4+PKvyY1Gu0M56nfGXwratrP5qqVYxMCAMpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jan 16, 2015 at 10:49:33AM +0900, Magnus Damm wrote:
> Hi Geert,
> 
> On Thu, Jan 15, 2015 at 10:50 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > R-Car H2 (r8a7790) contains four Cortex-A15 and four Cortex-A7 cores,
> > hence the second interrupt specifier cell for Private Peripheral
> > Interrupts should use "GIC_CPU_MASK_SIMPLE(8)", to make sure interrupts
> > can be delivered to all 8 processor cores.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Untested
> >
> > v2:
> >   - Drop RFC status after receiving confirmation from Liviu Dudau.
> 
> Thanks for your work on this.
> 
> I see the "untested" word above which makes me think we should test
> both Big and Little boot modes on r8a7790. The default "Big" mode
> where CA15 is used usually gets a lot of attention, but little mode
> with CA7 boot should also work with the same kernel image.

For now I have marked these as deferred pending testing.
