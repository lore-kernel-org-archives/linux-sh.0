From: Simon Horman <horms@verge.net.au>
Date: Mon, 26 May 2014 01:56:34 +0000
Subject: Re: [PATCH] ARM: shmobile: Fix device node reference leakage in shmobile_init_delay
Message-Id: <20140526015631.GJ31096@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1400679065-17287-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1400679065-17287-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 22, 2014 at 08:35:51PM +0900, Magnus Damm wrote:
> Hi Laurent,
> 
> On Wed, May 21, 2014 at 10:31 PM, Laurent Pinchart
> <laurent.pinchart+renesas@ideasonboard.com> wrote:
> > The of_find_compatible_node() function returns a new reference to the
> > found node. Instead of just adding of_node_put() calls, simplify the
> > code by moving the CPU identification logic inside the loop over cpu
> > nodes, in order to lower complexity from O(n) to O(1) by replacing
> > of_find_compatible_node() calls with of_device_is_compatible().
> >
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> >  arch/arm/mach-shmobile/timer.c | 50 ++++++++++++++++++++++++------------------
> >  1 file changed, 29 insertions(+), 21 deletions(-)
> 
> Thanks for fixing this! Looks good to me.
> 
> Acked-by: Magnus Damm <damm+renesas@opensource.se>

Thanks, I have queued this up.
