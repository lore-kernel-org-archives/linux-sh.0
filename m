From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 18 Sep 2012 07:50:28 +0000
Subject: Re: [PATCH] sh: pfc: Release spinlock in sh_pfc_gpio_request_enable() error path
Message-Id: <20120918075027.GQ13568@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1347647148-28117-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1347647148-28117-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Sep 14, 2012 at 08:25:48PM +0200, Laurent Pinchart wrote:
> The sh_pfc_gpio_request_enable() function acquires a spinlock but fails
> to release it before returning if the requested mux type is not
> supported. Fix this.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Applied, thanks.
