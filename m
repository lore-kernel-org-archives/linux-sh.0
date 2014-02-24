From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Mon, 24 Feb 2014 22:51:19 +0000
Subject: Re: [PATCH V6 0/3] clocksource: Consolidate SH and ARM mach-shmobile Kconfig bits
Message-Id: <530BCCE7.7060902@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1392670532-21523-1-git-send-email-wsa@the-dreams.de>	<5305C13D.7040907@linaro.org> <CANqRtoT6+6no5fT-6o7jD9k0hF+mMvU4z0ZmUCLksOsJTS0X8Q@mail.gmail.com>
In-Reply-To: <CANqRtoT6+6no5fT-6o7jD9k0hF+mMvU4z0ZmUCLksOsJTS0X8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-kernel <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Arnd Bergmann <arnd@arndb.de>, SH-Linux <linux-sh@vger.kernel.org>, "Simon Horman [Horms]" <horms@verge.net.au>, John Stultz <john.stultz@linaro.org>, Olof Johansson <olof@lixom.net>

On 02/24/2014 11:48 PM, Magnus Damm wrote:
> On Thu, Feb 20, 2014 at 5:47 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> On 02/17/2014 09:55 PM, Wolfram Sang wrote:
>>>
>>> This is V6 of the SH and ARM mach-shmobile clocksource Kconfig
>>> consolidation
>>> series. It is a rebased version of V5 (which did not get any comments) =
on
>>> top
>>> of the latest renesas/devel tag. This series is not just an optimizatio=
n,
>>> it
>>> also makes it possible to enable the clocksource for the r7s72100
>>> platform.
>>> Without it, the current kernel is hardly usable for these devices at the
>>> moment
>>> (broken userland). So, it would be nice to have the series in 3.15. For
>>> more
>>> details, I quote the cover-letter from Magnus for V5 at the end. I
>>> successfully
>>> tested the patches on r7s72100 and r8a7791 platforms. The branch can be
>>> found
>>> here:
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
>>> renesas/rework-clock-configs
>>
>>
>> Hi Wolfram,
>>
>> actually I was waiting for Magnus to send me the patchset respinned agai=
nst
>> timers/core [1].
>
> Hi Daniel,
>
> Thanks for your help and my apologies for this confusion. I moved
> house during December and a couple of things got dropped including
> this one.

No problem, that happens ;)

>> So if you mind, please refresh the series against timers/core as this se=
ries
>> does not apply for my tree.
>
> I noticed that Wolfram picked it up, thanks to both of you - I
> appreciate your help!

Thanks to Wolfram.

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

