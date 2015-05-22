From: Vinod Koul <vinod.koul@intel.com>
Date: Fri, 22 May 2015 12:40:05 +0000
Subject: Re: [PATCH 1/4 v2] dmaengine: rcar-dmac: fixup spinlock in rcar-dmac
Message-Id: <20150522122805.GW3140@localhost>
List-Id: <linux-sh.vger.kernel.org>
References: <878ucitwyh.wl%kuninori.morimoto.gx@renesas.com>
 <877fs2twwm.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877fs2twwm.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, Magnus <magnus.damm@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Laurent <laurent.pinchart@ideasonboard.com>, dmaengine@vger.kernel.org, sakato <ryusuke.sakato.bx@renesas.com>, Nguyen Viet Dung <nv-dung@jinso.co.jp>

On Thu, May 21, 2015 at 03:48:38AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Current rcar-dmac driver is using spin_lock_irq() / spin_unlock_irq()
> in some functions. But, some other driver might call DMAEngine API
> during interrupt disabled. In such case, rcar-dmac side spin_unlock_irq()
> forcefully allows all interrupts. Therefore, other driver receives
> unexpected interruption, and its exclusive access control will be broken.
> This patch replaces spin_lock_irq() to spin_lock_irqsave(),
> and spin_unlock_irq() to spin_unlock_irqrestore().
> 
> Reported-by: Cao Minh Hiep <cm-hiep@jinso.co.jp>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>

Mark, please apply this thru your tree

Thanks
-- 
~Vinod

