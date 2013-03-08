From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 08 Mar 2013 11:04:45 +0000
Subject: Re: [PATCH v3 01/29] pinctrl: Declare operation structures as const
Message-Id: <1504898.E67gazT2t2@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1362574370-17889-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1362574370-17889-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Friday 08 March 2013 09:23:27 Simon Horman wrote:
> On Fri, Mar 08, 2013 at 12:25:53AM +0100, Laurent Pinchart wrote:
> > On Thursday 07 March 2013 09:17:38 Linus Walleij wrote:
> > > On Wed, Mar 6, 2013 at 1:52 PM, Laurent Pinchart wrote:
> > > > The pinconf, pinctrl and pinmux operation structures hold function
> > > > pointers that are never modified. Declare them as const.
> > > > 
> > > > Signed-off-by: Laurent Pinchart
> > > > <laurent.pinchart+renesas@ideasonboard.com>
> > > 
> > > I have this patch in the pinctrl tree nowadays...
> > 
> > OK, I'll drop it from this set.
> 
> Hi Laurent,
> 
> when you repost could you please let me know
> 
> a) the base/dependencies - though I assume this will be obvious
>    from the structure of your git tree and;
> b) weather or not the patches are ready to be queued up for v3.10.
> 
> Likewise for " PFC pinctrl functions for sh7372, sh73a0, r8a7740 and
> r8a7779" which I assume you will repost after rebasing on a fresh version
> of this series. If not, please let me know.

I've reposted both series. As stated in the cover letters I consider them both 
ready to be queued up for v3.10. They depend on two commits from the pinctrl 
tree (that are fortunately based right on top of v3.9-rc1, so you can easily 
merge them into your tree) and one board patch I've picked from the linux-sh 
mailing list (this is explained in the cover letter of the first patch series 
as well).

-- 
Regards,

Laurent Pinchart

