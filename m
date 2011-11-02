From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 02 Nov 2011 09:29:35 +0000
Subject: Re: [PATCH 1/3] PM / Sleep: Mark devices involved in wakeup signaling
Message-Id: <Pine.LNX.4.64.1111021015350.18080@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <201110200012.43840.rjw@sisk.pl> <201110200013.56428.rjw@sisk.pl>
In-Reply-To: <201110200013.56428.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>

Hi Rafael

Just something, that made me wonder:

On Thu, 20 Oct 2011, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The generic PM domains code in drivers/base/power/domain.c has
> to avoid powering off domains that provide power to wakeup devices
> during system suspend.  Currently, however, this only works for
> wakeup devices directly belonging to the given domain and not for
> their children (or the children of their children and so on).
> Thus, if there's a wakeup device whose parent belongs to a power
> domain handled by the generic PM domains code, the domain will be
> powered off during system suspend preventing the device from
> signaling wakeup.
> 
> To address this problem introduce a device flag, power.wakeup_path,
> that will be set during system suspend for all wakeup devices,
> their parents, the parents of their parents and so on.  This way,
> all wakeup paths in the device hierarchy will be marked and the
> generic PM domains code will only need to avoid powering off
> domains containing devices whose power.wakeup_path is set.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/base/power/domain.c |    4 ++--
>  drivers/base/power/main.c   |    8 +++++++-
>  include/linux/pm.h          |    1 +
>  3 files changed, 10 insertions(+), 3 deletions(-)

[snip]

> Index: linux/include/linux/pm.h
> =================================> --- linux.orig/include/linux/pm.h
> +++ linux/include/linux/pm.h
> @@ -452,6 +452,7 @@ struct dev_pm_info {
>  	struct list_head	entry;
>  	struct completion	completion;
>  	struct wakeup_source	*wakeup;
> +	bool			wakeup_path:1;

This is an interesting idea... I'd presume, the compiler is aware, that 
one bit is enough for "bool," so, it should choose an optimal 
implementation by itself? I checked gcc 4.4.1 on ARM - without the 
bitfield notation the compiler just uses one byte in my example. Anyway, 
not a request-for-change, just wondering whether you really were trying to 
(potentially) save a couple of bits here or what was the motivation.

>  #else
>  	unsigned int		should_wakeup:1;
>  #endif

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
