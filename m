Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBD322259F;
	Sat, 18 Apr 2026 19:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776540029; cv=none; b=R3rqGsanm1z8z6x6C3FJLTGzt/oi/hyO8iMLt75i1hwQPiT68GltNj0mGml9cIzK+xCSpU/0ACo74ktZK/h5Xz22BGCHu4Irk4wDO7z3pc5xlWNjzRf8THiMEpT1SRpAGLNjAM3a5IOEzuIdLeD2Cgvj8reKC8BPdhLec/eDBp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776540029; c=relaxed/simple;
	bh=3UvpCr9uXRdhVcZE7A5IjKKyyZk+lERIR3yucfOt5C4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=bqBzpBgOkAvDhzfQp51mfQNUDGExA9N/Aqlc8jIjn9b6Ikl4S9zMVdoxmoxLcZ/tnKHXj0OZadOv6GtGzalaJd4jETG0WgQg97MmjrFAAWOPjjXMAjgHnjNun4YV0QNrh5ps5kGXgxOlucMAdTFer8Oe6SOVm04lWYPctwSxnzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id 20CF73EC1D;
	Sat, 18 Apr 2026 19:20:16 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 18 Apr 2026 21:20:16 +0200
From: Artur Rojek <contact@artur-rojek.eu>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?=
 <nabijaczleweli@nabijaczleweli.xyz>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Paul Mundt
 <lethal@linux-sh.org>, Kristoffer Ericson <Kristoffer.Ericson@gmail.com>,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: hp6xx: unset apm_get_power_status on unload
In-Reply-To: <01d0e84f80124c4ef358bfd1503475856d2aa789.camel@physik.fu-berlin.de>
References: <ydtnrqqjuaz6uifqplujmqwdnpxoe7ma33d5hp4waavekerod2@tarta.nabijaczleweli.xyz>
 <01d0e84f80124c4ef358bfd1503475856d2aa789.camel@physik.fu-berlin.de>
Message-ID: <27022f75480a810a204be567b3607e40@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Cause: dmFkZTFB8FKVWWe+Q+567VoxGAB8FG91lduOXCHwA8H6vAnv3V7SqCHmkcQF+E/Coz000bMFm5h1JzH8RQlsQaudg1/kY1lYP5d/RL1/q1WIvnglCzqeklvjbWNedTNZqwEy11gRclTk+JZrJsc+R8ufOYUCMh0PhEYaI1NqSTMDP0wKCTxvnUCsP6GB7QDGcS3xi68TG1ncdEpdxhfEdaBRBBmGEpaarSVbI2EB5zHmlU9B1qitj1oNamIPI4jAKC2tvWfApJaNGFhd9shrNJ9LXOwKDY/C+01tsql5TYbUrrbmGNZtDT/7cZSZWw3Zg98cUM8mfj1duuHgwzqb2uTETlOGAUIzsH+OiHw3egq+2G7jPTyGw6kXZBNqIbS5siCXc2WDA9uKcy+feAz3VWz03sD2q8hTmbwKrtW8DL0K4uwyzgNbve204ueA/HTTqfuuulKAV1EZUQCN63+AKxdvn5IX5neGNefDmGshlOuBTWGT4NB39HZuxAdGNi0KmmmowwcKFHpn9u+G10U0bISlbkd9wUhKRQuxe/wZ+0IXPuoZ8JE8+xpjuR20+qZhvLaRf4gTrT4Dqcind53gYNeO4Rsb+MrzX3hYQm5OObXaz8ndaZf7YNnxoDf700AcD7QoqyxeF2uGoKE0feLmpncal9kIAYcQ7Yz2ZYv6d0c+FxHBvg
X-GND-State: clean
X-GND-Score: -100

On 2026-04-12 09:30, John Paul Adrian Glaubitz wrote:
> Hi Ahelenia,
> 
> On Fri, 2025-10-17 at 00:05 +0200, Ahelenia Ziemiańska wrote:
>> The API for apm_get_power_status is "call it if it isn't NULL".
>> If the module is unloaded and it's not unset,
>> reading /proc/apm will jump into unloaded kernel memory.
>> 
>> The first commit that added this incompletely refactored
>> the assigned-to variable in __exit,
>> the second deleted it instead of fixing it.
>> 
>> Unset it on unload like drivers/macintosh/apm_emu.c.
>> 
>> Fixes: 0a9b0db19262 ("[APM] SH: Convert to use shared APM emulation.")
>> Fixes: 8c8ee8254767 ("sh: hp6xx: APM build fix and new battery 
>> values.")
>> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
>> ---
>>  arch/sh/boards/mach-hp6xx/hp6xx_apm.c | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/arch/sh/boards/mach-hp6xx/hp6xx_apm.c 
>> b/arch/sh/boards/mach-hp6xx/hp6xx_apm.c
>> index e5c4c7d34139..089eca39c4e6 100644
>> --- a/arch/sh/boards/mach-hp6xx/hp6xx_apm.c
>> +++ b/arch/sh/boards/mach-hp6xx/hp6xx_apm.c
>> @@ -98,6 +98,9 @@ static int __init hp6x0_apm_init(void)
>> 
>>  static void __exit hp6x0_apm_exit(void)
>>  {
>> +	if (apm_get_power_status == hp6x0_apm_get_power_status)
>> +		apm_get_power_status = NULL;
>> +
>>  	free_irq(HP680_BTN_IRQ, 0);
>>  }
>> 
> 
> Let's CC Artur Rojek who has worked on the hp6xx code before and should 
> give his ACK.

This driver can't be built as a module, so this code is never called.
But since we can't get rid of module_exit(apm_exit):

Acked-by: Artur Rojek <contact@artur-rojek.eu>

Cheers,
Artur

> 
> Adrian
