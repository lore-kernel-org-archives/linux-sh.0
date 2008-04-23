From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 23 Apr 2008 11:41:56 +0000
Subject: Re: [PATCH] i2c: Renesas Highlander FPGA SMBus support.
Message-Id: <20080423134156.1b368163@hyperion.delvare>
List-Id: <linux-sh.vger.kernel.org>
References: <20080325063236.GA29012@linux-sh.org>
In-Reply-To: <20080325063236.GA29012@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: i2c@lm-sensors.org, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, Magnus Damm <damm@igel.co.jp>, Manuel Lauss <mano@roarinelk.homelinux.net>

On Tue, 25 Mar 2008 15:32:36 +0900, Paul Mundt wrote:
> This adds support for the SMBus adapter found in the various FPGAs on
> the Renesas Highlander platforms. Particularly the R0P7780LC0011RL and
> R0P7785LC0011RL FPGAs.
> 
> Functionality is fairly restricted, in that only byte and block data
> transfers are supported. Normal/fast mode and IRQ/polling are also
> supported. Primarily used for various RTCs and thermal sensors.
> 
> Signed-off-by: Paul Mundt <lethal@linux-sh.org>

No volunteer to review this driver? Manuel or Magnus maybe?

Thanks,
-- 
Jean Delvare
