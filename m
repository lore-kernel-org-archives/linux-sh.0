From: Simon Horman <horms@verge.net.au>
Date: Thu, 22 Aug 2013 06:26:37 +0000
Subject: Re: [PATCH v3 6/8] ARM: shmobile: lager: Constify platform data and resources
Message-Id: <20130822062637.GN11086@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1375963414-31096-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375963414-31096-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 08, 2013 at 02:03:32PM +0200, Laurent Pinchart wrote:
> Platform data and resources for Lager devices are kmemdup()ed when the
> corresponding devices are registered and can thus be declared as const.
> Do so.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks, I have queued this up in the boards3 branch.
