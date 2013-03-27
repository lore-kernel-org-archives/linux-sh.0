From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 27 Mar 2013 14:30:49 +0000
Subject: Re: [PATCH/RFC 10/12] ARM: shmobile: r8a7779: Remove all GPIOs
Message-Id: <CANqRtoS4shCqaCBnHcnYs=SRtiyzkVvu+CwCj31KG87GeyLkXw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1362941928-18115-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1362941928-18115-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Mon, Mar 11, 2013 at 3:58 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> All code use the GPIO numbers directly.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---

Thanks for your work on this. I am late to the party as usual.

I am in general happy with the changes that you are making to convert
from old function and I/O GPIOs to using PINCTRL and GPIOS separately.
However, I have one comment related to this patch. I think you should
keep these patches as is, but I hope you can make an incremental fix,
please see my proposal below.

[snip]

> -       GPIO_GP_3_0, GPIO_GP_3_1, GPIO_GP_3_2, GPIO_GP_3_3,
> -       GPIO_GP_3_4, GPIO_GP_3_5, GPIO_GP_3_6, GPIO_GP_3_7,
> -       GPIO_GP_3_8, GPIO_GP_3_9, GPIO_GP_3_10, GPIO_GP_3_11,
> -       GPIO_GP_3_12, GPIO_GP_3_13, GPIO_GP_3_14, GPIO_GP_3_15,
> -       GPIO_GP_3_16, GPIO_GP_3_17, GPIO_GP_3_18, GPIO_GP_3_19,
> -       GPIO_GP_3_20, GPIO_GP_3_21, GPIO_GP_3_22, GPIO_GP_3_23,
> -       GPIO_GP_3_24, GPIO_GP_3_25, GPIO_GP_3_26, GPIO_GP_3_27,
> -       GPIO_GP_3_28, GPIO_GP_3_29, GPIO_GP_3_30, GPIO_GP_3_31,

In the data sheet and schematics it is possible to look up pins and
signals using names like GPIO_GP_n_x. Those names in the data sheet
and in the schematics match the enums in the header above. This makes
it easy to match the schematics with the code, something that is
important for anyone actually using our code.

However, while moving towards PINCTRL it seems that we're having a
regression in usefulness. Now we use pin numbers. On some SoCs that
maps well, but on others like the ones using GPIO_GP_n_x this turns
the board code into an unreadable mess.

For instance, if you find a GPIO in the board code with the value 123
and you want to match that to the data sheet, these days we have to
convert it manually. Perhaps to GPIO_3_29. And people have to convert
it the other way too when they are implementing the board code. These
kind of things are error prone. =)

Would it be possible to introduce a macro like GPIO_GP(n, m) that on
selected SoCs allows us to use the same style as before?

I suppose the same style could be used with the DT preprocessor. It's
funny, DT gains a preprocessor and we stop using it in C...

Thanks,

/ magnus
