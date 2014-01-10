From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 10 Jan 2014 00:51:52 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790: add audio clocks
Message-Id: <87siswk6ai.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8738l1jzfv.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <8738l1jzfv.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

Thank you for your help

> 1. Add the old style clocks to Lager
> 2. Add the new style clocks to BockW
> 3. Add the new style clocks to Lager
> 4. Modify the ADG driver to use the new style clocks
> 5. Remove the old style clocks from BockW
> 6. Remove the old style clocks from Lager

Yes it become clean.
But hmm, 
I guess #5, #6 (#4 too ?) are happen after merge anyway ?
If so, this is more clean for me.

1. Add the old style clocks to Lager
2. Modify the ADG driver to use the new style clocks.
   BockW/Lager clocls are fixed in same patch.

Here, #2 will be done on ALSA branch side after merge,
and I guess Simon can use it for topic branch for us ?

# This kind of merge timing something
# is headache for us :P

Best regards
---
Kuninori Morimoto
