From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 17 Jul 2015 09:06:02 +0000
Subject: Re: [PATCH 0/5] R-Car DU: Add support for R8A7793 and R8A7794
Message-Id: <2044648.OO6sEKHBOn@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1437121567-18467-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <87twt3chh3.wl%kuninori.morimoto.gx@renesas.com>
 <87oajbcg5n.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87oajbcg5n.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org

Hi Morimoto-san,

Thank you for your quick reply.

On Friday 17 July 2015 09:03:32 Kuninori Morimoto wrote:
> Hi Laurent, again
> 
> >> This patch series adds support for the DU found in the R8A7793 and
> >> R8A7794 SoCs. It mostly consists of DT bindings updates (1/5 and 2/5)
> >> with a small driver change in 2/5 to support fixed RGB output routing.
> >> Patches 4/5 and 5/5 then add DU nodes to the r8a7793.dtsi and
> >> r8a7794.dtsi, with patch 3/5 adding support for the DU0 clock to
> >> r8a7794.dtsi.
> >> 
> >> I will enable DU support for the Gose and Alt board in a later step when
> >> I'll have access to the schematics. I won't be able to test that due to
> >> lack of hardware though.
> >> 
> >> The R8A7794 datasheet documents as single DU clock named DU0, while the
> >> DU section documents DU0 and DU1 channels. I don't know at this point
> >> whether this is a datasheet mistake or if the DU0 clock drives both
> >> channels. I've opted for the latter, but I'd appreciate a confirmation.
> > 
> > I will check it. please wait
> 
> According to HW team, MSTP page of datasheet seems wrong
> Maybe you have already tried, but,
> can you access to MSTPSR1 :: 27bit (for DU1)

I would try if I had access to an Alt board :-)

Magnus, do you have an Alt board I could access remotely ?

-- 
Regards,

Laurent Pinchart

