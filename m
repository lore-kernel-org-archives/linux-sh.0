From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 18 Aug 2010 07:30:57 +0000
Subject: Re: [PATCH/RFC] ARM: mach-shmobile: do not enable the PLLC2 clock on init
Message-Id: <20100818073057.GC10056@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1008180052080.14651@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1008180052080.14651@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 18, 2010 at 12:53:58AM +0200, Guennadi Liakhovetski wrote:
> AP4EVB has to reparent PLLC2 to provide a precise HDMI clock, this is only
> possible, if PLLC2 hasn't been enabled yet. Since no other driver currently
> uses PLLC2 we can safely remove the CLK_ENABLE_ON_INIT flag. This fixes 
> the "Cannot set PLLC2 parent: -16, 1 users" error message, when trying to 
> use HDMI on AP4EVB.
> 
Applied, thanks.
