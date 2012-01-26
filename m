From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 26 Jan 2012 00:12:01 +0000
Subject: Re: [PATCH v2] sh: se7724: fix compile breakage
Message-Id: <201201260112.01582.laurent.pinchart@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1201252205550.18778@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1201252205550.18778@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi,

Thanks for the patch.

On Wednesday 25 January 2012 22:07:05 Guennadi Liakhovetski wrote:
> Fix compilation breakage
> 
> arch/sh/boards/mach-se/7724/setup.c:182: error: 'V4L2_PIX_FMT_RGB565'
> undeclared here (not in a function) make[3]: ***
> [arch/sh/boards/mach-se/7724/setup.o] Error 1
> 
> caused by commit "fbdev: sh_mobile_lcdc: Support FOURCC-based format API"
> Also add other missing headers, even if compilation currently succeeds
> because of their indirect inclusion via other headers.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
