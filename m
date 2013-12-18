From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Wed, 18 Dec 2013 14:28:45 +0000
Subject: Re: [GIT PULL] Renesas ARM based SoC Clocksource updates for v3.14
Message-Id: <52B1B11D.7080904@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1387000863.git.horms+renesas@verge.net.au>
 <20131218010815.GA2430@verge.net.au>
In-Reply-To: <20131218010815.GA2430@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On 12/18/2013 02:08 AM, Simon Horman wrote:
> On Sat, Dec 14, 2013 at 03:07:31PM +0900, Simon Horman wrote:
>> Hi Daniel,
>>
>> please consider this Renesas ARM based SoC Clocksource update for v3.14.
>>
>> I would also like to request that you make a branch available
>> for me to use as a base for a branch containing SoC changes
>> targeted at v3.14 that depend on this clocksource update.

Hi Simon,

patch applied for 3.14.

The branch is available at:

git://git.linaro.org/people/daniel.lezcano/linux.git=20
clockevents/for-Simon-3.13-rc2

Thanks
   -- Daniel

>>
>> Thanks
>
> Hi Daniel,
>
> sorry to bother you about this, but if you could take a moment
> to look at this pull request I would be most grateful. Its
> rather important for us.
>
>>
>>
>> The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e4=
2ae:
>>
>>    Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
>>
>> are available in the git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/=
renesas-clocksource-for-v3.14
>>
>> for you to fetch changes up to d78e9474459768c9aaf8cfd8bc54957d44771f46:
>>
>>    clocksource: sh_cmt: Add clk_prepare/unprepare support (2013-12-14 12=
:57:36 +0900)
>>
>> ----------------------------------------------------------------
>> Renesas ARM based SoC Clocksource updates for v3.14
>>
>> * Add clk_prepare/unprepare support to sh_cmt
>>
>> ----------------------------------------------------------------
>> Laurent Pinchart (1):
>>        clocksource: sh_cmt: Add clk_prepare/unprepare support
>>
>>   drivers/clocksource/sh_cmt.c | 20 ++++++++++++++++----
>>   1 file changed, 16 insertions(+), 4 deletions(-)
>>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

