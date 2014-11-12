From: Vinod Koul <vinod.koul@intel.com>
Date: Wed, 12 Nov 2014 10:56:51 +0000
Subject: Re: [PATCH] dmaengine: shdma: fix a race condition in __ld_cleanup()
Message-Id: <20141112105705.GG24582@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1412820540-4892-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1412820540-4892-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Oct 09, 2014 at 11:09:00AM +0900, Yoshihiro Shimoda wrote:
> This patch fixes a race condition about a list of shdma-base driver.
> If we don't apply this patch, a dma slave driver (especially a usb
> peripheral driver) may not be able to start the transfer.
> 
> If a dma slave driver has a callback, __ld_cleanup() will call
> the callback before this driver removes the list. After the callback,
> since the return value of __ld_cleanup() is not zero,
> shdma_chan_ld_cleanup() calls __ld_cleanup() again. And, __ld_clean()
> will removes the list.
> 
> At this time, if a dma slave driver calls dmaengine_submit() before
> this driver removes the list, this driver will set schan->pm_state
> to SHDMA_PM_PENDING in shdma_tx_submit(). And then, even if a dma
> slave driver calls dma_async_issue_pending(), this driver don't
> start the transfer because the schan->pm_state is SHDMA_PM_PENDING
> in shdma_issue_pending().
> 
> So, this patch adds a new condition in __ld_clean() to check if the
> schan->pm_state is SHDMA_PM_PENDING or not.
Applied, thanks

-- 
~Vinod

