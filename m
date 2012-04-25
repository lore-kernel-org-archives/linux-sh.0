From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 25 Apr 2012 00:11:05 +0000
Subject: Re: [PATCH 6/6] ARM: mach-shmobile: kzm9g: add PCF8757 gpio-key
Message-Id: <87d36wy8kp.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8762d63oni.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8762d63oni.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> I am having a little trouble getting this working on top of 3.4-rc4
> with your "[PATCH 0/6] ARM: mach-shmobile: add KZM-A9-GT board support"
> series and the rest of this series.
> 
> I have enabled INPUT_PCF8574, but perhaps that isn't sufficient?

Thank you for testing this.
But sorry, I didn't explain about it.

please enable GPIO_PCF857X, not INPUT_PCF8574

O  GPIO_PCF857X
X  INPUT_PCF8574

and enable KEYBOARD_GPIO_POLLED too

Best regards
---
Kuninori Morimoto
