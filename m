From: Bastian Hecht <hechtb@googlemail.com>
Date: Fri, 06 Jul 2012 16:39:29 +0000
Subject: Re: [PATCH v4 2/8] mtd: sh_flctl: Add support for error IRQ
Message-Id: <CABYn4sxT0J_wWGpgN6EEdxorKyMHu-0=3OWrgHmXwSuq=KJZMw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1336997687-6868-1-git-send-email-hechtb@gmail.com>
 <1336997687-6868-3-git-send-email-hechtb@gmail.com>
 <1341589908.26921.14.camel@shinybook.infradead.org>
In-Reply-To: <1341589908.26921.14.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Woodhouse <dwmw2@infradead.org>
Cc: Bastian Hecht <hechtb@gmail.com>, magnus.damm@gmail.com, linux-mtd@lists.infradead.org, laurent.pinchart@ideasonboard.com, linux-sh@vger.kernel.org

2012/7/6 David Woodhouse <dwmw2@infradead.org>:
> On Mon, 2012-05-14 at 14:14 +0200, Bastian Hecht wrote:
>> +       irq = platform_get_irq(pdev, 0);
>> +       if (irq < 0) {
>
> Is that correct? I know we have sometimes suffered from the insanity of
> assuming that irq 0 is *invalid*, and you're treating it as valid here.
> Did we recover from our insanity?

This is pure ignorance from me - I have no idea what is right. Might
be the lucky shot that is superior to woman's/man's craft.

> --
> dwmw2
