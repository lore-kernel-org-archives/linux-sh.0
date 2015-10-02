From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 02 Oct 2015 09:26:23 +0000
Subject: Re: [git pull] pinctrl: sh-pfc: Updates for v4.4
Message-Id: <CACRpkdbDE8M=ri2NYjJc7s-MzHyv5ZHobNVk7izH2XYvWCVTeA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1443774347-383-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1443774347-383-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Fri, Oct 2, 2015 at 1:25 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

>         Hi Linus,
>
> The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:
>
>   Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git sh-pfc-for-v4.4
>
> for you to fetch changes up to 819fd4bfcc84805c48291de511c917596e911ffa:
>
>   pinctrl: sh-pfc: r8a7795: add EtherAVB support (2015-10-02 09:54:41 +0200)
>
> Summary:
>   - Two fixes for incorrect pinmux data,
>   - Initial r8a7795 (R-Car H3) support (incl. serial, I2C, audio,
>     Ethernet),
>   - Various cleanups.
>
> Most have been acked by Laurent and/or by you.

Awesome, pulled into the pinctrl "devel" branch, will push to the kernel zeroday
builder soon.

If you have more stuff and fixes coming just send more pull requests
based on this
or my "devel" branch.

Yours,
Linus Walleij
