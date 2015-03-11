From: Simon Horman <horms@verge.net.au>
Date: Wed, 11 Mar 2015 00:04:30 +0000
Subject: Re: Possible regression in next-20150310 due to pinctrl: sh-pfc: r8a7790: Remove non existing GPIO p
Message-Id: <20150311000429.GB6958@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <CACRpkdZ=+sMPhoKVhuHCS6drCWkRbtXnsN99nqD+0ouCjkmrOA@mail.gmail.com>
In-Reply-To: <CACRpkdZ=+sMPhoKVhuHCS6drCWkRbtXnsN99nqD+0ouCjkmrOA@mail.gmail.com>
 <CAMuHMdUOScAQCBG1GM=d8mZj1PDDkZd9Pfxps=-814=rFAyAfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>

Hi Geert, Hi Linus,

On Tue, Mar 10, 2015 at 10:30:54AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Tue, Mar 10, 2015 at 8:55 AM, Simon Horman <horms@verge.net.au> wrote:
> > I have observed what appears to be a regression in next-20150310.  Using
> > the shmobile_defconfig the lager board does not produce console output
> > whatsoever. If I revert bfb6698fad74e7ba2 ("pinctrl: sh-pfc: r8a7790:
> > Remove non existing GPIO pins") then the problem seems to be resolved.
> >
> > Likewise for the koelsh board and 896498d439cec6ff0 ("pinctrl: sh-pfc:
> > r8a7791: Remove non existing GPIO pins").
> 
> That's correct. I reverted these in renesas-drivers-2015-03-09-v4.0-rc3.
> 
> In the mean time, they have been dropped from pinctrl/for-next, as
> requested by Laurent last week.
> 
> Sorry for the issues.

On Tue, Mar 10, 2015 at 03:00:05PM +0100, Linus Walleij wrote:
> On Tue, Mar 10, 2015 at 8:55 AM, Simon Horman <horms@verge.net.au> wrote:
> 
> > I have observed what appears to be a regression in next-20150310.  Using
> > the shmobile_defconfig the lager board does not produce console output
> > whatsoever. If I revert bfb6698fad74e7ba2 ("pinctrl: sh-pfc: r8a7790:
> > Remove non existing GPIO pins") then the problem seems to be resolved.
> 
> I have removed these two patches from the tree since last night.

Thanks, for the quick responses.
I'll be happy to see next working again :)
