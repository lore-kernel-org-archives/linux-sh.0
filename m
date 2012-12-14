From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Dec 2012 15:48:29 +0000
Subject: Re: [PATCH v2 00/77] SH pin control and GPIO rework with OF support
Message-Id: <CACRpkdZW3pHPBme5jMFHu1bNQZ2SPDK5Y4p86TBU3Nn9HNaY4g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1353974596-30033-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1353974596-30033-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 12, 2012 at 2:43 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:

> I will send a v3 with fixes based on your comments. I might omit the DT
> patches this time and send a pull request, as the patch set is getting too big
> for my taste. Even though the result won't be perfect (yet :-)), it's still an
> improvement, and I'll send additional patches on top of that.

Sure the SH pinctrl business is already looking severa magnitudes better
after this so I will certainly pull it in.

I think I'll create a pinctrl-sh branch based off -rc1 after the merge window,
and we'll work on the sh stuff there for a while.

Yours,
Linus Walleij
