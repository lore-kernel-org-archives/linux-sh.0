From: Vinod Koul <vinod.koul@intel.com>
Date: Sun, 01 Jun 2014 17:40:07 +0000
Subject: Re: [PATCH 0/6] DMA: shdma: Increase build test coverage with COMPILE_TEST
Message-Id: <20140601172807.GS21128@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1399935736-16854-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1399935736-16854-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, May 13, 2014 at 01:02:10AM +0200, Laurent Pinchart wrote:
> Hello,
> 
> This patch series increases build test coverage for the Renesas shdma driver
> by enabling driver compilation with COMPILE_TEST. To avoid introducing new
> warnings during bisection the series starts with fixes for warnings produced
> when compiling the driver on non-Renesas platforms.

Applied all after changing subsystem to "dmaengine" manually, thanks

-- 
~Vinod
