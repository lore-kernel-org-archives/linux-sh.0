From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Tue, 24 May 2011 03:04:17 +0000
Subject: Re: [PATCH 5/6] fbdev: sh_mobile_meram: Add clock enable/disble hooks
Message-Id: <4DDB2031.8050605@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1305717011-20742-6-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1305717011-20742-6-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,
>> +int sh_mobile_meram_clk_on(struct sh_mobile_meram_info *pdata)
>> +{
>> +       if (!pdata || !pdata->pdev)
>> +               return -EINVAL;
>> +
>> +       dev_dbg(&pdata->pdev->dev, "Enabling sh_mobile_meram clock.");
>> +       pm_runtime_get(&pdata->pdev->dev);
> 
> This should be pm_runtime_get_sync() to force block until the clock is enabled.
Not a problem. I'll update that.
> 
>> diff --git a/include/video/sh_mobile_meram.h b/include/video/sh_mobile_meram.h
>> index af602d6..3605874 100644
>> --- a/include/video/sh_mobile_meram.h
>> +++ b/include/video/sh_mobile_meram.h
>> @@ -63,6 +63,12 @@ struct sh_mobile_meram_ops {
>>                            unsigned long base_addr_c,
>>                            unsigned long *icb_addr_y,
>>                            unsigned long *icb_addr_c);
>> +
>> +       /* enable meram clock */
>> +       int (*meram_clk_on)(struct sh_mobile_meram_info *meram_dev);
>> +
>> +       /* disable meram clock */
>> +       int (*meram_clk_off)(struct sh_mobile_meram_info *meram_dev);
> 
> Hm, we need more than just clock control. Runtime PM is used for both
> clock and power domain control. This means that after pm_runtime_put()
> the power to the MERAM may be turned off. So you probably want to add
> some context save/restore code to make sure the MERAM settings are
> re-initialized after power-up. At this point there are no patches
> upstream for this, but I think we should give it a try after
> 2.6.40-rc1 or rc2 is out.
>
WRT the context save/restore, I'm thinking that unlike the clock
enable/disable, which is tied into the LCDC driver clocks, the context
save/restore should be implemented via the ->runtime_suspend(),
->runtime_restore() callbacks, tied into the power domain (which is this
case is actually the same as LCDC A4LC). If that makes sense I'll submit
a patch to that effect along with the above.

Thanks,
Damian
