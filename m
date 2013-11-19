From: Simon Horman <horms@verge.net.au>
Date: Tue, 19 Nov 2013 01:42:14 +0000
Subject: Re: [PATCH 7/7] ARM: shmobile: armadillo-reference: Use low level IRQ for ST1231
Message-Id: <20131119014214.GF17628@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1383999839-3339-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383999839-3339-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383999839-3339-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sat, Nov 09, 2013 at 01:23:59PM +0100, Laurent Pinchart wrote:
> The device is configured to generate an active-low interrupt signal that
> needs to be acknowledged by the host. Configure the IRQ to trigger on
> low level.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks, I have queued this up.
