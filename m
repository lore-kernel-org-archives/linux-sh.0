From: Bastian Hecht <hechtb@gmail.com>
Date: Thu, 17 Jul 2014 14:34:39 +0000
Subject: Re: [PATCH 1/5] i2c: Don't start transfers when suspended
Message-Id: <CABYn4swzWs3MvADjJChO701Mao3biFemcSm-3FuB-syt91ng+A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1405165771-8732-1-git-send-email-hechtb@gmail.com>
	<20140717130047.GF2740@katana>
In-Reply-To: <20140717130047.GF2740@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-SH <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Taekgyun Ko <taeggyun.ko-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Hi Wolfram,

thanks for the review.

2014-07-17 15:00 GMT+02:00 Wolfram Sang <wsa@the-dreams.de>:
> Hi Bastian,
>
> On Sat, Jul 12, 2014 at 01:49:27PM +0200, Bastian Hecht wrote:
>> i2c transfer requests come in very uncontrolled, like from interrupt routines.
>> We might be suspended when this happens. To avoid i2c timeouts caused by
>> powered down busses we check for suspension.
>>
>> Signed-off-by: Bastian Hecht <hechtb@gmail.com>
>
> Thanks for doing this! I add linux-pm to CC because of two questions.
>
> And in case of resending, please add at least alkml to the CC list. Or
> better: use 'get_maintainer.pl' as cc-cmd with git-send-email.

Wow these scripts! So useful - thanks for the hint. I looked up the
few people I added manually in the drivers.

>> ---
>> I ended up getting i2c timeouts when suspending and provoking touchscreen
>> IRQs on an Armadillo board with an sh_mobile i2c bus. Instead of copying
>> again the protection mechanism from other bus drivers, we can clean things
>> up and move this into the core.
>
> This could be part of the commit message IMO.

Ok I added it partly. I didn't include the Armadillo specific part,
but added the general
idea to move existing protection schemes to the core.

>>
>> I assume that all bus drivers use kzalloc or equivalent for the
>> struct i2c_adapter. So adap->suspended can't end up uninitialized,
>> right?
>
> Better safe than sorry, I'd say. Please add the initialization.

Ok done.

>> We could consider using this scheme for freeze/restore too.
>
> linux-pm: opinions?
>
>>
>>
>>  drivers/i2c/i2c-core.c | 24 +++++++++++++++++++++++-
>>  include/linux/i2c.h    |  1 +
>>  2 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>> index 7c7f4b8..9fe9581 100644
>> --- a/drivers/i2c/i2c-core.c
>> +++ b/drivers/i2c/i2c-core.c
>> @@ -343,6 +343,13 @@ static int i2c_legacy_resume(struct device *dev)
>>  static int i2c_device_pm_suspend(struct device *dev)
>>  {
>>       const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>> +     struct i2c_adapter *adap = i2c_verify_adapter(dev);
>> +
>> +     if (adap) {
>> +             i2c_lock_adapter(adap);
>> +             adap->suspended = true;
>> +             i2c_unlock_adapter(adap);
>> +     }
>>
>>       if (pm)
>>               return pm_generic_suspend(dev);
>> @@ -353,6 +360,13 @@ static int i2c_device_pm_suspend(struct device *dev)
>>  static int i2c_device_pm_resume(struct device *dev)
>>  {
>>       const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>> +     struct i2c_adapter *adap = i2c_verify_adapter(dev);
>> +
>> +     if (adap) {
>> +             i2c_lock_adapter(adap);
>> +             adap->suspended = false;
>> +             i2c_unlock_adapter(adap);
>> +     }
>>
>>       if (pm)
>>               return pm_generic_resume(dev);
>> @@ -1819,7 +1833,10 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>>                       i2c_lock_adapter(adap);
>>               }
>>
>> -             ret = __i2c_transfer(adap, msgs, num);
>> +             if (adap->suspended)
>> +                     ret = -EIO;
>> +             else
>> +                     ret = __i2c_transfer(adap, msgs, num);
>
> a) Minor: I'd swap the branches and invert the condition, so that the
> more expected code path comes first

Oh yes, well seen. I swapped it.

> b) linux-pm: I wonder about the return code. Currently, some drivers
> return -EIO, some -EBUSY. Do you care which? Since we try to have
> designated fault codes in the i2c subsystem, I wonder about -ESHUTDOWN?
> Or is this too much of hijacking fault codes?

I looked up Documentation/i2c/fault-codes and -EIO currently is the
closest blurrily defined fault code to our problem. I agree that
-ESHUTDOWN would look clearer, but as well agree that I'm unsure about
getting too pedantic. I left -EIO for the v2 series for now. If we opt
for -ESHUTDOWN we shouldn't forget to update the docs too.

I will post v2 now but be on the road for probably a month and can't
participate further here. If needed feel free to completely modify
these patches - it's a very basic patchset anyway.

Cheers,

 Bastian


>>               i2c_unlock_adapter(adap);
>>
>>               return ret;
>> @@ -2577,6 +2594,10 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr, unsigned short flags,
>>
>>       if (adapter->algo->smbus_xfer) {
>>               i2c_lock_adapter(adapter);
>> +             if (adapter->suspended) {
>> +                     res = -EIO;
>> +                     goto unlock;
>> +             }
>>
>>               /* Retry automatically on arbitration loss */
>>               orig_jiffies = jiffies;
>> @@ -2590,6 +2611,7 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr, unsigned short flags,
>>                                      orig_jiffies + adapter->timeout))
>>                               break;
>>               }
>> +unlock:
>>               i2c_unlock_adapter(adapter);
>>
>>               if (res != -EOPNOTSUPP || !adapter->algo->master_xfer)
>> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
>> index b556e0a..af08c75 100644
>> --- a/include/linux/i2c.h
>> +++ b/include/linux/i2c.h
>> @@ -434,6 +434,7 @@ struct i2c_adapter {
>>       int timeout;                    /* in jiffies */
>>       int retries;
>>       struct device dev;              /* the adapter device */
>> +     unsigned int suspended:1;
>>
>>       int nr;
>>       char name[48];
>> --
>> 1.9.1
>>
