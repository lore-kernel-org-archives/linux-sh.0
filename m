From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 25 May 2011 08:08:50 +0000
Subject: Re: [PATCH 2/2 v2] ARM: mach-shmobile: mackerel: add renesas_usbhs support for USB1
Message-Id: <20110525080846.GA28640@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pfwt6ycn4.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pfwt6ycn4.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, May 25, 2011 at 04:56:25PM +0900, Kuninori Morimoto wrote:
> renesas_usbhs driver can use external interrupt mode
> (which come from USB-PHY) or autonomy mode (it use own interrupt)
> for detecting connection/disconnection when Function.
> And it will be power OFF while it has been disconnecting
> if external interrupt mode is selected.
> 
> mackerel board has 2 USB ports.
> 
> But we can not use external interrupt mode
> on CN22 USB0 port which is only for USB Function.
> IRQ7-PORT40 is already used by Touchscreen,
> and USB-PHY needs IRQ7-PORT167.
> It is impossible to use IRQ7 demux on mackerel.
> 
> We can use external interrupt mode USB-Function on "USB1".
> USB1 can become Host by r8a66597, and become Function by renesas_usbhs.
> But don't select both drivers in same time.
> These 2 drivers are not supporting IRQ SHARD.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Looks better, applied, thanks.
