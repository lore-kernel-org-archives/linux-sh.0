From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 31 May 2010 04:49:01 +0000
Subject: Re: [PATCH 3/3 v2] ARM: mach-shmobile: add support for the second SD-/MMC-card slot on ap4evb
Message-Id: <20100531044900.GC20358@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1005141228510.6147@axis700.grange> <Pine.LNX.4.64.1005141233510.6147@axis700.grange> <Pine.LNX.4.64.1005231611390.3571@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1005231611390.3571@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

On Sun, May 23, 2010 at 04:12:46PM +0200, Guennadi Liakhovetski wrote:
> The ap4evb board is equipped with two card slots: one SD-card slot and one
> SD-/MMC-card slot. The latter is connected to the second SDHI interface on
> sh7372 (SDHI1). Its power supply can be jumpered either to 1.8 or 3.3V, we fix
> it at default 1.8V for now.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Now that all of the dependencies are out of the way, I've applied this
too.
