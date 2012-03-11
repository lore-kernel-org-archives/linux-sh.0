From: Arnd Bergmann <arnd@arndb.de>
Date: Sun, 11 Mar 2012 21:35:10 +0000
Subject: Re: [PATCH 4/4] ARM: __io abuse cleanup
Message-Id: <201203112135.10240.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1331500100-31351-1-git-send-email-robherring2@gmail.com>
 <1331500100-31351-5-git-send-email-robherring2@gmail.com>
In-Reply-To: <1331500100-31351-5-git-send-email-robherring2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sunday 11 March 2012, Rob Herring wrote:
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

Acked-by: Arnd Bergmann <arnd@arndb.de>
