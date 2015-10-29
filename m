From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 29 Oct 2015 06:31:22 +0000
Subject: Salvator-X I2C is working on HI speed on renesas-drivers-2015-10-27-v4.3-rc7
Message-Id: <877fm61988.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert, Wolfram

I'm debugging renesas-drivers-2015-10-27-v4.3-rc7 yesterday/today
and I noticed that I2C doesn't work on Salvator-X

Sound needs Codec/CS2000, these both needs I2C access.
But, it gets -ENXIO from bus.
At least it works on renesas-drivers-2015-09-29-v4.3-rc3.

In my debug, it seems I2C SCL/SDA speed on 10-27 is very HI.
(I checked this via CN27 73/74pin)
But, i2c clock on /sys/kernel/debug/clk/clk_summary in 09-29 <-> 10-27
seems same value.

Where should I check ?

Best regards
---
Kuninori Morimoto
