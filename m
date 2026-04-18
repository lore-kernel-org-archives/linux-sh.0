Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C91A1A5B84;
	Sat, 18 Apr 2026 20:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776543332; cv=none; b=kcTKyNZ+WYwhszbk/eIGRbTGfxV+Zu9B+oApDqpO3DIrBGSQhKyCc5IJWGy55q6WOkJy23jgpwRvlQ/m0OcUqfDxJCyyvZIYxoVfADaBnsDxl0l+54/2lDR+co/p2Eu8RaadjpmoPhNOR5GIeltGN6Zt1e1KCKFA44s5cLYYzDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776543332; c=relaxed/simple;
	bh=YRhlQFHk/avXKX5iKvlIOzSsSHjWJHdPa6oWegBuAdY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=kaxbVHYCqjdLAGU3YJiQhkQlvCvxb+OmZWVtPNTxVIXWozko0RSCXjvA9ZARzvRfTgVOQ6w2dWPZKADNpqhaUmbP0Fqpuq2lzc63Kfk3oQyJqPe0fNW+d191ZMTqaqEo7sB72+bIUiGDeEQW3AEhgwFhV3sETxbMxbma+UQeYEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6DE053E9A8;
	Sat, 18 Apr 2026 20:15:20 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 18 Apr 2026 22:15:20 +0200
From: Artur Rojek <contact@artur-rojek.eu>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?=
 <nabijaczleweli@nabijaczleweli.xyz>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Paul Mundt
 <lethal@linux-sh.org>, Kristoffer Ericson <Kristoffer.Ericson@gmail.com>,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: hp6xx: unset apm_get_power_status on unload
In-Reply-To: <d87b5a92d172e94774284cd94d341521940eae1a.camel@physik.fu-berlin.de>
References: <ydtnrqqjuaz6uifqplujmqwdnpxoe7ma33d5hp4waavekerod2@tarta.nabijaczleweli.xyz>
 <01d0e84f80124c4ef358bfd1503475856d2aa789.camel@physik.fu-berlin.de>
 <27022f75480a810a204be567b3607e40@artur-rojek.eu>
 <d87b5a92d172e94774284cd94d341521940eae1a.camel@physik.fu-berlin.de>
Message-ID: <5bc1868ed4e745f3b9aa811ffa512aff@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: contact@artur-rojek.eu
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGhmRgoI6oB0dHiGtHCFxcHZFicJkfm+6YMfR2ytb+r7REZtcRHi9IosP86A0Jr/C12A3o7pKlo82LPk4AFmAlF3rreFsT6HuanyKldTdgUOtggjXlTVXXYHJPlozIIjU2BC+gpTm9Q+PxGiX4THAvfmKWBvDw/QmrbwJCQHiECJnkcqsUy7f3VHKsyiBa2NloLECWVBCV/dLH75Hn/p6N6jq+aEjuGYYUPNheEtOl9NMwu7qJh6GC4PgW195USV11Nr5tUdx6J1juCOOF8jLh/dcK/wHMBt0+Jg/eku40/v2b8wMF+9meYc8z9DsQRg0enFi35MyzL3bTv4SeX0bGXoUiEy1saGBUKlF+CJFy7Ljn8k4OjXgGtCHEw4sUolQfYLH+KqriLTUduF4V9LBRRMeoNPn9M3FXNe88jh01ggGXbGsGNPFmzaHY7mfZUd0fjEpjKoWUXabOEyEsYMDztmtm8klHOgQ9eNCnghdGr1lS0kuk/TL1BXYR91MMn6dqhn6cXyYvzXXHFDqfRFQAQZoov/GCwSxUJdsulTmfVsMCO5R45NnjHDDFrDHI+FJ9iI0MRydGmOVgbP+xmMNg0RSTztxXQEaDGlATVmSL5b95sQpVtp2AB3Yoh/yuSojpGnpk2xiCJZe0dlrzKmuXgPbWmSuMSbzA8DVZHunakQA

