From: Simon Horman <horms@verge.net.au>
Date: Tue, 30 Jul 2013 00:01:13 +0000
Subject: Re: [PATCH] ARM: shmobile: Remove unused mach/sdhi*.h headers
Message-Id: <20130730000112.GE11142@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1375125846-25149-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375125846-25149-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 29, 2013 at 09:27:02PM +0200, Laurent Pinchart wrote:
> On Monday 29 July 2013 21:24:06 Laurent Pinchart wrote:
> > The headers are not used anymore, remove them.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> Scratch this, my bad, I hadn't realized the headers were still needed by 
> arch/arm/boot/compressed/sdhi-mobile.c. Sorry for the noise.

Scratched.
