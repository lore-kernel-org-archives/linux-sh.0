From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 12 Dec 2019 02:36:13 +0000
Subject: Re: [PATCH] sh: add missing EXPORT_SYMBOL() for __delay
Message-Id: <87y2viclsy.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87zhfyclvb.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87zhfyclvb.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org


Hi

> From: morimoto <kuninori.morimoto.gx@renesas.com>
> 
> __delay() is used from kernel module.
> We need EXPORT_SYMBOL(), otherwise we will get compile error.
> 
> ERROR: "__delay" [drivers/net/phy/mdio-cavium.ko] undefined!
> 
> Signed-off-by: morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---

I'm so sorry.
The Signed is strange.
I will re-post patch.
Please drop it.

Thank you for your help !!
Best regards
---
Kuninori Morimoto
