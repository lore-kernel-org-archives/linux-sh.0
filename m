From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 01 Sep 2010 05:02:11 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: ap4evb: modify tsc2007 platform
Message-Id: <w3piq2qgip8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p1v9weglx.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p1v9weglx.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus

Thank you for checking/testing patch

> Top left corner: Pressure value 140-440
> Top right corner: Pressure value 650-800
> Bottom left corner: Pressure value 200-900
> Bottom right corner: Pressure value 140-840
(snip)
> I did not test without your patch. Maybe the pressure ranges are
> strange because the touch screen is rotated incorrectly?
> 
> Do you see the same behavior on your hardware? Thanks for your help!

It is same behavior on your hardware too.

I tested without my patch.
The pressure ranges seem not to depend on the parts.
This mean my patch seems not correct...

Best regards
--
Kuninori Morimoto
