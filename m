From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date: Mon, 30 May 2016 20:32:07 +0000
Subject: Re: [PATCH v4 00/16] genrtc removal
Message-Id: <20160530203207.GY3451@piout.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1464634684-1248135-1-git-send-email-arnd@arndb.de>
In-Reply-To: <1464634684-1248135-1-git-send-email-arnd-r2nGTMty4D4@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, deller-Mmb7MZpHnFY@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, dalias-8zAoT0mYgF4@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

On 30/05/2016 at 20:57:48 +0200, Arnd Bergmann wrote :
> This is the promised resend of the removal of the genrtc driver and some
> related code, now that we are at a good time to merge this for the coming
> merge window.
> 

Thanks a lot!

I'm applying the series right now so it sits in linux-next for a while
before the next merge window.

I would still happily take any acks, Reviewed-by or Tested-by tags.


> - CONFIG_EFI_RTC is actively used on all six Itanium configurations,
>   though the CONFIG_RTC_DRV_EFI replacement driver is also available
>   there (and has been Itanium-only until ARM64 support for EFI was
>   merged). I suspect it's just a matter of getting an Ack from the
>   Itanium maintainers to remove it and change the defconfigs.
> 

I have that one on my radar. There was an impressive number of separate
drivers for EFI and CMOS...

> - the last remaining legacy RTC driver after those is CONFIG_DS1302,
>   which has a slightly nonstandard ioctl interface and is only used
>   on arch/m32r. I have experimented with this a bit and think it
>   can be converted in a backward-compatible way as well.
> 

That one has been converted to a standard SPI driver in v4.6. Following
some discussion, driving it using gpios will be added. m32r will have to
use one of those two interfaces. It is broken on that architecture for
now but we never got any reply from maintainers.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
