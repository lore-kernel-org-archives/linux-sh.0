From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 07 Mar 2013 23:25:53 +0000
Subject: Re: [PATCH v3 01/29] pinctrl: Declare operation structures as const
Message-Id: <2165458.8hH9SVz4Su@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1362574370-17889-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1362574370-17889-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thursday 07 March 2013 09:17:38 Linus Walleij wrote:
> On Wed, Mar 6, 2013 at 1:52 PM, Laurent Pinchart wrote:
> > The pinconf, pinctrl and pinmux operation structures hold function
> > pointers that are never modified. Declare them as const.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> I have this patch in the pinctrl tree nowadays...

OK, I'll drop it from this set.

-- 
Regards,

Laurent Pinchart

