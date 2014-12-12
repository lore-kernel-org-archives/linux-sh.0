From: Simon Horman <horms@verge.net.au>
Date: Fri, 12 Dec 2014 07:07:40 +0000
Subject: Re: [PATCH 1/5] ARM: shmobile: r8a73a4: Multiplatform support
Message-Id: <20141212070739.GB3362@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1417509439-31739-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1417509439-31739-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Dec 12, 2014 at 09:51:43AM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Fri, Dec 12, 2014 at 9:13 AM, Simon Horman <horms@verge.net.au> wrote:
> > Hi Magnus, Hi Ulrich,
> >
> > On Thu, Dec 11, 2014 at 09:31:13PM +0900, Magnus Damm wrote:
> >> Hi Ulrich,
> >>
> >> On Tue, Dec 2, 2014 at 5:37 PM, Ulrich Hecht
> >> <ulrich.hecht+renesas@gmail.com> wrote:
> >> > Enable r8a73a4 Multiplatform support for the generic r8a73a4
> >> > machine vector.
> >> >
> >> > Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> >>
> >> This for your efforts. This particular patch is fine with me.
> >>
> >> Acked-by: Magnus Damm <damm+renesas@opensource.se>
> >>
> >> Regarding the other patches, as discussed over chat please consider
> >> optimising the patch order to allow merge of multiplatform merge
> >> independently of board removal and renaming of files. Basically I
> >> think you can add multiplatform support using the non-reference DT
> >> file directly and not making use of any C board code.
> >
> > Would you like me to queue up this patch now?
> 
> Thanks for the offer, but I think we should wait for Ulrich to rework
> this series first. Once a couple of patches are OK as-is then it would
> be nice to merge them before the CCF bits are in place. But I guess it
> much depends on how Ulrich will split the code.

Thanks, I will immediately do nothing.
