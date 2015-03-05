From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 05 Mar 2015 09:10:10 +0000
Subject: Re: [PATCH] pinctrl: consumer: use correct retval for placeholder functions
Message-Id: <CACRpkdb2pV9NpQ+_M3h=27dyPRJRQocEvqfy160QYk0b4_ZNoQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418723959-10253-1-git-send-email-wsa@the-dreams.de>
	<CACRpkdZi8+6v02kjZrLt3XGeZMdHtZwDyB_FohNeBtbDC8RpsA@mail.gmail.com>
	<20150209150005.GB8024@katana>
In-Reply-To: <20150209150005.GB8024@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Mon, Feb 9, 2015 at 4:00 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> Hi Linus,
>
>> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> >
>> > These functions are supposed to return an error pointer, not NULL.
>> >
>> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>
>> Worried that some driver may depend on this behaviour, but
>> patch applied anyway, let's deal with it.
>
> I sent a similar patch to Russell for the clk API and he rightfully
> NAKed it. NULL is a valid cookie from clk_get and the whole clk API is
> able to deal with NULL. That ensures that for !HAVE_CLK, clk_get is
> still successful and won't fail driver_probe while the other clk API
> functions don't really do anything. If the gpio API is similar to that,
> we should revert my patch.

OK reverted for fixes, no big deal.

Yours,
Linus Walleij
