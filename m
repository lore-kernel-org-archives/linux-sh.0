From: Sakari Ailus <sakari.ailus@iki.fi>
Date: Fri, 18 Dec 2015 22:24:45 +0000
Subject: Re: [PATCH/RFC 21/48] media: Move media_device link_notify operation to an ops structure
Message-Id: <20151218222445.GQ17128@valkosipuli.retiisi.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1450341626-6695-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1450341626-6695-22-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1450341626-6695-22-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-sh@vger.kernel.org

On Thu, Dec 17, 2015 at 10:39:59AM +0200, Laurent Pinchart wrote:
> This will allow adding new operations without increasing the
> media_device structure size for drivers that don't implement any media
> device operation.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
