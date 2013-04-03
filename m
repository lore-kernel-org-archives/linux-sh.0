From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 03 Apr 2013 00:25:04 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: R8A7779: add Ether support
Message-Id: <87sj38cvfn.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201304020204.54546.sergei.shtylyov@cogentembedded.com>
 <87y5d16b1d.wl%kuninori.morimoto.gx@renesas.com>
 <515AC4C8.1080803@cogentembedded.com>
In-Reply-To: <515AC4C8.1080803@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi Sergei

> > Current ARM SoC is trying to not use platform_device_register()
> > Please use platform_device_register_xxx()
> > Same comment for [2/2]
> 
>     Is there some rationale to it? I don't find platform_device_register_xxx()
> especially handy to use.

http://www.spinics.net/lists/linux-sh/msg16871.html

Best regards
---
Kuninori Morimoto
