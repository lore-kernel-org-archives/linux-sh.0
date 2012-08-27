From: Simon Horman <horms@verge.net.au>
Date: Mon, 27 Aug 2012 08:44:43 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7740: add USB24 clock explain and sample code
Message-Id: <20120827084442.GG29274@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87y5lpn4oz.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y5lpn4oz.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 08, 2012 at 01:55:28AM -0700, Kuninori Morimoto wrote:
> USBCKCR is controlling USB parent clock and divide rate.
> This parent clock is used as a "usb24s" from other devices,
> but the "divide rate" is not used.
> Further, this clock itself is known as "usb24".
> So, to set this clock is a little confusable.
> This patch adds quick explain and sample code for this clock.
> 
> Cc: Damian Hobson-Garcia <dhobsong@igel.co.jp>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

I have pushed this to the r8a7740 branch of my renesas tree,
git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git

I will endeavour to get it included in 3.7.
