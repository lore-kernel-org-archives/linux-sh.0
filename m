From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 10 Mar 2015 14:00:05 +0000
Subject: Re: Possible regression in next-20150310 due to pinctrl: sh-pfc: r8a7790: Remove non existing GPIO p
Message-Id: <CACRpkdZ=+sMPhoKVhuHCS6drCWkRbtXnsN99nqD+0ouCjkmrOA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150310075538.GA20709@verge.net.au>
In-Reply-To: <20150310075538.GA20709@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>

On Tue, Mar 10, 2015 at 8:55 AM, Simon Horman <horms@verge.net.au> wrote:

> I have observed what appears to be a regression in next-20150310.  Using
> the shmobile_defconfig the lager board does not produce console output
> whatsoever. If I revert bfb6698fad74e7ba2 ("pinctrl: sh-pfc: r8a7790:
> Remove non existing GPIO pins") then the problem seems to be resolved.

I have removed these two patches from the tree since last night.

Yours,
Linus Walleij
