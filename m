From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Nov 2010 10:56:52 +0000
Subject: Re: [PATCH 2/5] ARM: mach-shmobile: mackerel: Add SMSC support
Message-Id: <w3pzkss2ya3.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pfwuk50pb.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pfwuk50pb.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus

Thank you for your advice

> > Yes. mackerel doesn't have EEPROM for SMSC
> 
> Is it possible that we can extend the kernel to located the MAC address somehow?

Hmm...
I think it is sore spot of this board.
Can we use flash area ?

> The memory window signal timing values associated with the CS signal
> can be programmed using the BSC. The timings should be optimized so we
> get decent performance. On some boards we got transmission/reception
> errors with the slowest settings, and usually the U-boot settings are
> far from optimal.
> 
> Also, if we use romImage we need to setup the BSC settings for the CS
> signal anyway.
> 
> Look at these two linux-2.6 git commits as examples:
> 
> a30c89ad41099f58922e0941e346e7c4371655b9
> 724cfb944007b7f8d346523a7810b53a35921bc5
> 
> Please check to see if you can optimize the throughput.

Thank you I understand.
I don't know current BSC is optimized or not.
But for now, it seems not so bad.
Of course I will care it continuously.
Thanks

Best regards
--
Kuninori Morimoto
