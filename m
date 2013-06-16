From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 16 Jun 2013 00:04:45 +0000
Subject: Re: [RFC] pinctrl: generic: Add DT bindings
Message-Id: <CACRpkdZePYMHFMOc0WEy73vqix9uRFyedS66sKcyP_D_Kq+nQg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1370988237-30593-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1795038.rqcr6GWLdP@avalon>
 <CACRpkdYi=ekV8okmz68HZ8Ydv9hTrHnHvQh0HYMs5SfURd9mdA@mail.gmail.com>
 <1422045.RvRkWGR9K7@avalon>
In-Reply-To: <1422045.RvRkWGR9K7@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Sun, Jun 16, 2013 at 1:52 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Linus,
> On Sunday 16 June 2013 01:51:32 Linus Walleij wrote:

>> As dicussed earlier this was designed for systems where
>> you could set the pull-up resistance, like
>>
>> bias-pull-up = <600000>;
>>
>> would give 600kOhm pull up.
>>
>> In most existing systems that is silly, as they can't specify it, so they
>> should be able to do just:
>>
>> bias-pull-up;
>>
>> as that is all they can do. If we have to cut one way, we should cut the
>> former until such a system appears.
>
> I'm fine with bias-pull-up = <1>; vs bias-pull-up;. What bothers me a bit is
> bias-pull-up = <0>; vs bias-disable;.

Oh yeah OK you got a point there for sure.

Setting bias-pull-up = <0>; would be equal to short-circuit
so it does not make any kind of sense.

Let's keep an eye on this.

Yours,
Linus Walleij
