From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 14 Mar 2013 08:01:25 +0000
Subject: Re: [PATCH] gpio: Renesas R-Car GPIO driver
Message-Id: <CACRpkdYAynEEz__2MvXQNxbg-HLJVX9kutJeZeYBU6Y4Ka_N4w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130305003219.14792.13300.sendpatchset@w520>
	<CACRpkdbTXoB_zf1axVaM89Uoxa-vXWwgEHv9nWU-jbo_P1pioA@mail.gmail.com>
	<CANqRtoTFP+CycXJ-CNiFxN5iL14GTwpirs0p5HLFmeShAxvDJQ@mail.gmail.com>
In-Reply-To: <CANqRtoTFP+CycXJ-CNiFxN5iL14GTwpirs0p5HLFmeShAxvDJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, horms@verge.net.au, linux-sh@vger.kernel.org

On Thu, Mar 14, 2013 at 5:07 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Thu, Mar 14, 2013 at 2:20 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

>> It is quite common to request IRQ on *both* rising and falling edges,
>> what happens then?
(...)
> I may be wrong, but the switch above does AND with IRQ_TYPE_SENSE_MASK
> which makes me believe that the BOTH case will result in -EINVAL.

Yes you're right, I wasn't quite following. The code only
allows for one distinct flag, fine!

Yours,
Linus Walleij
