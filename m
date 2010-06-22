From: Pekka Enberg <penberg@cs.helsinki.fi>
Date: Tue, 22 Jun 2010 12:41:24 +0000
Subject: Re: [PATCH] kmemleak: config-options: Default buffer size for
Message-Id: <AANLkTim-5W0BJ955VkIUpPCrPbXXZdCEkUVOIGeDZGo0@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <AANLkTimb7rP0rS0OU8nan5uNEhHx_kEYL99ImZ3c8o0D@mail.gmail.com>
	<1277189909-16376-1-git-send-email-sankar.curiosity@gmail.com>
	<4C20702C.1080405@cs.helsinki.fi>
	<1277196403-20836-1-git-send-email-sankar.curiosity@gmail.com>
	<20100622113135.GB20140@linux-sh.org>
	<1277208351.29532.5.camel@e102109-lin.cambridge.arm.com>
	<AANLkTin9ssqksoAvafRdsogmfrDUhShHCF9aCUb7CtCl@mail.gmail.com>
	<1277210104.29532.13.camel@e102109-lin.cambridge.arm.com>
In-Reply-To: <1277210104.29532.13.camel@e102109-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Paul Mundt <lethal@linux-sh.org>, Sankar P <sankar.curiosity@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, lrodriguez@atheros.com, rnagarajan@novell.com, teheo@novell.com, linux-mm@kvack.org, paulmck@linux.vnet.ibm.com, mingo@elte.hu, akpm@linux-foundation.org

On Tue, Jun 22, 2010 at 3:35 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Tue, 2010-06-22 at 13:21 +0100, Pekka Enberg wrote:
>> On Tue, Jun 22, 2010 at 3:05 PM, Catalin Marinas
>> <catalin.marinas@arm.com> wrote:
>> > The defconfig change for this specific platform may be a better option
>> > but I thought defconfigs are to provide a stable (and maybe close to
>> > optimal) configuration without all the debugging features enabled
>> > (especially those slowing things down considerably).
>>
>> The defconfig change was definitely not a clean solution to this
>> problem. Better bake the fix in Kconfig proper even if it means
>> dependency on CONFIG_SH or something.
>
> OK, maybe something like this
>
> =A0 =A0 =A0 =A0default 1000 if SH
> =A0 =A0 =A0 =A0default 400
>
> It seems that kbuild only considers the first encounter of "default".

Sure, I'm fine with that.
