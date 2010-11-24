From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 24 Nov 2010 05:54:51 +0000
Subject: Re: [PATCH] ARM: sh-mobile: ag5evm: scan keyboard support
Message-Id: <20101124055450.GA11705@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4CE67882.9090600@renesas.com>
In-Reply-To: <4CE67882.9090600@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Nov 19, 2010 at 10:15:46PM +0900, Yoshii Takashi wrote:
> This consists of platform device resources/data for the board, and
> simple clvdev entry for MSTP bit for keysc module.
> 
> This support only 49 of 80 key-switches on the board.

On Fri, Nov 19, 2010 at 10:18:13PM +0900, Yoshii Takashi wrote:
> Following patches make sh73a0/ag5evm support i2c-sh_mobile i2c bus controller.
> Currently, no target device support is included.
> CPU part is just a list of resource definitions. And what needed in board
> part is only pinmux setting.
> These(platform/pinmux/clkdev/pm/..) systems are great!

All applied, thanks.
