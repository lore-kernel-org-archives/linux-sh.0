From: Olof Johansson <olof@lixom.net>
Date: Sat, 15 Jun 2013 00:47:51 +0000
Subject: Re: [PATCH 0/1] gpio-rcar: Add DT support
Message-Id: <20130615004751.GM18124@quad.lixom.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1371106826-25313-1-git-send-email-horms+renesas@verge.net.au>
 <1371106826-25313-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1371106826-25313-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Jun 13, 2013 at 04:00:26PM +0900, Simon Horman wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> Add DT bindings for the gpio-rcar driver and read the device
> configuration from the DT node at probe time if available.
> 
> Cc: devicetree-discuss@lists.ozlabs.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Hi,

I don't see this cc/acked by Linus or Grant/Rob. However, the binding
looks very vanilla to me, so I'll merge it anyway.


-Olof
