From: Simon Horman <horms@verge.net.au>
Date: Tue, 18 Dec 2012 02:15:56 +0000
Subject: Re: [PATCH v3 27/81] ARM: shmobile: r8a7740: Add pin control resources
Message-Id: <20121218021556.GH28065@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1355611915-25060-28-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1355611915-25060-28-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Dec 15, 2012 at 11:51:01PM +0100, Laurent Pinchart wrote:
> Add memory resources for the pin control platform device to let the
> sh-pfc driver ioremap() registers properly instead of evily casting
> register physical addresses to virtual addresses.

Acked-by: Simon Horman <horms+renesas@verge.net.au>


