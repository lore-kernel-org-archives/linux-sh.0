From: Simon Horman <horms@verge.net.au>
Date: Thu, 14 May 2015 00:49:27 +0000
Subject: Re: [PATCH 1/2] pinctrl: sh-pfc: r8a73a4: Remove obsolete multi-platform check
Message-Id: <20150514004927.GI9781@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1430216072-31412-1-git-send-email-geert+renesas@glider.be>
 <CACRpkdZZ_=x7=2Ae9VPAo6dPvD2D_2MUDwNjCF-jxSp075X1hA@mail.gmail.com>
In-Reply-To: <CACRpkdZZ_=x7=2Ae9VPAo6dPvD2D_2MUDwNjCF-jxSp075X1hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

Hi Linus,

On Tue, May 12, 2015 at 09:26:53AM +0200, Linus Walleij wrote:
> On Tue, Apr 28, 2015 at 12:14 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> 
> > As of commit 9d07d414d4c33d86 ("ARM: shmobile: r8a73a4: ape6evm: Remove
> > legacy platform"), r8a73a4 is only supported in generic ARM
> > multi-platform builds.  Hence CONFIG_ARCH_MULTIPLATFORM is always set,
> > and the check can be removed.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > This depends on Simon's branch r8a73a4-ccf-and-multiplatform-for-v4.1
> 
> I guess I can't merge it to pinctrl then and Simon will take it?
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

I am happy to take this with your ack, however, the above mentioned branch
is present in v4.1-rc1 so if it is practical for you to use that as a base
then you can take the patch yourself.
