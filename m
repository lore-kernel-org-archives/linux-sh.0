From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 17 Jan 2014 06:02:20 +0000
Subject: Re: [PATCH 1/1] ARM: shmobile: Koelsch: pass Ether PHY IRQ
Message-Id: <CANqRtoT1bN4jYHA2+DYRzsVjXXMXRdR_9mqx3sUUXDhJAxe5Ow@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201312200226.38815.sergei.shtylyov@cogentembedded.com>
 <201312200228.00555.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201312200228.00555.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Dec 20, 2013 at 8:28 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Pass Ether's PHY IRQ (which is IRQC's IRQ0) to the 'sh_eth' driver. Set the IRQ
> trigger type to be low-level as per the Micrel PHY driver's setup.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
>  arch/arm/mach-shmobile/board-koelsch.c |    4 ++++
>  1 file changed, 4 insertions(+)

Thanks for this. The code looks good to me. I have now tested this on
my Koelsch board using ifconfig up/down and checking /proc/interrupts.

Acked-by: Magnus Damm <damm@opensource.se>

Cheers,

/ magnus
