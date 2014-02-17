From: Simon Horman <horms@verge.net.au>
Date: Mon, 17 Feb 2014 03:09:49 +0000
Subject: Re: [PATCH v3 1/4] ARM: shmobile: lager-reference: Refactor clock lookup hack
Message-Id: <20140217030945.GC7772@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1392586321-12187-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1392586321-12187-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Feb 17, 2014 at 11:52:23AM +0900, Magnus Damm wrote:
> On Mon, Feb 17, 2014 at 6:31 AM, Laurent Pinchart
> <laurent.pinchart+renesas@ideasonboard.com> wrote:
> > Make the clock lookup hack more generic to ease the addition of more
> > devices.
> >
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> >  arch/arm/mach-shmobile/board-lager-reference.c | 37 +++++++++++++++-----------
> >  1 file changed, 22 insertions(+), 15 deletions(-)
> 
> Looks better than before to me!
> 
> Acked-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up.
