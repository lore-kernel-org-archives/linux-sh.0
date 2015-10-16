From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 16 Oct 2015 14:39:06 +0000
Subject: Re: [PATCH v3 0/3] bockw SD pull-ups
Message-Id: <CACRpkdYFsTPDn=SDte6dRsnyLS71sY95=HkOzHQ6buDKxppzHg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444056955-8836-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1444056955-8836-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Oct 5, 2015 at 4:55 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:

> This series implements pull-up configuration in the r8a7778 PFC driver
> and sets the SD0_WP and SD0_CD pull-ups on the Bock-W board correctly,
> replacing the hack that is used in the legacy platforms.
>
> This version returns from the bias methods without doing any I/O if a pin
> is undefined; thanks to Laurent for pointing this out.  It also includes
> the various Acks.

For all patches:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I'm expecting Geert to accumulate this and send a pull request to me.

Yours,
Linus Walleij
