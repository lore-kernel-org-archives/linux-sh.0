From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 02 Dec 2013 13:36:32 +0000
Subject: Re: [PATCH 0/2] serial: sh-sci: Prepare for CCF migration
Message-Id: <1516614.DSSr7jaai1@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1385658706-20093-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385658706-20093-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Simon Horman <horms@verge.net.au>

Hi Greg,

On Thursday 28 November 2013 18:11:44 Laurent Pinchart wrote:
> Hello,
> 
> This patch set prepares the driver to CCF migration by replacing
> clk_enable() and clk_disable() by clk_prepare_enable() and
> clk_disable_unprepare() respectively (2/2). In order to do so it first
> ensures that the clk_enable() and clk_disable() calls will only take place
> from non-atomic context (1/2).
> 
> Greg, these patches are dependencies for a bunch of ARM patches that will go
> through Simon's tree. Would you be fine if Simon merged all sh-sci patches
> through his tree for v3.14 ?

Ping ?

> Laurent Pinchart (2):
>   serial: sh-sci: Don't enable/disable port from within break timer
>   serial: sh-sci: Convert to clk_prepare/unprepare
> 
>  drivers/tty/serial/sh-sci.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
-- 
Regards,

Laurent Pinchart

