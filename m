From: Greg KH <greg@kroah.com>
Date: Tue, 03 Dec 2013 18:44:28 +0000
Subject: Re: [PATCH 00/16] sh-sci: Remove unnecessary fields from platform data
Message-Id: <20131203184428.GC23280@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1385675010-26904-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385675010-26904-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org

On Thu, Nov 28, 2013 at 10:43:14PM +0100, Laurent Pinchart wrote:
> Hello,
> 
> This patch set removes or replaces unneeded fields from the sh-sci platform
> data structure. Fields are simply removed when unused (gpios), moved to the
> sci_port structure when used by the driver but not by board code (overrun_bit
> and error_mask), or replaced by a more explicit field with a default value
> computed in the driver for most cases (scbrr_algo_id).
> 
> The patches are based on top of the sh-sci DT patch series previously posted
> to the mailing lists.

For all serial patches:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
