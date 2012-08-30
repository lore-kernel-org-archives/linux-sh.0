From: Simon Horman <horms@verge.net.au>
Date: Thu, 30 Aug 2012 04:57:13 +0000
Subject: Re: [PATCH 8/8] ARM: shmobile: kzm9g: use gpio-keys instead of gpio-keys-polled
Message-Id: <20120830045711.GB30566@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87bohvdbcc.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bohvdbcc.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 27, 2012 at 07:00:54PM -0700, Kuninori Morimoto wrote:
> 6e20a0a429bd4dc07d6de16d9c247270e04e4aa0
> (gpio: pcf857x: enable gpio_to_irq() support) supports
> gpio_to_irq() on pcf857x driver.
> Now, we can use gpio-keys driver instead of gpio-keys-polled.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, I have tested this an it seems to work.

I have pushed it to a new kzm9g-gpio branch of my renesas tree.

The kzm9g-gpio branch is is based on the devel branch of the gpio tree
found at git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
