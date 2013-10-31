From: Simon Horman <horms@verge.net.au>
Date: Thu, 31 Oct 2013 05:23:11 +0000
Subject: Re: [PATCH v2 1/2] clocksource: sh_mtu2: Release clock when sh_mtu2_register() fails
Message-Id: <20131031052311.GK1603@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1383000569-8916-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383057045-22608-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383057045-22608-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Oct 29, 2013 at 03:30:44PM +0100, Laurent Pinchart wrote:
> Fix the probe error path to release the clock resource when the
> sh_mtu2_register() call fails.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks, I have queued this up.
