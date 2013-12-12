From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 12 Dec 2013 19:36:32 +0000
Subject: Re: [PATCH 02/10] sh-pfc: Terminate gpios array by -1
Message-Id: <CACRpkda-ZtnBtymG7WKR=SrbZYBK_K8Dm=7Pz5yHo+nvz3LZ7w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1386732390-31724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1386732390-31724-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1386732390-31724-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Dec 11, 2013 at 4:26 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> 0 is a valid GPIO value, use -1 to terminate the gpios array in IRQ
> lists.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Patch applied.

Another solution to the same problem: terminate with
USHRT_MAX and for (k = 0; gpios[k] != USHRT_MAX; k++) {}
but this works too...

Yours,
Linus Walleij
