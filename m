From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 28 Nov 2013 17:11:44 +0000
Subject: [PATCH 0/2] serial: sh-sci: Prepare for CCF migration
Message-Id: <1385658706-20093-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>

Hello,

This patch set prepares the driver to CCF migration by replacing clk_enable()
and clk_disable() by clk_prepare_enable() and clk_disable_unprepare()
respectively (2/2). In order to do so it first ensures that the clk_enable()
and clk_disable() calls will only take place from non-atomic context (1/2).

Greg, these patches are dependencies for a bunch of ARM patches that will go
through Simon's tree. Would you be fine if Simon merged all sh-sci patches
through his tree for v3.14 ?

Laurent Pinchart (2):
  serial: sh-sci: Don't enable/disable port from within break timer
  serial: sh-sci: Convert to clk_prepare/unprepare

 drivers/tty/serial/sh-sci.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

-- 
Regards,

Laurent Pinchart

