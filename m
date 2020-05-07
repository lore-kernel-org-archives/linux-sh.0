From: Rob Landley <rob@landley.net>
Date: Thu, 07 May 2020 18:38:06 +0000
Subject: Re: [PATCH] [RFC] media: sh_veu: Remove driver
Message-Id: <751849c0-67f9-dcdb-3cb3-6c8155ef5d08@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20200507122757.30119-1-geert+renesas@glider.be>
In-Reply-To: <20200507122757.30119-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>, Mauro Carvalho Chehab <mchehab@kernel.org>, Guennadi@rox.of.borg, Liakhovetski@rox.of.borg, g.liakhovetski@gmx.de, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Jacopo Mondi <jacopo@jmondi.org>
Cc: linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

On 5/7/20 7:27 AM, Geert Uytterhoeven wrote:
> Since its inclusion in v3.9, no users of the SuperH VEU mem2mem video
> processing driver have appeared upstream.  All VEU devices in SuperH
> board code still bind to the "uio_pdrv_genirq" driver instead.
> The original author marked the driver orphaned in v3.15.
> 
> Remove the driver; it can always be resurrected from git history when
> needed.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Rob Landley <rob@landley.net>

Rob
