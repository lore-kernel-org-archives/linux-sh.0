From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 02 Oct 2015 08:59:26 +0000
Subject: Re: [RESEND PATCH v2 0/3] bockw SD pull-ups
Message-Id: <CACRpkdZnGEAnHR0atkH1e-eOfcdmEedVS4B=iRRiAjUa9sSbKw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Sep 16, 2015 at 8:58 AM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:

> This series implements pull-up configuration in the r8a7778 PFC driver
> and sets the SD0_WP and SD0_CD pull-ups on the Bock-W board correctly,
> replacing the hack that is used in the legacy platforms.
>
> This has been rebased and is otherwise identical to the previously posted
> v2.  Linus was going to pick up the PFC parts pending a review by Laurent.

Geert is picking stuff up now, as I needed help with SH PFC.

Acked-by for this series, Geert is gateway maintainer.

Yours,
Linus Walleij
