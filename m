From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 14 May 2012 21:11:18 +0000
Subject: Re: [PATCH] Removal of last remaining useless system.h includes
Message-Id: <CANqRtoTNuR+FreZd=wAZpK=_6K=+S0miknp1ZurPTgPU1-e5sA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20120514114503.GC10453@n2100.arm.linux.org.uk>
In-Reply-To: <20120514114503.GC10453@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Mon, May 14, 2012 at 8:45 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> mach/system.h is no longer included by anything that matters. =A0Most of
> the includes have already gone, and we're left with just four platforms
> which still have them (for various reasons.) =A0Let's remove them as
> they're now unused.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> This is more a reminder for those maintainers who still haven't responded
> to the work from about five months ago reworking the ARM restart support,
> and who need to do some work to get restart support working again for
> their platforms.

Yes, indeed. It's still on my TODO. Thanks for the reminder!

> =A0arch/arm/mach-shmobile/include/mach/system.h | =A0 11 -----------

Acked-by: Magnus Damm <damm@opensource.se>
