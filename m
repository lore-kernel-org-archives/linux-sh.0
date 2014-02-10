From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 10 Feb 2014 18:36:33 +0000
Subject: Re: [PATCH v2] pinctrl: sh-pfc: r8a7790: Add QSPI pin groups
Message-Id: <52F91C31.8060509@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1392037257-20607-1-git-send-email-geert+renesas@linux-m68k.org>
In-Reply-To: <1392037257-20607-1-git-send-email-geert+renesas@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Simon Horman <horms+renesas@verge.net.au>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/02/14 13:00, Geert Uytterhoeven wrote:
> A QSPI function set consists of 3 groups:
>    - qspi_ctrl (2 control wires)
>    - qspi_data2 (2 data wires, for Single/Dual SPI)
>    - qspi_data4 (4 data wires, for Quad SPI)

Hi, do you have a branch with all your SPI/QSPI work on that we
could have a test with please?


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
