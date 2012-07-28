From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 28 Jul 2012 00:29:12 +0000
Subject: Re: [PATCH] sh: pfc: Fix build issues in pinctrl.c
Message-Id: <20120728002911.GG30468@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201207280007.04480.rjw@sisk.pl>
In-Reply-To: <201207280007.04480.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>

On Sat, Jul 28, 2012 at 12:07:04AM +0200, Rafael J. Wysocki wrote:
> 
> First off, drivers/sh/pfc/pinctrl.c doesn't build after commit
> 5d589b0 (pinctrl: remove pinctrl_remove_gpio_range), because
> sh_pfc_pinctrl_remove() uses the function that has been removed by
> that commit.  Fix this by removing the pinctrl_remove_gpio_range()
> call, which is not necessary any more, from sh_pfc_pinctrl_remove().
> 
> Second, the compiler complains correctly that there's an unused
> local variable in sh_pfc_pinconf_set().  Fix this by removing the
> definition of that variable.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Already fixed in my tree, as pointed out when Iwamatsu-san sent the same
patch. 
