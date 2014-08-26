From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 26 Aug 2014 11:50:53 +0000
Subject: Re: [PATCH 3/6] clk: shmobile: Add r8a7794 support
Message-Id: <CANqRtoSXFATbKPkf2DFeXqk0Q2Li3oj+UDV9X5wE2GzSpP1sSw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1406299250-23975-4-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1406299250-23975-4-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Mike,

[CC Simon and Laurent]

On Sat, Jul 26, 2014 at 4:44 AM, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Ulrich Hecht (2014-07-25 07:40:47)
>> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>>
>> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>> Cc: Mike Turquette <mturquette@linaro.org>
>
> Acked-by: Mike Turquette <mturquette@linaro.org>

Thanks!

> Are you taking this through arm-soc?

Good question. Simon, do you have any preference how to merge this?

Perhaps Laurent remembers how we dealt with the earlier SoCs?

Thanks,

/ magnus

>> ---
>>  drivers/clk/shmobile/Makefile | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/clk/shmobile/Makefile b/drivers/clk/shmobile/Makefile
>> index e002923..531d4f6 100644
>> --- a/drivers/clk/shmobile/Makefile
>> +++ b/drivers/clk/shmobile/Makefile
>> @@ -4,6 +4,7 @@ obj-$(CONFIG_ARCH_R8A7740)              += clk-r8a7740.o
>>  obj-$(CONFIG_ARCH_R8A7779)             += clk-r8a7779.o
>>  obj-$(CONFIG_ARCH_R8A7790)             += clk-rcar-gen2.o
>>  obj-$(CONFIG_ARCH_R8A7791)             += clk-rcar-gen2.o
>> +obj-$(CONFIG_ARCH_R8A7794)             += clk-rcar-gen2.o
>>  obj-$(CONFIG_ARCH_SHMOBILE_MULTI)      += clk-div6.o
>>  obj-$(CONFIG_ARCH_SHMOBILE_MULTI)      += clk-mstp.o
>>  # for emply built-in.o
>> --
>> 1.8.4.5
>>
