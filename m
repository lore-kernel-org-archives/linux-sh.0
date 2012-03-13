From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 13 Mar 2012 08:56:03 +0000
Subject: Re: [PATCH 4/4] ARM: __io abuse cleanup
Message-Id: <CACRpkdZ_y3=vcj99C34SZ=hKQUmXdqoj0mqKJg2MLGqyUFsB0g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1331500100-31351-1-git-send-email-robherring2@gmail.com>
 <1331500100-31351-5-git-send-email-robherring2@gmail.com>
In-Reply-To: <1331500100-31351-5-git-send-email-robherring2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sun, Mar 11, 2012 at 10:08 PM, Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <rob.herring@calxeda.com>
>
> Several platforms incorrectly use __io() for casting to 'void __iomem *'.
> This converts all of those uses to use the common IOMEM macro.
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Anton Vorontsov <avorontsov@mvista.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: linux-sh@vger.kernel.org

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks Rob!
Linus Walleij
