From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 13 Nov 2015 02:12:19 +0000
Subject: Re: [PATCH v2 00/10] i2c: rcar: tackle race conditions in the driver
Message-Id: <878u62k5z4.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1447338715-9955-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1447338715-9955-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>


Hi

> Hello RCar Fans!
> 
> So, here is V2 of this series. Thanks to Geert's MSTP clock manipulation
> series, I could finally reproduce something which looks like the issues Laurent
> was seeing with his Koelsch board. The outcome is Patch 1/10 which fixes also
> issues reported by Morimoto-san using a Salvator board. I tested these patches
> with my Lager and Salvator board (latter one with scope) and Magnus' Koelsch
> via remote connection. A branch for testing can be found here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/rcar-i2c-rework-v2

I tested this branch on Lagar and Salvator-X with Sound.
(Sound uses I2C for ak4642, ak4613, and CS2000)
Actually, above branch is missing some necessary sound patch,
but anyway, I2C works good for sound.

For all patches

Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Best regards
---
Kuninori Morimoto
