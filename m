From: Simon Horman <horms@verge.net.au>
Date: Thu, 17 Jan 2013 00:31:50 +0000
Subject: Re: [RFC PATCH 3/6] usb: otg: utils: change the phy lib to support multiple PHYs of same type
Message-Id: <20130117003150.GF19552@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1358348462-27693-1-git-send-email-kishon@ti.com>
 <1358348462-27693-4-git-send-email-kishon@ti.com>
In-Reply-To: <1358348462-27693-4-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jan 16, 2013 at 08:30:59PM +0530, Kishon Vijay Abraham I wrote:
> In order to add support for multipe PHY's of the same type, the API's
> for adding PHY and getting PHY has been changed. Now the binding
> information of the PHY and controller should be done in platform file
> using usb_bind_phy API. And for getting a PHY, the device pointer of the
> USB controller and an index should be passed. Based on the binding
> information that is added in the platform file, get_phy will return the
> approappropriate PHY.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/mach-shmobile/board-marzen.c |    2 +-

Modification to the above file:

Acked-by: Simon Horman <horms+renesas@verge.net.au>
