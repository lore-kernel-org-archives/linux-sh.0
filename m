From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 07 Jan 2013 13:27:48 +0000
Subject: Re: [PATCH 00/22] SH pinctrl and pinmux implementation
Message-Id: <1716655.7n3O4oNpsK@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1357237073-15600-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1357237073-15600-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Linus,

On Friday 04 January 2013 16:53:47 Linus Walleij wrote:
> On Thu, Jan 3, 2013 at 7:17 PM, Laurent Pinchart wrote:
> > Here's a patch set that implements pinctrl and pinmux support for the
> > SuperH and SH Mobile pin controllers (PFC). The patches are based on my
> > previous PFC patch series ("[PATCH v4 00/81] SH pin control and GPIO
> > rework") and are available from my git tree at
> > 
> >         git://linuxtv.org/pinchartl/fbdev.git pinmux-pinctrl
> 
> Looking good to me, you can add my Acked-by and take it in through the SH
> tree as agreed.

Thank you.

Would you have time to share your thoughts about the following issue (copied 
from the cover letter of this patch series) ?

I ran into an issue when trying to port the bonito board (the only other
r8a7740 board in mainline) to the pinmux API. My board patches use system pin
control hogging to apply the initial pinmux configuration. This mechanism
requires registering the pinctrl mappings before registering the pinctrl
device, as the default states are selected when the pinctrl device is
registered. However, the mappings vary depending on board configuration read
through GPIOs, and the GPIOs are implemented by the pinctrl driver. One
possible solution would be to apply updates to the selected state as mappings
are registered, but that looks pretty complex at first sight. Other ideas (or,
better, patches :-)) are welcome.

-- 
Regards,

Laurent Pinchart

