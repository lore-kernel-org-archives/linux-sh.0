From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 13 Mar 2012 02:59:33 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: ap4evb: Reserve DMA memory for the frame buffer
Message-Id: <20120313025933.GC9916@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87r4wxi7sn.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87r4wxi7sn.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 12, 2012 at 06:55:23PM -0700, Kuninori Morimoto wrote:
> ap4evb board needs the same fix as
> 1740d3448012475f6b63172631c60cbcd1994a81
> (ARM: mach-shmobile: mackerel: Reserve DMA memory for the frame buffer)
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Too late now, we'll have to apply it in 3.4 and flag it for -stable. -rc7
is not the time to be testing and submitting fixes that should have been
done during -rc3 time or so.
