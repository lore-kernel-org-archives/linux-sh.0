From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 31 Jan 2013 10:14:34 +0000
Subject: Re: [PATCH 1/3] r8a7779: Add Display Unit clock support
Message-Id: <2488055.1BuytUnxUW@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1359596703-17556-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1359596703-17556-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <20130131063520.GB24518@verge.net.au>
In-Reply-To: <20130131063520.GB24518@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org, magnus.damm@gmail.com, Phil Edworthy <phil.edworthy@renesas.com>

Hi Simon,

On Thursday 31 January 2013 15:35:20 Simon Horman wrote:
> On Thu, Jan 31, 2013 at 02:45:01AM +0100, Laurent Pinchart wrote:
> > From: Phil Edworthy <phil.edworthy@renesas.com>
> > 
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > [Rename device from to rcarfb to rcar-du]
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> Thanks, I have applied this to the soc3 branch, merged it into the next
> branch. At this point intend to try and have it included in 3.9, though
> we are now late in the cycle so that may not happen.

As the DRM driver will not go to mainline before v3.10, I'd rather delay this 
patch as well to give reviewers a chance to comment on the driver.

-- 
Regards,

Laurent Pinchart

