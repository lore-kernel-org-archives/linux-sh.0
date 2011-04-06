From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 06 Apr 2011 01:52:40 +0000
Subject: Re: [PATCH/RFC] ARM: arch-shmobile: only run HDMI init on respective
Message-Id: <w3p7hb8qh7b.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1104041636280.4668@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1104041636280.4668@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

At Mon, 04 Apr 2011 17:08:05 +0200 (CEST),
Guennadi wrote:
> 
> If several boards are enabled in the kernel configuration, 
> hdmi_init_pm_clock() functions from board-ap4evb.c and board-mackerel.c 
> will run on any of them. Prevent this by calling these functions from the 
> .init_machine() callback instead of using device_initcall().
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Magnus Damm <damm@opensource.se>
> ---
> 
> Marked as RFC, until tested on mackerel

I tested this patch on mackerel with v2.6.39-rc1
And it works

Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
