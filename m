From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 12 Jan 2012 03:24:14 +0000
Subject: Re: [PATCH] sh: also without PM_RUNTIME pm_runtime.o must be built
Message-Id: <20120112032414.GA28470@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1201101559450.530@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1201101559450.530@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 10, 2012 at 04:04:11PM +0100, Guennadi Liakhovetski wrote:
> When CONFIG_PM_RUNTIME is off, drivers/sh/pm_runtime.o still has to be
> built on sh platforms, because then it provides means to statically
> switch on device PM clocks.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Applied, thanks.
