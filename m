From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 13 Jan 2015 08:56:42 +0000
Subject: Re: [PATCH] pinctrl: consumer: use correct retval for placeholder functions
Message-Id: <CACRpkdZi8+6v02kjZrLt3XGeZMdHtZwDyB_FohNeBtbDC8RpsA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418723959-10253-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1418723959-10253-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Tue, Dec 16, 2014 at 10:59 AM, Wolfram Sang <wsa@the-dreams.de> wrote:

> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> These functions are supposed to return an error pointer, not NULL.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Worried that some driver may depend on this behaviour, but
patch applied anyway, let's deal with it.

Yours,
Linus Walleij
