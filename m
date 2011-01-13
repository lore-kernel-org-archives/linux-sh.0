From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 13 Jan 2011 22:44:52 +0000
Subject: Re: [PATCH] ARM: sh-mobile: ag5evm requires GPIOLIB
Message-Id: <20110113224451.GE20418@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4D2EF710.6080103@renesas.com>
In-Reply-To: <4D2EF710.6080103@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 13, 2011 at 09:58:56PM +0900, Takashi Yoshii wrote:
> Because ag5evm board setup code uses gpio functions,
> ARCH_REQUIRE_GPIOLIB should be set in Kconfig.
> Otherwise, the first build with defconfig fails.

On Thu, Jan 13, 2011 at 10:17:15PM +0900, Takashi Yoshii wrote:
> The latest rmobile-latest doesn't run on ag5evm because of a
> small mistake on initialization.
> Though, I don't have any idea to write them smart.
> anyway,
> 
> On sh73a0, GIC cpu_base is 0xf0000100 but 0xf0001000.

Both applied, thanks.
