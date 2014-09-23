From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 23 Sep 2014 15:12:18 +0000
Subject: Re: [PATCH v2] pinctrl: sh-pfc: sh73a0: Remove unnecessary SoC data allocation
Message-Id: <CACRpkdZAm1dnXMHXVV5ZEC3VgdCkS402kS+3b-9Kvh0euOAE5w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1410386155-3896-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1410386155-3896-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Sep 10, 2014 at 11:55 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> The SoC data structure allocated at init time only holds a regulator
> pointer that is only used in the init function. Replace it with a local
> variable and get rid of the SoC data structure allocation altogether.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Patch applied with Geert's ACK.

Yours,
Linus Walleij
