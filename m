From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 29 May 2012 07:04:58 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: tidyup: sound card detection order
Message-Id: <20120529070458.GB11445@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87mx4rmqzd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mx4rmqzd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, May 29, 2012 at 03:46:25PM +0900, Simon Horman wrote:
> On Mon, May 28, 2012 at 11:38:34PM -0700, Kuninori Morimoto wrote:
> > Current sound card is using snd-simple-card,
> > but it requests probe deferral when boot, since the detection
> > timing of snd-simple-card is earlier than sh.
> > 
> > Because of this behavior, if platform has some sound cards,
> > the postponed probe order was changed
> > and it breaks ALSA device list order.
> > 
> > This patch makes it consistent on mackerel/ap4evb
> 
> Hi Morimoto-san,
> 
> Is the problem that a previous patch altered the order of the
> ALSA index of the sound cards? And this patch restores the previous order?
> 
> If so, I wonder if this is really necessary as is should
> be possible to set the index using a module parameter if one
> is relying on it.
> 
One would expect so. What happens if the ALSA drivers are built as
modules and inserted in random order today? If you require persistent
assignment then you will have to deal with it either through module
parameters or udev.