On 2026-04-18 21:43, John Paul Adrian Glaubitz wrote:
> Hi Artur,
> 
> On Sat, 2026-04-18 at 21:20 +0200, Artur Rojek wrote:
>> On 2026-04-12 09:30, John Paul Adrian Glaubitz wrote:
>> > Hi Ahelenia,
>> >
>> > On Fri, 2025-10-17 at 00:05 +0200, Ahelenia Ziemiańska wrote:
>> > > The API for apm_get_power_status is "call it if it isn't NULL".
>> > > If the module is unloaded and it's not unset,
>> > > reading /proc/apm will jump into unloaded kernel memory.
>> > >
>> > > The first commit that added this incompletely refactored
>> > > the assigned-to variable in __exit,
>> > > the second deleted it instead of fixing it.
>> > >
>> > > Unset it on unload like drivers/macintosh/apm_emu.c.
>> > >
>> > > Fixes: 0a9b0db19262 ("[APM] SH: Convert to use shared APM emulation.")
>> > > Fixes: 8c8ee8254767 ("sh: hp6xx: APM build fix and new battery
>> > > values.")
>> > > Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
>> > > ---
>> > >  arch/sh/boards/mach-hp6xx/hp6xx_apm.c | 3 +++
>> > >  1 file changed, 3 insertions(+)
>> > >
>> > > diff --git a/arch/sh/boards/mach-hp6xx/hp6xx_apm.c
>> > > b/arch/sh/boards/mach-hp6xx/hp6xx_apm.c
>> > > index e5c4c7d34139..089eca39c4e6 100644
>> > > --- a/arch/sh/boards/mach-hp6xx/hp6xx_apm.c
>> > > +++ b/arch/sh/boards/mach-hp6xx/hp6xx_apm.c
>> > > @@ -98,6 +98,9 @@ static int __init hp6x0_apm_init(void)
>> > >
>> > >  static void __exit hp6x0_apm_exit(void)
>> > >  {
>> > > +	if (apm_get_power_status == hp6x0_apm_get_power_status)
>> > > +		apm_get_power_status = NULL;
>> > > +
>> > >  	free_irq(HP680_BTN_IRQ, 0);
>> > >  }
>> > >
>> >
>> > Let's CC Artur Rojek who has worked on the hp6xx code before and should
>> > give his ACK.
>> 
>> This driver can't be built as a module, so this code is never called.
>> But since we can't get rid of module_exit(apm_exit):
> 
> Isn't hp6x0_apm_exit() called when the device is being shutdown even 
> when
> it's not built as a module?

I went by suggestion found in the kernel docs [1], and after a quick
glance over include/linux/module.h:
> /**
>  * module_exit() - driver exit entry point
>  * @x: function to be run when driver is removed
>  *
>  * module_exit() will wrap the driver clean-up code
>  * with cleanup_module() when used with rmmod when
>  * the driver is a module.  If the driver is statically
>  * compiled into the kernel, module_exit() has no effect.
>  * There can only be one per module.
>  */
> #define module_exit(x)	__exitcall(x);

The symbol is certainly not eliminated at compilation time:
> $ readelf -sW vmlinux | grep hp6x0_apm_exit
>  2586: 8d36b000    36 FUNC    LOCAL  DEFAULT   14 hp6x0_apm_exit

However, the section which should hold it does not exit:
> #define __exitcall(fn)						\
> 	static exitcall_t __exitcall_##fn __exit_call = fn
> (...)
> #define __exit_call	__used __section(".exitcall.exit")

> $ readelf -S vmlinux | grep "exitcall\.exit"
> $ echo $?
> 1

I don't know what to make of it, but nevertheless, I am ok with merging
the patch in question.

Cheers,
Artur

[1] 
https://www.kernel.org/doc/html/latest/driver-api/basics.html#c.module_exit

> 
> Adrian
