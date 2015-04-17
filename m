From: Vinod Koul <vinod.koul@intel.com>
Date: Fri, 17 Apr 2015 18:11:18 +0000
Subject: Re: [PATCH] dmaengine: usb-dmac: Fix dereferencing freed memory 'desc'
Message-Id: <20150417175917.GG30624@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1428060015-2896-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1428060015-2896-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 03, 2015 at 08:20:15PM +0900, Yoshihiro Shimoda wrote:
> This patch fixes an issue that the usb_dmac_desc_free() is
> dereferencing freed memory 'desc' because it uses list_for_each_entry().
> This function should use list_for_each_entry_safe().
> 
Applied, thanks

-- 
~Vinod

