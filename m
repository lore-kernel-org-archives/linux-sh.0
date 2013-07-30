From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 30 Jul 2013 03:09:23 +0000
Subject: Re: [PATCH 4/6 v2] ARM: shmobile: r8a7778: cleanup registration of i2c
Message-Id: <87k3k8eobj.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <871u6ldb9z.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871u6ldb9z.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi

> > > > Anyway, I exchange my mind
> > > > http://www.spinics.net/lists/linux-sh/msg21582.html
> > > 
> > >     It's apparent that you changed your mind but it's not clear what was the
> > > reasoning behind this.
> > 
> > I and Magnus are explaining about it on cleanup patchset
> 
> Sorry, I don't quite understand your statement above.

Maybe my English issue.

The reason why these cleanup patches don't care about pin settings
but register non-platform data driver is that 
default pin settings are very safety (input direction)
(and the device can't do something if board exchanges pin settings)
(Sergei's USB/I2C patches were same concept ?)
And it can be used for DT feature work.

Then, I understood above and exchanged my mind
that we can register all non-platform driver on SoC code.

This is the back-ground.
Is it enough for you ?
Please let me know if you need more explain/background

Best regards
---
Kuninori Morimoto
