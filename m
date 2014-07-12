From: Simon Horman <horms@verge.net.au>
Date: Sat, 12 Jul 2014 06:50:43 +0000
Subject: Re: [PATCH v2 repost] serial: sh-sci: Add device tree support for r8a7{778,740,3a4} and sh73a0
Message-Id: <20140712065040.GB24129@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140711091107.GA25710@verge.net.au>
 <20140712004451.GA9549@kroah.com>
In-Reply-To: <20140712004451.GA9549@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jul 11, 2014 at 05:44:51PM -0700, Greg Kroah-Hartman wrote:
> On Fri, Jul 11, 2014 at 11:11:08AM +0200, Simon Horman wrote:
> > Simply document new compat strings.
> > There appears to be no need for a driver updates.
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > --
> > v2
> > * Added r8a73a4, r8a7740 and sh73a0 support
> > 
> > Repost to Greg KH.
> > 
> > Greg, I am hoping to get the platform side of this change included in v3.16.
> 
> Isn't it a bit late for 3.16?  I'll go add this to my 3.16 tree, as it's
> just a .txt file, and leave the fighting over new code to the other
> maintainers :)

Thanks.

In order to avoid fighting I'll queue up the code changes for v3.17.
