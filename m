From: David Brown <davidb@codeaurora.org>
Date: Tue, 09 Aug 2011 17:59:53 +0000
Subject: Re: [PATCH 11/13] ARM: gpio: consolidate trivial gpiolib
Message-Id: <20110809175953.GA22918@huya.qualcomm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
	<E1QqhM1-0003af-U5@rmk-PC.arm.linux.org.uk>
In-Reply-To: <E1QqhM1-0003af-U5@rmk-PC.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Aug 09, 2011 at 09:08:01AM +0100, Russell King - ARM Linux wrote:
> Consolidate 24 trivial gpiolib implementions out of mach/gpio.h
> into asm/gpio.h.  This is basically the include of asm-generic/gpio.h
> and the definition of gpio_get_value, gpio_set_value, and gpio_cansleep
> as described in Documentation/gpio.txt
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-msm/include/mach/gpio.h       |    5 +----

For msm (msm8660):

Tested-by: David Brown <davidb@codeaurora.org>
Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
