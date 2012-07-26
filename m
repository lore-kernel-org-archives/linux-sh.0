From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 26 Jul 2012 05:15:30 +0000
Subject: Re: [PATCH] sh: pfc: remove pinctrl_remove_gpio_range function
Message-Id: <20120726051530.GD30468@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1343271522-3060-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1343271522-3060-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 26, 2012 at 11:58:42AM +0900, Nobuhiro Iwamatsu wrote:
> The pinctrl_remove_gpio_range was removed form pinctrl framework.
> And the ranges of GPIO will be automatically removed when the pinctrl
> driver is unregistered.

On Thu, Jul 26, 2012 at 12:14:11PM +0900, Nobuhiro Iwamatsu wrote:
> pfc is never used, remove it.

Both already fixed in my tree.
