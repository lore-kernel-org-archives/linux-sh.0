From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 24 Jan 2012 00:58:47 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: ag5: fixup compile break
Message-Id: <20120124005847.GC32319@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <8739b7huos.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8739b7huos.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Jan 22, 2012 at 09:08:55PM -0800, Kuninori Morimoto wrote:
> This patch fixup below compile break
> 
>   CC      arch/arm/mach-shmobile/board-ag5evm.o
> ${LINUX}/arch/arm/mach-shmobile/board-ag5evm.c:274:\
>    error: 'V4L2_PIX_FMT_RGB565' undeclared here (not in a function)
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

I've already applied the same fix from someone else, thanks anyways.
