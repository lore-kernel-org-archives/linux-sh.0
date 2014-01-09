From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 09 Jan 2014 08:13:34 +0000
Subject: Re: [PATCH 0/2] arm: shmobile: Add SATA support for Lager board
Message-Id: <CANqRtoQcQ_TZhMrgghurbMcc7MopdMx_5YYFjtOQ_yG7DXyTdw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387475843-25849-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387475843-25849-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Thu, Jan 9, 2014 at 2:00 AM, Valentine
<valentine.barshak@cogentembedded.com> wrote:
> On 01/08/2014 10:40 AM, Magnus Damm wrote:
>>
>> On Fri, Dec 20, 2013 at 2:57 AM, Valentine Barshak
>> <valentine.barshak@cogentembedded.com> wrote:
>>>
>>> This adds SATA0/1 clocks to R8A7790 SoC and adds SATA1 to Lager board.
>>> SATA0 is not available on Lager since MD23 selection is fixed to USB3.
>>>
>>> It depends on the following commit available in the libata git tree:
>>>
>>> https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/commit/?h=3D=
for-3.14&id=E67adb4e669db834c1f95cbdf99bb4e9ec8455b3
>>>
>>> Valentine Barshak (2):
>>>    arm: shmobile: r8a7790: Add SATA clock
>>>    arm: shmobile: lager: Add SATA support
>>>
>>>   arch/arm/mach-shmobile/board-lager.c   | 17 +++++++++++++++++
>>>   arch/arm/mach-shmobile/clock-r8a7790.c | 19 +++++++++++++++++++
>>>   2 files changed, 36 insertions(+)

Hi Valentine,

>> Due to delay on my side (my apologies, moved house) there seems to
>> have been some bitrot, so I had to manually fix up the patches to make
>> them fit on "renesas-devel-v3.13-rc7-20140108". It seems to me that
>> you may need to use SH_CLK_MSTP32_STS() now, so I suspect that you
>> need to update the patch series to match latest devel tag. Feel free
>> to include this:
>>
>> Acked-by: Magnus Damm <damm@opensource.se>
>
>
> Thanks.
>
> It's not just the SH_CLK_MSTP32_STS thing. The SATA clock parent has to be
> changed to zs_clk as well.
> I've posted the patch for the clocks in a separate series here:
> http://marc.info/?l=3Dlinux-sh&m=138919869800851&w=3D2
>
> I have the updated SATA support ready, but it still depends on
> https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/commit/?h=3Dfo=
r-3.14&id=E67adb4e669db834c1f95cbdf99bb4e9ec8455b3
> Do you plan to merge it or do we have to wait for 3.15?

Thanks. I believe Simon will help you getting the necessary bits
merged. Do you need to change the parent clock for r8a7791 as well
perhaps? If so, please post patches so we can merge Koelsch support as
well.

> I have done some experiments with CCF as well.
> I could post the patches but there are still some dependencies on the oth=
er
> patches that are still pending.
> Do you want me to send them anyway or should we wait until the following
> patches are applied:
> http://marc.info/?l=3Dlinux-sh&m=138823255807611&w=3D2

Thanks for submitting fixes. I believe these patches have been acked
by Laurent and picked up by Mike Turquette for upstream merge. So they
seem under control.

> http://marc.info/?l=3Dlinux-sh&m=138908294932253&w=3D2

Regarding this one, can you please verify that it includes the correct
parent clock and then reply with a tested-by for the SATA patches?

Once we got the SATA platform device bits merged then I'd like to
switch focus to SATA DTS, hope that is ok with you.

Thanks for your help!

Cheers,

/ magnus
