From: Simon Horman <horms@verge.net.au>
Date: Fri, 29 Mar 2013 04:06:27 +0000
Subject: Re: [PATCH v2 0/2]  Add R-Car Display Unit support for the Marzen board
Message-Id: <20130329040626.GJ13429@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1364412073-12322-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1364412073-12322-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 27, 2013 at 08:21:11PM +0100, Laurent Pinchart wrote:
> Hello,
> 
> Here's the second version of the r8a7779 and marzen patches that add support
> for the display unit, based on the pinctrl API.
> 
> Compared to v1, the second patch was fixed not to revert the first patch
> (which was totally unintentional).
> 
> The patches are not meant to be merged yet, they will be submitted with the
> next version of the DU driver.

Thanks, I have these working in my backport to LTSI-3.4.25.

http://lists.linuxfoundation.org/pipermail/ltsi-dev/2013-March/001268.html
