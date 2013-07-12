From: Simon Horman <horms@verge.net.au>
Date: Fri, 12 Jul 2013 04:00:27 +0000
Subject: Re: [PATCH 02/02] ARM: shmobile: Setup r8a7790 arch timer based on MD pins
Message-Id: <20130712040025.GC26287@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130711162209.933.47610.sendpatchset@w520>
 <20130711162229.933.53924.sendpatchset@w520>
In-Reply-To: <20130711162229.933.53924.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jul 12, 2013 at 01:22:29AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Update the r8a7790 arch timer setup code to configure the
> frequency dynamically at boot time. This means that the arch
> timer driver will be able to detect a timer frequency that
> has been calculated based on the MD pins instead of a fixed
> and potentially incorrect 13 MHz.
> 
> With this patch applied the Linux kernel will correctly
> support the r8a7790 Lager board that uses a 20 Mhz EXTAL.
> The arch timer will operate on 10 MHz and the Linux arch
> timer driver will be correctly configured to use 10 MHz.
> 
> Without this patch the 20 MHz EXTAL will be used to drive
> the arch timer at 10 MHz, but the Linux arch timer driver
> will believe it is counting at 13 Mhz.
> 
> Reported-by: Ulrich Hecht <ulrich.hecht@gmail.com>
> Signed-off-by: Magnus Damm <damm@opensource.se>
> Tested-by: Ulrich Hecht <ulrich.hecht@gmail.com>

Thanks.

I have queued this up for v3.12 in the soc branch and it
is available in renesas-devel-20130712.
