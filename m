From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 26 Jun 2014 08:52:49 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7791: fixup GPIO6/7 register address
Message-Id: <87ha38njbm.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87y4wko5rp.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87y4wko5rp.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert

> Apparently we already use GPIO6 and GPIO7 on Koelsch, for SDHI bits,
> and for switches SW3[0-6]. At least the switches are known to work with
> the old addresses (you can verify that using "hd /dev/input/event0").
> Perhaps the GPIO blocks use incomplete address decoding?
> 
> However, did you try this patch? On Koelsch, it now either locks up after

Sorry, I didn't.
I just checked latest datasheet (H2/M2).
I'm asking correct address to HW team.
Please wait.

Best regards
---
Kuninori Morimoto
