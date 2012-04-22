From: kuninori.morimoto.gx@renesas.com
Date: Sun, 22 Apr 2012 23:58:53 +0000
Subject: Re: [alsa-devel] ASoC: sh: fsi: Build proble in 3.4-rc4
Message-Id: <87fwbv9v47.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201204230001.41270.rjw@sisk.pl>
In-Reply-To: <201204230001.41270.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-sh@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Liam Girdwood <lrg@ti.com>


Hi Rafael

> There is a build problem in sound/soc/sh/fsi.c which seems to be fixed by
> the following patch.  I'm unsure if that is the right fix, though.

Thank you about this patch.
But this issue was solved by below patch on Mark's/for-3.4 branch

------------------------------------------------
commit cdf27f373781d8740b874b0b5c18142df32ebb52
Author: Paul Mundt <lethal@linux-sh.org>
Date:   Tue Apr 17 19:13:04 2012 -0700

    ASoC: fsi: update for dmaengine prep_slave_sg fallout.
    
    Leading up to the ->device_prep_slave_sg change in
    185ecb5f4fd43911c35956d4cc7d94a1da30417f 'dmaengine: add context
    parameter to prep_slave_sg and prep_dma_cyclic' a generic wrapper was
    added in place to guard against the API change, though the fsi driver
    wasn't updated in the process (presumably its dmaengine support hadn't
    been merged yet at the time). This trivially switches over to the new
    wrapper and gets it building again.
    
    Signed-off-by: Paul Mundt <lethal@linux-sh.org>
    Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
------------------------------------------------
