From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 29 Oct 2015 07:40:00 +0000
Subject: Re: Salvator-X I2C is working on HI speed on renesas-drivers-2015-10-27-v4.3-rc7
Message-Id: <87ziz2yvon.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <877fm61988.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877fm61988.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert

> Does it work if you revert commit 2bc3c5a8631db6d8 ("i2c: rcar: init new
> messages in irq")?
> That commit was reported by Laurent to break HDMI on Koelsch, cfr.
> http://www.spinics.net/lists/linux-sh/msg46160.html.

Thank you for your feedback.
I reverted it, but it was same result.

# 09-29 version works with 100kHz,
# but, 10-27 version works with 1MHz over in my quick check
