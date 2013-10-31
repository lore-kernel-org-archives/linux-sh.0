From: Simon Horman <horms@verge.net.au>
Date: Thu, 31 Oct 2013 05:24:06 +0000
Subject: Re: [PATCH v2 2/2] clocksource: sh_tmu: Add clk_prepare/unprepare support
Message-Id: <20131031052406.GN1603@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1383000569-8916-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383057097-22689-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383057097-22689-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383057097-22689-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Oct 29, 2013 at 03:31:37PM +0100, Laurent Pinchart wrote:
> Prepare the clock at probe time, as there is no other appropriate place
> in the driver where we're allowed to sleep.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks, I have queued this up.
