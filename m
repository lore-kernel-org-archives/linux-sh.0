From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 11 Jul 2013 03:41:23 +0000
Subject: Re: [PATCH v2] ARM: shmobile: bockw: add DT reference
Message-Id: <87sizlg3vk.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87y59fup9u.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y59fup9u.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> >> If the answer is no then I think you should write an incremental patch
> >> that simply replaces r8a7778_add_standard_devices() in board-bockw.c
> >> with r8a7778_add_dt_devices(), and then you can remove
> >> r8a7778_add_standard_devices() from setup-r8a7778.c and r8a7778.h.
> >
> > I guess we will add DMAEngine support in it ?
> > r8a73a4 is such style
> 
> Yeah, maybe so. Also, I think other SoCs put SoC-specific devices
> without board-specific configuration in this list. On r8a7778 you seem
> to handle I2C and HSPI in a different way, but I am not sure why this
> special style is needed.

I talked about these things with Magnus,
and now, I understand that I misunderstood on current r8a7778 code.

Please drop my current all patch set now.
I will re-send new/cleanup patches soon.


Best regards
---
Kuninori Morimoto
