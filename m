From: Simon Horman <horms@verge.net.au>
Date: Thu, 22 Aug 2013 06:20:23 +0000
Subject: Re: [PATCH v3 2/8] ARM: shmobile: r8a7790: Constify platform data and resources
Message-Id: <20130822062023.GH11086@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1375963414-31096-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375963414-31096-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 08, 2013 at 02:03:28PM +0200, Laurent Pinchart wrote:
> Platform data and resources for core devices are kmemdup()ed when the
> corresponding devices are registered and can thus be declared as const.
> Do so.

Thanks, I have queued this up in the cleanup4 branch.
