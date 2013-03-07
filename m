From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 07 Mar 2013 08:17:38 +0000
Subject: Re: [PATCH v3 01/29] pinctrl: Declare operation structures as const
Message-Id: <CACRpkdbSZeT+QbWabE7cuUj7=YJcGyHf=J6L-DHdMiGDM2fLug@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1362574370-17889-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1362574370-17889-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 6, 2013 at 1:52 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> The pinconf, pinctrl and pinmux operation structures hold function
> pointers that are never modified. Declare them as const.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

I have this patch in the pinctrl tree nowadays...

Yours,
Linus Walleij
