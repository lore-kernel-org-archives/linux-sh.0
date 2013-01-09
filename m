From: Simon Horman <horms@verge.net.au>
Date: Wed, 09 Jan 2013 07:06:48 +0000
Subject: Re: [PATCH v2 0/8] SH pinctrl DT support
Message-Id: <20130109070648.GB11484@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1357693395-1653-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1357693395-1653-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 09, 2013 at 02:03:07AM +0100, Laurent Pinchart wrote:
> Hello,
> 
> Here's the second version of the SuperH and SH Mobile pin controllers (PFC) DT
> support patch set. The patches are based on the second version of my previous
> PFC pinctrl and pinmux patch series ("[PATCH v2 00/29] SH pinctrl and pinmux
> implementation") and are available from my git tree at
> 
>         git://linuxtv.org/pinchartl/fbdev.git pinmux-dt
> 
> The series is pretty self-explanatory. DT bindings are added in patch 1/9, and
> the following patches move board code over to the device tree.

Thanks applied to the following branches:

patch 1: pfc3 branch
patch 2, 4, 5, 8, 8: boards branch
patch 3, 6: soc2 branch


