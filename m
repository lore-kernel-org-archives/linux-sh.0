From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 27 Apr 2015 03:18:44 +0000
Subject: Re: [PATCH] dmaengine: usb-dmac: Protect PM-only functions to kill warning
Message-Id: <20150427030644.GE2738@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430042034-30780-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1430042034-30780-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

On Sun, Apr 26, 2015 at 11:53:54AM +0200, Geert Uytterhoeven wrote:
> If CONFIG_PM=n:
> 
>     drivers/dma/sh/usb-dmac.c:677: warning: ‘usb_dmac_runtime_suspend’ defined but not used
>     drivers/dma/sh/usb-dmac.c:688: warning: ‘usb_dmac_runtime_resume’ defined but not used
> 
> Protect the unused functions by #ifdef CONFIG_PM to fix this.
> 
Applied, thanks

-- 
~Vinod
