From: Simon Horman <horms@verge.net.au>
Date: Thu, 14 Mar 2013 09:12:23 +0000
Subject: Re: [PATCH v4 00/29] SH pinctrl and pinmux implementation
Message-Id: <20130314091223.GJ11196@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1362740170-19073-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1362740170-19073-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 13, 2013 at 06:27:14PM +0100, Linus Walleij wrote:
> On Wed, Mar 13, 2013 at 11:24 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Wed, Mar 13, 2013 at 06:07:46AM +0100, Linus Walleij wrote:
> >> On Sat, Mar 9, 2013 at 5:28 AM, Simon Horman <horms@verge.net.au> wrote:
> >>
> >> > I have made a merge of the fixes branch with Linus's for-next branch
> >> > and pushed the result as a new pinmux-base branch.
> >>
> >> Hm you shouldn't be basing anything on for-next in the pinctrl tree because
> >> that is rebased all the time. If you need to base off the pinctrl tree, use
> >> the "devel" branch, after handshake with me.
> >
> > Sure, I can rebase on the devel branch.
> > Can you give me an "ok" to do that and by implication push a
> > branch based on devel through arm-soc?
> 
> Yes the top of that branch should be OK, I hope we do not
> screw anything up, then we will notice :-)

Thanks!
