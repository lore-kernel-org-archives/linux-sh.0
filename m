From: Simon Horman <horms@verge.net.au>
Date: Sun, 19 Jun 2011 22:49:20 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: mackerel: change usbhs devices order
Message-Id: <20110619224920.GA2742@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pips5oz5i.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pips5oz5i.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 17, 2011 at 01:33:13PM +0900, Kuninori Morimoto wrote:
> USB1 can use IRQ interrupt and notify function for usbhs driver,
> but USB0 is using polling for it.
> The priority of usbhs devices order USB1 > USB0 is good idea
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Its a shame this wasn't added in the correct order when
it was recently added :-)

Reviewed-by: Simon Horman <horms@verge.net.au>
