From: Vinod Koul <vinod.koul@intel.com>
Date: Tue, 03 Jun 2014 08:14:30 +0000
Subject: Re: [PATCH 0/6] DMA: shdma: Increase build test coverage with COMPILE_TEST
Message-Id: <20140603080230.GY21128@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1399935736-16854-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1399935736-16854-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jun 02, 2014 at 03:00:04PM +0100, Ben Dooks wrote:
> On 01/06/14 18:28, Vinod Koul wrote:
> > On Tue, May 13, 2014 at 01:02:10AM +0200, Laurent Pinchart wrote:
> >> Hello,
> >>
> >> This patch series increases build test coverage for the Renesas shdma driver
> >> by enabling driver compilation with COMPILE_TEST. To avoid introducing new
> >> warnings during bisection the series starts with fixes for warnings produced
> >> when compiling the driver on non-Renesas platforms.
> > 
> > Applied all after changing subsystem to "dmaengine" manually, thanks
> 
> Which branch should I use for continuing work on the shdma/dt code?

Now that merge window has opened, pls use for-linus. I will send to Linus later
this week. It contains the fixes reported by kbuild robot

-- 
~Vinod

