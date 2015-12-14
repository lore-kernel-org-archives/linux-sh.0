From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 14 Dec 2015 12:02:27 +0000
Subject: Re: [PATCH] i2c: allow building emev2 without slave mode again
Message-Id: <15285750.UWXWiNJ6YU@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <201512102224.cVm7Hcp0%fengguang.wu@intel.com>
 <2157023.1Ftpc9ZciN@wuerfel> <20151213090959.GB1570@katana>
In-Reply-To: <20151213090959.GB1570@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sunday 13 December 2015 10:09:59 Wolfram Sang wrote:
> 
> What about not ifdeffing the inline function and keep the build error
> whenever someone uses it without I2C_SLAVE being selected?

The inline function is only added there for the case that I2C_SLAVE is
disabled, so that would be pointless.

However, what we could do is move the extern declaration outside of
the #ifdef to make it always visible. The if(IS_ENABLED(CONFIG_I2C_SLAVE))
check should then ensure that it never actually gets called, and we
get a link error if some driver gets it wrong.

	Arnd
