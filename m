From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 13 Aug 2009 03:04:18 +0000
Subject: Re: [PATCH] sh: fix i2c init order on Migo-R V2
Message-Id: <20090813030418.GC2701@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090806141536.28146.17373.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090806141536.28146.17373.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 07, 2009 at 12:51:05PM +0900, Magnus Damm wrote:
> Convert the Migo-R board code to register devices at
> arch_initcall() time instead of __initcall(). This fix
> unbreaks migor_ts touch screen driver support.

On Fri, Aug 07, 2009 at 12:52:18PM +0900, Magnus Damm wrote:
> Convert the AP325RXA board code to register devices at
> arch_initcall() time instead of device_initcall(). This
> fix unbreaks pcf8563 RTC driver support.

Applied to 2.6.31 queue, thanks.
