From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 14 Mar 2013 14:11:36 +0000
Subject: Re: [PATCH 25/25] sh-pfc: Return an error if a pin doesn't support the requested direction
Message-Id: <CACRpkdbSGX4esPepvB1pum98Oy_Ycf2HrwHo372UOqgVKpX=FQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1363214384-3870-26-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1363214384-3870-26-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 13, 2013 at 11:39 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> When setting a pin direction verify that the requested direction is
> supported, and return an error if it isn't.
>
> This requires pin configuration information to be supplied by SoC data.
> The check is a no-op if the information is not supplied.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
