From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 02 Aug 2012 06:37:44 +0000
Subject: Re: [PATCH] sh: explicitly include sh_dma.h in setup-sh7722.c
Message-Id: <20120802063744.GB9596@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1208011044150.5406@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1208011044150.5406@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 01, 2012 at 10:44:57AM +0200, Guennadi Liakhovetski wrote:
> setup-sh7722.c defines several objects, whose types are defined in
> sh_dma.h, so, it has to be included explicitly.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Applied, thanks.
