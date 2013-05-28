From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Tue, 28 May 2013 06:08:41 +0000
Subject: Re: [PATCH 10/12] ARM: shmobile: r8a7740: Add CPUIdle
Message-Id: <51A449E9.5020508@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
 <1369645193-3595-11-git-send-email-horms+renesas@verge.net.au>
 <51A33D83.905@linaro.org> <20130528035446.GJ13532@quad.lixom.net>
In-Reply-To: <20130528035446.GJ13532@quad.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On 05/28/2013 05:54 AM, Olof Johansson wrote:
> On Mon, May 27, 2013 at 01:03:31PM +0200, Daniel Lezcano wrote:
>> On 05/27/2013 10:59 AM, Simon Horman wrote:
>>> From: Bastian Hecht <hechtb@gmail.com>
>>>
>>> We make use of the r8a7740 Suspend To Ram code to plug together a
>>> CPUIdle driver.
>>>
>>> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
>>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> ---
>>
>> Shouldn't it go through Rafael's tree ? Or does the patch contains some
>> dependencies on a code only visible in the ARM tree ?
>=20
> Missing S-o-b from Simon. But this patch clearly builds on the preceding
> one in the series, so merging them independently might not make much
> sense. Getting an ack from Rafael would be nice though.

I was not suggesting to put the driver in the drivers/cpuidle directory
but to merge the driver through Rafael's tree as we decided some weeks
ago [1]. Although having the drivers all over the place does not help to
consolidate the code, so moving them little by little to drivers/cpuidle
makes sense but this is part of another work.

> I was going to say that it should probably go under drivers/cpuidle as
> well, but that just seems silly -- there is practically no code to share
> with any other platform in this small driver, AND there's not really
> any subsystem-internal data exposed. So it might just make more sense
> to keep it under arch/arm instead.
>=20
> Likewise, looking at the kirkwood and calxeda drivers under drivers/cpuid=
le,
> I'm wondering why we thought it was a good idea to merge them there, besi=
des
> getting caught up in the "nothing can live under arch/arm any more" frenz=
y.

Having the drivers in the drivers/cpuidle directory like drivers/cpufreq
will help to keep a consistency with the code and a single entry point
for upstream and review.

Thanks.
  -- Daniel

[1] https://patchwork.kernel.org/patch/2492841/

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for ARM=
 SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

