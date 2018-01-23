From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Tue, 23 Jan 2018 10:28:00 +0000
Subject: Re: [PATCH v4 3/9] v4l: platform: Add Renesas CEU driver
Message-Id: <CAOFm3uGdVkgJ10n=pVKh9h2r7t_UkUS1768tVQLKSaOh8v-buA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1515515131-13760-1-git-send-email-jacopo+renesas@jmondi.org>
 <1515515131-13760-4-git-send-email-jacopo+renesas@jmondi.org>
 <CAOFm3uGxm3bAHPryMV8+MAFy+45-3Ld7RbKqo1saigzPUZ8mqg@mail.gmail.com> <20180112133857.GE24794@w540>
In-Reply-To: <20180112133857.GE24794@w540>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jacopo mondi <jacopo@jmondi.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, geert@glider.be, Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>, Fabio Estevam <festevam@gmail.com>, Sakari Ailus <sakari.ailus@iki.fi>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-renesas-soc@vger.kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>, linux-sh@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Fri, Jan 12, 2018 at 2:38 PM, jacopo mondi <jacopo@jmondi.org> wrote:
> Hi Philippe, Laurent, Geert,
>
> On Fri, Jan 12, 2018 at 11:36:31AM +0100, Philippe Ombredanne wrote:
>> On Tue, Jan 9, 2018 at 5:25 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
>> > Add driver for Renesas Capture Engine Unit (CEU).
>>
>> <snip>
>>
>> > --- /dev/null
>> > +++ b/drivers/media/platform/renesas-ceu.c
>> > @@ -0,0 +1,1648 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>>
>> <snip>
>>
>> > +MODULE_DESCRIPTION("Renesas CEU camera driver");
>> > +MODULE_AUTHOR("Jacopo Mondi <jacopo+renesas@jmondi.org>");
>> > +MODULE_LICENSE("GPL");
>>
>> Jacopo,
>> the MODULE_LICENSE does not match the SPDX tag. Per module.h "GPL"
>> means GPL-2.0 or later ;)
>>
>> It should be instead:
>>
>> > +MODULE_LICENSE("GPL v2");
>>
>> ... to match your
>>
>> > +// SPDX-License-Identifier: GPL-2.0
>
> I will update this in next v5.
> Laurent, Geert: I'll keep SPDX identifier to "GPL-2.0" until kernel
> doc does not get updated.

Thanks. Sorry for the late reply!

-- 
Cordially
Philippe Ombredanne
