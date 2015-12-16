From: Alan Stern <stern@rowland.harvard.edu>
Date: Wed, 16 Dec 2015 15:16:18 +0000
Subject: Re: [PATCH] i2c: rcar: disable runtime PM correctly in slave mode
Message-Id: <Pine.LNX.4.44L0.1512161011070.1751-100000@iolanthe.rowland.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1450263756-12013-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1450263756-12013-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org

On Wed, 16 Dec 2015, Wolfram Sang wrote:

> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> When we also are I2C slave, we need to disable runtime PM because the
> address detection mechanism needs to be active all the time. However, we
> can reenable runtime PM once the slave instance was unregistered. So,
> use pm_runtime_disable/enable to achieve this, since it has proper
> refcounting. pm_runtime_allow/forbid is like a global switch which is
> unsuitable here.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> I'd be grateful to get an ACK from a runtime PM expert to verify that my
> assumptions match reality :)

Yes, disabling runtime PM will do what you want.  However you might 
consider using pm_runtime_get_sync() and pm_runtime_put() instead, 
because pm_runtime_enable() does not check to see if the device is idle 
and can be suspended right away.  Alternatively, you can call 
pm_runtime_idle() after pm_runtime_enable().

pm_runtime_allow/forbid is even more unsuitable than you said, because
it can be overridden by the user.

Alan Stern

