From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 30 Jun 2011 05:39:09 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: make a struct in board-ap4evb.c static
Message-Id: <20110630053909.GD22023@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1106291211530.12577@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1106291211530.12577@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jun 29, 2011 at 12:13:04PM +0200, Guennadi Liakhovetski wrote:
> struct soc_camera_link imx074_link in board-ap4evb.c doesn't have
> to be global.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Applied, thanks.
