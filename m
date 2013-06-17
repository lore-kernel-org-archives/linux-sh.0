From: Simon Horman <horms@verge.net.au>
Date: Mon, 17 Jun 2013 02:25:00 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: r8a7790: don't use external clock for SCIFs
Message-Id: <20130617022459.GL15043@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1371106854-25560-1-git-send-email-horms+renesas@verge.net.au>
 <1371106854-25560-3-git-send-email-horms+renesas@verge.net.au>
 <20130615010456.GP18124@quad.lixom.net>
In-Reply-To: <20130615010456.GP18124@quad.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jun 14, 2013 at 06:04:56PM -0700, Olof Johansson wrote:
> On Thu, Jun 13, 2013 at 04:00:54PM +0900, Simon Horman wrote:
> > From: Ulrich Hecht <ulrich.hecht@gmail.com>
> > 
> > This is an external component and may or may not be there, while the
> > internal clock always works.
> > 
> > Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Looks like this one is appropriate for arm-soc merging, but I'll hold off
> pulling this branch until the serial driver piece has been acked or dropped (to
> be merged by Greg).

This patch has a build-time dependency on the serial driver piece,
which is why I included both patches in the same pull-request.

I'll talk with Greg to see how he would like to move this forwards.
