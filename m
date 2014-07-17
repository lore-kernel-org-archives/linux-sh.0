From: Bastian Hecht <hechtb@gmail.com>
Date: Thu, 17 Jul 2014 16:52:35 +0000
Subject: Re: [PATCH v2 5/5] i2c: tegra: Remove suspension check
Message-Id: <CABYn4swY5yRe=eGzCYo0uJtmjn05Ut4oDWupPjmU9bXbuU6+Pw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1405608520-5644-1-git-send-email-hechtb@gmail.com>
 <1405608520-5644-5-git-send-email-hechtb@gmail.com>
 <20140717145958.GA32534@ulmo>
In-Reply-To: <20140717145958.GA32534@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

2014-07-17 16:59 GMT+02:00 Thierry Reding <thierry.reding@gmail.com>:
> On Thu, Jul 17, 2014 at 04:48:40PM +0200, Bastian Hecht wrote:
> [...]
>>  #ifdef CONFIG_PM_SLEEP
>> -static int tegra_i2c_suspend(struct device *dev)
>> -{
>> -     struct tegra_i2c_dev *i2c_dev = dev_get_drvdata(dev);
>> -
>> -     i2c_lock_adapter(&i2c_dev->adapter);
>> -     i2c_dev->is_suspended = true;
>> -     i2c_unlock_adapter(&i2c_dev->adapter);
>> -
>> -     return 0;
>> -}
>> -
>>  static int tegra_i2c_resume(struct device *dev)
>>  {
>>       struct tegra_i2c_dev *i2c_dev = dev_get_drvdata(dev);
>> @@ -842,14 +827,12 @@ static int tegra_i2c_resume(struct device *dev)
>>               return ret;
>>       }
>>
>> -     i2c_dev->is_suspended = false;
>> -
>>       i2c_unlock_adapter(&i2c_dev->adapter);
>>
>>       return 0;
>>  }
>>
>> -static SIMPLE_DEV_PM_OPS(tegra_i2c_pm, tegra_i2c_suspend, tegra_i2c_resume);
>> +static SIMPLE_DEV_PM_OPS(tegra_i2c_pm, tegra_i2c_resume);
>
> Shouldn't this be:
>
>         static SIMPLE_DEV_OPS(tegra_i2c_pm, NULL, tegra_i2c_resume);
>
> instead?

Oh yes thanks. I made the same mistake in [PATCH 3/5] too.

Thanks,

 Bastian



> Thierry
