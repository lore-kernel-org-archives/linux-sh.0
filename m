From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Date: Mon, 06 Jun 2011 06:24:45 +0000
Subject: Re: [PATCH] Fix build warning of the defconfigs
Message-Id: <1307341485.3104.0.camel@hcegtvedt.norway.atmel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
In-Reply-To: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, 2011-06-02 at 00:29 +0800, Wanlong Gao wrote:
> RTC_CLASS is changed to bool.
> So value 'm' is invalid.
> 
> Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>

<snipp>

>  arch/avr32/configs/atngw100_mrmt_defconfig |    2 +-
>

For the AVR32 related changes.

Acked-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>

<snipp>

-- 
Hans-Christian Egtvedt

