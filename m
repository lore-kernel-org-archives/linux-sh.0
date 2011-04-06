From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 06 Apr 2011 18:22:47 +0000
Subject: Re: [PATCH/RFC] ARM: arch-shmobile: only run HDMI init on respective boards
Message-Id: <20110406182243.GD18426@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1104041636280.4668@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1104041636280.4668@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Apr 04, 2011 at 05:08:05PM +0200, Guennadi Liakhovetski wrote:
> If several boards are enabled in the kernel configuration, 
> hdmi_init_pm_clock() functions from board-ap4evb.c and board-mackerel.c 
> will run on any of them. Prevent this by calling these functions from the 
> .init_machine() callback instead of using device_initcall().
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Magnus Damm <damm@opensource.se>

On Tue, Apr 05, 2011 at 10:22:33AM +0900, Kuninori Morimoto wrote:
> If several boards are enabled in the kernel configuration,
> fsi_init_pm_clock() functions from board-ap4evb.c
> will run on any of them. Prevent this by calling these functions from the
> .init_machine() callback instead of using device_initcall().
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Magnus Damm <damm@opensource.se>

Both applied, thanks.
