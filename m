From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 06 Jul 2012 00:36:10 +0000
Subject: Re: [PATCH] sh: select the fixed regulator driver on several boards
Message-Id: <20120706003610.GE15679@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1207051517430.30191@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1207051517430.30191@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 05, 2012 at 03:18:50PM +0200, Guennadi Liakhovetski wrote:
> On systems, using regulators to supply power to devices, if the REGULATOR
> Kconfig option is disabled, regulator API stubs will be used, which often
> suffices to bring a default configuration up. If REGULATOR is enabled but
> respective regulator drivers are inactive, the real regulator API calls
> will be used, which in the absence of drivers will fail to provide
> services. This patch prevents such a problem on sh-mobile boards by
> forcing REGULATOR_FIXED_VOLTAGE on if REGULATOR is selected.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

I suppose this just applies on top of your existing changes on the
sh/regulator topic branch?
