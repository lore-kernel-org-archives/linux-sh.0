From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Mon, 06 Jul 2009 00:45:32 +0000
Subject: Re: [PATCH] sh: add r8a66597 usb0 host to the se7724 board
Message-Id: <uzlbibpw3.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus

> Add USB host support for port CN27 on the Solution Engine 7724
> board. The r8a66597-hcd driver is hooked up as a platform device
> and some registers are configured to enable the USB host function.
> The hardware driving the USB port is the on-chip USB0 block in
> the sh7724 processor configured as USB host controller.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---

ms7724se board only ?
I have planned to add USB host support to setup-sh7724.c.

Best regards
--
Kuninori Morimoto
