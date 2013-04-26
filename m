From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 26 Apr 2013 10:18:06 +0000
Subject: Re: [PATCH v2 1/4] sh-pfc: Add support for SoC-specific initialization
Message-Id: <1960817.VHTvr2Q6hW@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1366840828-17335-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1366840828-17335-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Linus,

On Friday 26 April 2013 12:13:26 Linus Walleij wrote:
> On Thu, Apr 25, 2013 at 12:00 AM, Laurent Pinchart wrote:
> > Add two optional init and cleanup SoC operations and call them from the
> > core at probe and remove time.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> Same comment: init/exit is more natural than init/cleanup.

Thanks for the review. I'll fix that.

-- 
Regards,

Laurent Pinchart

