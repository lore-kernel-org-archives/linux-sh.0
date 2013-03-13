From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Mar 2013 05:07:46 +0000
Subject: Re: [PATCH v4 00/29] SH pinctrl and pinmux implementation
Message-Id: <CACRpkdYsVKx5fJjmhc+WHkgJoecnfsuxaKL5sHuidZit0-k=LQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1362740170-19073-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1362740170-19073-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Mar 9, 2013 at 5:28 AM, Simon Horman <horms@verge.net.au> wrote:

> I have made a merge of the fixes branch with Linus's for-next branch
> and pushed the result as a new pinmux-base branch.

Hm you shouldn't be basing anything on for-next in the pinctrl tree because
that is rebased all the time. If you need to base off the pinctrl tree, use
the "devel" branch, after handshake with me.

Yours,
Linus Walleij
