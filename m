From: Simon Horman <horms@verge.net.au>
Date: Fri, 08 Mar 2013 08:23:27 +0000
Subject: Re: [PATCH v3 01/29] pinctrl: Declare operation structures as const
Message-Id: <20130308082326.GB771@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1362574370-17889-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1362574370-17889-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 08, 2013 at 12:25:53AM +0100, Laurent Pinchart wrote:
> On Thursday 07 March 2013 09:17:38 Linus Walleij wrote:
> > On Wed, Mar 6, 2013 at 1:52 PM, Laurent Pinchart wrote:
> > > The pinconf, pinctrl and pinmux operation structures hold function
> > > pointers that are never modified. Declare them as const.
> > > 
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > 
> > I have this patch in the pinctrl tree nowadays...
> 
> OK, I'll drop it from this set.

Hi Laurent,

when you repost could you please let me know

a) the base/dependencies - though I assume this will be obvious
   from the structure of your git tree and;
b) weather or not the patches are ready to be queued up for v3.10.

Likewise for " PFC pinctrl functions for sh7372, sh73a0, r8a7740 and
r8a7779" which I assume you will repost after rebasing on a fresh version
of this series. If not, please let me know.
