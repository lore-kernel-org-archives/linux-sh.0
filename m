From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Apr 2014 16:25:33 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: r8a7791: Split the DU sync and cde/disp groups
Message-Id: <CACRpkdbxWSxFBOKurNfnXZpnu5-peU9A2G25yzpqu0EsBf2K_A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1396349949-26712-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1396349949-26712-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 1, 2014 at 12:59 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> The DU parallel interface ODDF signal is optional, move it out of the
> HSYNC/VSYNC group into a group of its down. The CDE and DISP signals are
> independent, split them to two different groups.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Patch applied for next.

Yours,
Linus Walleij
