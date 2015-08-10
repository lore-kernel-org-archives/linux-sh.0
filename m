From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 10 Aug 2015 12:20:06 +0000
Subject: Re: [PATCH v2 0/3] bockw SD pull-ups
Message-Id: <CACRpkdawNRCa0WUACYW=cv=dgybE_oF7OijhwfXn+W00E7HJ7A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1437751317-12235-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1437751317-12235-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jul 24, 2015 at 5:21 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:

> This series implements pull-up configuration in the r8a7778 PFC driver
> and sets the SD0_WP and SD0_CD pull-ups on the Bock-W board correctly,
> replacing the hack that is used in the legacy platforms.
>
> This revision uses bitfields for the pull-up table, reducing its size to 310
> bytes, and demotes undefined pull-ups from a bug to a warning.

I am waiting for Laurent's review on these. Laurent?

Yours,
Linus Walleij
