From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 22 Feb 2010 07:41:04 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: pfc-sh7377: modify KEYIN settings
Message-Id: <20100222074103.GA1417@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <ur5ohpsh7.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <ur5ohpsh7.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Feb 22, 2010 at 04:32:28PM +0900, NISHIMOTO Hiroki wrote:
> I tested this patch and found that it made the keysc behavior worse.
> Please stop applying the patch.
> 
> I will investigate the cause of the issue and send a patch latar.
> 
When this patch is resubmitted it should also have a sensible changelog,
since it's obvious that this is not just a simple mechanical change.
