From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 20 May 2010 03:16:35 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: ap4evb: Add FSI2 support
Message-Id: <20100520031635.GE6661@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 13, 2010 at 10:08:10AM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> This patch needs Magnus's clock patch series
> 
Which version precisely? With the shared clock framework there is no
asm/clock.h header. Please update this patch for the current clock
support and I'll apply it then.
