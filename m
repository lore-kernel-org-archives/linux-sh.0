From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 25 May 2015 17:15:49 +0000
Subject: Re: [PATCH] DMA: shdma: r8a73a4: Make dma_ts_shift[] static
Message-Id: <20150525170349.GJ3140@localhost>
List-Id: <linux-sh.vger.kernel.org>
References: <1432209510-20449-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1432209510-20449-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 21, 2015 at 01:58:30PM +0200, Geert Uytterhoeven wrote:
> dma_ts_shift[] isn't used outside this source file. All other users use
> the definition from arch/arm/mach-shmobile/dma-register.h.
Applied, thanks

-- 
~Vinod

