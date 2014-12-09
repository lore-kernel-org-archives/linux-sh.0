From: Simon Horman <horms@verge.net.au>
Date: Tue, 09 Dec 2014 00:29:06 +0000
Subject: Re: [PATCH/RFC 0/4] ARM: shmobile: Correct masks for GIC PPI interrupts
Message-Id: <20141209002905.GD8897@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1417085839-22836-1-git-send-email-geert+renesas@glider.be>
 <20141208001345.GA11177@verge.net.au>
 <CAMuHMdW0ZhRQKuckNkRv3WWQ-6sUez6VP9U3D-W6kpbaqkZaOQ@mail.gmail.com>
In-Reply-To: <CAMuHMdW0ZhRQKuckNkRv3WWQ-6sUez6VP9U3D-W6kpbaqkZaOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Dec 08, 2014 at 09:04:16AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Mon, Dec 8, 2014 at 1:13 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Nov 27, 2014 at 11:57:15AM +0100, Geert Uytterhoeven wrote:
> >> This patch series corrects the masks in the second interrupt cells for
> >> Private Peripheral Interrupts in dtsi files for the shmobile family of
> >> SoCs.
> >>
> >> It's my understanding this mask should reflect the actual number of CPU
> >> cores the interrupt is wired too.
> >> Is that correct?
> >>
> >>   - Hence it should be "GIC_CPU_MASK_SIMPLE(2)" on dual-core CPUs, like
> >>     r8a7791 and r8a7794 (the first two patches),
> >>   - Should it be "GIC_CPU_MASK_SIMPLE(8)" on big.LITTLE configurations
> >>     with four Cortex-A15 cores and four Cortex-A7 cores?
> >>     Or should the interrupts be delivered to the four Cortex-A15 cores
> >>     only by default?
> >>     The last two RFC-patches implement the former for r8a7790 and
> >>     r8a73a4.
> >>
> >> Note that incorrect masks for GIC PPI interrupts are not limited to
> >> shmobile. Presumably the interrupt specifiers got copied around a lot,
> >> cfr. the proliferation of "GIC_CPU_MASK_SIMPLE(4)" (and the older
> >> hardcoded "0xf0x" variant) in various dtsi files, not always limited to
> >> quad-core CPUs.
> >>
> >> This was tested on r8a7791/koelsch, which uses the arch timer interrupt.
> >>
> >> Thanks for your feedback!
> >>
> >> Geert Uytterhoeven (4):
> >>   ARM: shmobile: r8a7791: Correct mask for GIC PPI interrupts
> >>   ARM: shmobile: r8a7794: Correct mask for GIC PPI interrupts
> >
> > Hi Geert,
> >
> > the above two patches seem like they could be queued up.
> > Shall I do so?
> 
> I think it's safe. Thanks!

Thanks, I have done so.
