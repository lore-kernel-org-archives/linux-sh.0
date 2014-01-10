From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 10 Jan 2014 00:19:38 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790: add audio clocks
Message-Id: <87txdck7sd.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8738l1jzfv.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <8738l1jzfv.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

Thank you for your help

> 1. Add the new style clocks to BockW
> 2. Modify the ADG driver to use the new style clocks
> 3. Remove the old style clocks from BockW
(snip)
> 1. Add support for the new style clocks to the ADG driver
> 2. Replace the old style clocks with the new style clocks in BockW
> 3. Remove support for the old style clocks from the ADG driver
(snip)
> 1. Add the new style clocks to BockW
> 2. Add the new style clocks to Lager
> 3. Modify the ADG driver to use the new style clocks
> 4. Remove the old style clocks from BockW

Thank you for explaining your opinion.
I'm not sure detail, but
ALSA and ARM branch new feature time limit is different.
(ARM branch time limit is until rc5 ?)
 => different merge timing (?)

And maybe these idea will be break BockW sound or
makes confusable code or etc etc etc...

Anyway, I don't want complex patch/branch magic.
And linus/master is rc7 today.
So, I will re-send these patches
after merge window again.
(lager sound support will be late though...)

Thank you

Best regards
---
Kuninori Morimoto
