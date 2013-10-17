From: Max Filippov <max.filippov@cogentembedded.com>
Date: Thu, 17 Oct 2013 12:39:37 +0000
Subject: Re: [PATCH 0/3] rcar-hpbdma: fixup patches for double plane
Message-Id: <CANcw1+k5jDvun8jmOcn1KNsK-dsfX=-HfT26SLwuZQNWEwUeWQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87k3hc189h.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k3hc189h.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Kuninori,

On Thu, Oct 17, 2013 at 2:50 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Simon, Max
>
> These patches fixup R-Car HBPDMA driver
> for double plane.
>
> Max
>
> Could you please review these patches ?
> Especially last patch.
> It checks DQSTS when double plane, but I'm not good at HPBDMA.
>
> I tested these patches on my R-Car sound driver in local environment.
> It doesn't work without these patches.
>
> Kuninori Morimoto (3):
>       rcar-hpbdma: add max transfer size
>       rcar-hpbdma: initialise plane information when halted
>       rcar-hpbdma: fixup channel busy check for double plane
>
>  drivers/dma/sh/rcar-hpbdma.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

For the whole series:
Reviewed-by: Max Filippov <max.filippov@cogentembedded.com>

-- 
Thanks.
-- Max
