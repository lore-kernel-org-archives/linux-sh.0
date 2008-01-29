From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 29 Jan 2008 00:44:08 +0000
Subject: Re: set_dma_addr missing ?
Message-Id: <20080129004408.GA9937@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <38b2ab8a0801261302i68a84fdo6d6ebdb26d9acfc8@mail.gmail.com>
In-Reply-To: <38b2ab8a0801261302i68a84fdo6d6ebdb26d9acfc8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jan 28, 2008 at 05:36:47PM +0100, Francis Moreau wrote:
> On Jan 28, 2008 3:40 PM, Stuart MENEFY <stuart.menefy@st.com> wrote:
> > Not a publicly visible one I'm afraid. There is an SRPM which contains the
> > component patches, but there are rather a lot of them now.
> 
> I'm just interested in the patches. I would prefer not to download your
> huge RPM, including the kernel source I assume. It's really pointless.
> 
The patches are also quite huge, even though they're generally pretty
well isolated. Even if we merge all of the arch/sh bits from the
outstanding patches, the remaining delta is still significant, and is
something that ST will ultimately have to merge through different
channels as they see fit. The problem is that this is such a significant
divergence that it will become a huge time investment, and it's not
obvious that that's something that will happen. Unfortunately due to a
busy travel schedule and other factors I didn't get as much time to get
ST40 bits merged for this merge window, so it's something that will
gradually trickle in. In the DMA case, it's not really worth merging in
half-steps, so starting out with a dmaengine target is probably the most
sensible way to go (otherwise by the time the ST40 DMAC stuff is ready,
all of the rest of arch/sh/drivers/dma/ drivers will have gone away).

Despite that, the ST40 tree has a lot of quirks/features/changes that we
do want to roll back in to the mainline tree so all of the other users
benefit also, but this is a very gradual process, especially on core
issues like 32-bits phys where ST and Renesas parts take some
irritatingly conflicting approaches ;-)
