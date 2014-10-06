From: Simon Horman <horms@verge.net.au>
Date: Mon, 06 Oct 2014 07:39:20 +0000
Subject: Re: [PATCH] serial: sh-sci: submit rx dma the way the DMA driver can handle it
Message-Id: <20141006073920.GB10073@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1412266448-20266-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1412266448-20266-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

On Mon, Oct 06, 2014 at 07:59:15AM +0200, Wolfram Sang wrote:
> On Mon, Oct 06, 2014 at 10:55:40AM +0900, Simon Horman wrote:
> > On Thu, Oct 02, 2014 at 06:14:08PM +0200, Wolfram Sang wrote:
> > > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > 
> > > The shdmac driver has a problem when one wants to submit two RX
> > > descriptors and then use issue_pending on both (like this driver does):
> > > 
> > > Submit first desc
> > > -> channel state after: SHDMA_PM_ESTABLISHED
> > > 
> > > Submit second desc
> > > -> channel state after: SHDMA_PM_PENDING
> > > 
> > > PENDING here means: "Oh, we will wait until the first desc is finished
> > > and then the second desc will be grabbed from the list anyhow"
> > > 
> > > However, because issue_pending does nothing for states !> > > SHDMA_PM_ESTABLISHED, nothing ever gets active :(
> > > 
> > > Since the DMA driver is probably replaced soon anyhow, I decided for the
> > > least intrusive workaround which is to use issue_pending on every RX
> > > desc. (Yes, setting s->active_rx twice is ugly).
> > > 
> > > Probably not for upstream! However, this patch restores DMA capability
> > > for SCIFA on my Lager board. Sadly, not for SCIF due to interrupt
> > > problems still to be investigated.
> > > 
> > > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > 
> > Acked-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > sh-sci patches usually go via linux-serial@vger.kernel.org and
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org>. Could you repost this patch
> > with those parties included?
> 
> I wanted to send this patch as RFC, but forgot to rename it :) I'd
> really like some discussion about it, probably in Düsseldorf even. I am
> still not sure this patch should go upstream, but we should talk about
> it.

Thanks, I understand. Lets put this on the agenda for Düsseldorf.

