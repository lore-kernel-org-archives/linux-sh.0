From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 06 Dec 2011 05:08:22 +0000
Subject: Re: [PATCH-RFC 09/10] sh: switch to GENERIC_PCI_IOMAP
Message-Id: <20111206050822.GA30055@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20111204104858.GK15464@redhat.com>
In-Reply-To: <20111204104858.GK15464@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Dec 04, 2011 at 12:48:59PM +0200, Michael S. Tsirkin wrote:
> On Thu, Nov 24, 2011 at 10:20:37PM +0200, Michael S. Tsirkin wrote:
> > sh copied pci_iomap from generic code, probably to avoid
> > pulling the rest of iomap.c in.  Since that's in
> > a separate file now, we can reuse the common implementation.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Sorry to nag, any ACKs/NACKs on the sh changes?
> I intend to send this to Linus if there are no
> objections. Thanks!
> 
Nope, looks fine to me.

Acked-by: Paul Mundt <lethal@linux-sh.org>
