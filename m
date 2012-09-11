From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Sep 2012 17:27:54 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: use gpio-keys instead of gpio-keys-polled
Message-Id: <CACRpkdZw8+q3QW6ThSdSoXfyAPoF-H=pCR2eGptTRWcG3eQaGw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1347341165-15573-1-git-send-email-horms@verge.net.au>
 <1347341165-15573-2-git-send-email-horms@verge.net.au>
In-Reply-To: <1347341165-15573-2-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Sep 11, 2012 at 7:26 AM, Simon Horman <horms@verge.net.au> wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> 6e20a0a429bd4dc07d6de16d9c247270e04e4aa0
> (gpio: pcf857x: enable gpio_to_irq() support) supports
> gpio_to_irq() on pcf857x driver.
> Now, we can use gpio-keys driver instead of gpio-keys-polled.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>

Paul, Magnus - Simon wants me to merge this through the
GPIO tree, can I have and ACK from one of the shmobile
maintainers on that?

Yours,
Linus Walleij
