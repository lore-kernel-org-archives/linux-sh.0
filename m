From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Tue, 11 Mar 2014 21:55:40 +0000
Subject: Re: [PATCH V7 0/3] clocksource: Consolidate SH and ARM mach-shmobile Kconfig bits
Message-Id: <531F865C.8050407@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1392897287-11614-1-git-send-email-wsa@the-dreams.de> <5305FA60.7040904@linaro.org> <20140307154532.GE28943@katana>
In-Reply-To: <20140307154532.GE28943@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, khilman@linaro.org, arnd@arndb.de, linux-sh@vger.kernel.org, horms@verge.net.au, john.stultz@linaro.org, olof@lixom.net, Magnus Damm <magnus.damm@gmail.com>

On 03/07/2014 04:45 PM, Wolfram Sang wrote:
> Hi Daniel,
>
> On Thu, Feb 20, 2014 at 01:51:44PM +0100, Daniel Lezcano wrote:
>> On 02/20/2014 12:54 PM, Wolfram Sang wrote:
>>> This is V7 of the SH and ARM mach-shmobile clocksource Kconfig consolid=
ation
>>> series. It is a rebased version of V5 on top of timers/core. This serie=
s is not
>>> just an optimization, it also makes it possible to enable the clocksour=
ce for
>>> the r7s72100 platform. I successfully tested the patches on r7s72100 and
>>> r8a7791 platforms. The branch can be found here:
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/rew=
ork-clock-config-for-daniel
>>
>> Thanks Wolfram,
>>
>> applied to my tree for 3.15
>
> I see the patches in your tree, but not in linux-next?

Hi,

I updated my next branch and pushed it in my repo.

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

