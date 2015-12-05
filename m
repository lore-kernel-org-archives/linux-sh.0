From: Vinod Koul <vinod.koul@intel.com>
Date: Sat, 05 Dec 2015 08:20:19 +0000
Subject: Re: [PATCH] dmaengine: usb-dmac: fix endless loop in usb_dmac_chan_terminate_all()
Message-Id: <20151205080819.GL1854@localhost>
List-Id: <linux-sh.vger.kernel.org>
References: <1447303060-7880-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1447303060-7880-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 12, 2015 at 01:37:40PM +0900, Yoshihiro Shimoda wrote:
> This patch fixes an issue that list_for_each_entry() in
> usb_dmac_chan_terminate_all() is possible to cause endless loop because
> this will move own desc to the desc_freed. So, this driver should use
> list_for_each_entry_safe() instead of list_for_each_entry().

Applied now, thanks

-- 
~Vinod
