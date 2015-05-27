From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 27 May 2015 10:09:41 +0000
Subject: Re: [PATCH 2/2] ARM: multi_v7_defconfig: Make USB support modular
Message-Id: <5189919.ZVDQH3Bp17@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <1432637918-8946-1-git-send-email-geert+renesas@glider.be>
 <11285144.SLyHNBFeg0@avalon>
 <CAMuHMdUFMLGHAYT06s6Twt+1jvhAHyCk2p0xv6xntiVjffvdug@mail.gmail.com>
In-Reply-To: <CAMuHMdUFMLGHAYT06s6Twt+1jvhAHyCk2p0xv6xntiVjffvdug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wednesday 27 May 2015 11:07:15 Geert Uytterhoeven wrote:
> 
> P.S. Strange, USB_NET_DRIVERS is tristate, but setting it to "y" doesn't
>      mean all USB network drivers become builtin, as USB_NET_DRIVERS is never
>      used in a "depends" construct...
> 

The 'if USB_NET_DRIVERS' has the same effect as putting a 'depends on' in
each Kconfig option within.

However, it works the opposite way: if USB_NET_DRIVERS=m, the individual
drivers cannot by 'y', but if USB_NET_DRIVERS=y, they can be 'y', 'm' or 'n'.

	Arnd
