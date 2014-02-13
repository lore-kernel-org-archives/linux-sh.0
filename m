From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 13 Feb 2014 00:27:50 +0000
Subject: Re: [PATCH 2/2] ARM: lager: add i2c1, i2c2 pins
Message-Id: <87k3czdfgc.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1392224674-5328-2-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1392224674-5328-2-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Ben

> Add pinctrl definitions for i2c1 and i2c2 busses on the Lager board
> to ensure these are setup correctly at initialisation time. The i2c0
> and i2c3 busses are connected to single function pins.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---

Thank you for your patches,
but, just "i2c support" patch (= [1/2] + [2/2]) is understandable / readable :)

And, about Subject

- ARM: lager: xxx
+ ARM: shmobile: lager: xxx

Best regards
---
Kuninori Morimoto
