From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Tue, 03 Sep 2013 07:21:36 +0000
Subject: Re: [RFC 06/10] ARM: shmobile: r8a7790: add I2C clock
Message-Id: <CAO3366wKmdwSguHzYWkQfgHch57t-iiW3tM0O9hvL4XsADY50g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1377866264-21110-7-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1377866264-21110-7-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Thanks for the review.

On Fri, Aug 30, 2013 at 7:31 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 08/30/2013 04:37 PM, Ulrich Hecht wrote:
>> --- a/arch/arm/mach-shmobile/clock-r8a7790.c
>> +++ b/arch/arm/mach-shmobile/clock-r8a7790.c
>> @@ -181,6 +182,7 @@ static struct clk div6_clks[DIV6_NR] = {
>>
>>   /* MSTP */
>>   enum {
>> +       MSTP931, MSTP930, MSTP929, MSTP928,
>
>    Please break the line after "MSTP930,".

Could you explain what the system behind this is?

>> @@ -286,6 +293,10 @@ static struct clk_lookup lookups[] = {
>>         CLKDEV_DEV_ID("ee220000.mmcif", &mstp_clks[MSTP305]),
>>         CLKDEV_DEV_ID("sh_mmcif.1", &mstp_clks[MSTP305]),
>>         CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
>> +       CLKDEV_DEV_ID("i2c-rcar.0", &mstp_clks[MSTP931]),
>> +       CLKDEV_DEV_ID("i2c-rcar.1", &mstp_clks[MSTP930]),
>> +       CLKDEV_DEV_ID("i2c-rcar.2", &mstp_clks[MSTP929]),
>> +       CLKDEV_DEV_ID("i2c-rcar.3", &mstp_clks[MSTP928]),
>
>    These should be sorted downwards by MSTPxxx index, no?

OK.

CU
Uli
