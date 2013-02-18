From: Bastian Hecht <hechtb@gmail.com>
Date: Mon, 18 Feb 2013 16:03:05 +0000
Subject: Re: [PATCH] i2c: sh_mobile: Don't start transfers when suspending
Message-Id: <CABYn4szejurs2gBVOx_+geOxw13r9KvoShfRiM7OOF5wVvDPLA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1360862257-10807-1-git-send-email-hechtb+renesas@gmail.com>
	<CANqRtoSzyAj=pDmtDy1gh=Pxrom644tM07z15b4S=DX4Cby=MQ@mail.gmail.com>
In-Reply-To: <CANqRtoSzyAj=pDmtDy1gh=Pxrom644tM07z15b4S=DX4Cby=MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-i2c@vger.kernel.org

2013/2/15 Magnus Damm <magnus.damm@gmail.com>:
> On Fri, Feb 15, 2013 at 2:17 AM, Bastian Hecht <hechtb@gmail.com> wrote:
>> Currently we provoke i2c timeouts by allowing transfers when
>> suspending. This patch adds awareness to suspending and fixes these
>> issues.
>> The patch follows the style used in i2c-tegra.c - thanks.
>>
>> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
>> ---
>>  drivers/i2c/busses/i2c-sh_mobile.c |   28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
>> index b6e7a83..da28164 100644
>> --- a/drivers/i2c/busses/i2c-sh_mobile.c
>> +++ b/drivers/i2c/busses/i2c-sh_mobile.c
>> @@ -132,6 +132,7 @@ struct sh_mobile_i2c_data {
>>         struct i2c_msg *msg;
>>         int pos;
>>         int sr;
>> +       bool is_suspended;
>>  };
>>
>>  #define IIC_FLAG_HAS_ICIC67    (1 << 0)
>> @@ -511,6 +512,9 @@ static int sh_mobile_i2c_xfer(struct i2c_adapter *adapter,
>>         u_int8_t val;
>>         int i, k, retry_count;
>>
>> +       if (pd->is_suspended)
>> +               return -EBUSY;
>> +
>>         activate_ch(pd);
>>
>>         /* Process all messages */
>> @@ -753,9 +757,33 @@ static int sh_mobile_i2c_runtime_nop(struct device *dev)
>>         return 0;
>>  }
>>
>> +static int sh_mobile_i2c_suspend(struct device *dev)
>> +{
>> +       struct sh_mobile_i2c_data *pd = dev_get_drvdata(dev);
>> +
>> +       i2c_lock_adapter(&pd->adap);
>> +       pd->is_suspended = true;
>> +       i2c_unlock_adapter(&pd->adap);
>> +
>> +       return 0;
>> +}
>> +
>> +static int sh_mobile_i2c_resume(struct device *dev)
>> +{
>> +       struct sh_mobile_i2c_data *pd = dev_get_drvdata(dev);
>> +
>> +       i2c_lock_adapter(&pd->adap);
>> +       pd->is_suspended = false;
>> +       i2c_unlock_adapter(&pd->adap);
>> +
>> +       return 0;
>> +}
>> +
>>  static const struct dev_pm_ops sh_mobile_i2c_dev_pm_ops = {
>>         .runtime_suspend = sh_mobile_i2c_runtime_nop,
>>         .runtime_resume = sh_mobile_i2c_runtime_nop,
>> +       .suspend = sh_mobile_i2c_suspend,
>> +       .resume = sh_mobile_i2c_resume,
>>  };
>>
>>  static const struct of_device_id sh_mobile_i2c_dt_ids[] = {
>> --
>
> Hi Bastian,
>
> Thanks for your work on this. Can you tell us a bit more about where
> and when this fix is needed? I am guessing here, but perhaps it only
> triggers on SMP hardware with CONFIG_SMP enabled?

It appears on the UP r8a7740 on my Armadillo. I didn't succeed in
quickly triggering it on the sh73a0.

> Also, do you know the reason why this isn't handled in the i2c layer
> by default? I ask because your comment mentions that i2c-tegra.c does
> the same thing and I can't see anything in this patch that is actually
> related to our I2C hardware.

Yes, many drivers have a similar scheme and to me it more looked like
all drivers need to take care about this case unrelated to different
hardware. So the question arises if this can't be handled in the core
- or if I get something wrong here. I can have a deeper look later at
this when the issues in "[PATCH] input: st1232: Add IRQF_NO_SUSPEND
flag" become more clear and we can work on it without side effects of
other bugs. So I suppose we should stall this patch until then.

Thanks,

 Bastian


> Thanks,
>
> / magnus
