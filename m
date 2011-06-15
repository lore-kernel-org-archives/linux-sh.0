From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 15 Jun 2011 06:34:54 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: mackerel: tidyup usbhs driver settings
Message-Id: <20110615063454.GN17891@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p8vt362m4.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p8vt362m4.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jun 15, 2011 at 03:16:35PM +0900, Kuninori Morimoto wrote:
> - usb0 pipe is same as default. own pipe config is not needed
> - usb1 lost get_id function
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>

Looks good. Magnus, does this work for you?
