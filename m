From: Valentine <valentine.barshak@cogentembedded.com>
Date: Wed, 08 Jan 2014 17:00:02 +0000
Subject: Re: [PATCH 0/2] arm: shmobile: Add SATA support for Lager board
Message-Id: <52CD8412.4020908@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387475843-25849-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387475843-25849-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On 01/08/2014 10:40 AM, Magnus Damm wrote:
> On Fri, Dec 20, 2013 at 2:57 AM, Valentine Barshak
> <valentine.barshak@cogentembedded.com> wrote:
>> This adds SATA0/1 clocks to R8A7790 SoC and adds SATA1 to Lager board.
>> SATA0 is not available on Lager since MD23 selection is fixed to USB3.
>>
>> It depends on the following commit available in the libata git tree:
>> https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/commit/?h=3Df=
or-3.14&id=E67adb4e669db834c1f95cbdf99bb4e9ec8455b3
>>
>> Valentine Barshak (2):
>>    arm: shmobile: r8a7790: Add SATA clock
>>    arm: shmobile: lager: Add SATA support
>>
>>   arch/arm/mach-shmobile/board-lager.c   | 17 +++++++++++++++++
>>   arch/arm/mach-shmobile/clock-r8a7790.c | 19 +++++++++++++++++++
>>   2 files changed, 36 insertions(+)
>
> Hi Valentine and Simon,

Magnus, Simon,

>
> Thanks for your patches. I have now successfully tested this Lager
> SATA (pdev) series on my hardware. My SATA HDD can be used on Lager as
> long as the drive is powered on before kernel boot.
>
> Due to delay on my side (my apologies, moved house) there seems to
> have been some bitrot, so I had to manually fix up the patches to make
> them fit on "renesas-devel-v3.13-rc7-20140108". It seems to me that
> you may need to use SH_CLK_MSTP32_STS() now, so I suspect that you
> need to update the patch series to match latest devel tag. Feel free
> to include this:
>
> Acked-by: Magnus Damm <damm@opensource.se>

Thanks.

It's not just the SH_CLK_MSTP32_STS thing. The SATA clock parent has to be =
changed to zs_clk as well.
I've posted the patch for the clocks in a separate series here:
http://marc.info/?l=3Dlinux-sh&m=138919869800851&w=3D2

I have the updated SATA support ready, but it still depends on
https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/commit/?h=3Dfor-=
3.14&id=E67adb4e669db834c1f95cbdf99bb4e9ec8455b3
Do you plan to merge it or do we have to wait for 3.15?

I have done some experiments with CCF as well.
I could post the patches but there are still some dependencies on the other
patches that are still pending.
Do you want me to send them anyway or should we wait until the following pa=
tches are applied:
http://marc.info/?l=3Dlinux-sh&m=138823255807611&w=3D2
http://marc.info/?l=3Dlinux-sh&m=138908294932253&w=3D2
?

>
> Also, the Lager defconfig probably wants to be updated to include SATA su=
pport.
>
> Simon, can you please work with Valentine to merge this series?
>
> Cheers,
>
> / magnus
>

Thanks,
Val.
