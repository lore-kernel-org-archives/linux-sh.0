From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Date: Wed, 10 Sep 2014 09:32:31 +0000
Subject: Re: [PATCH 0/5] arm: shmobile: Lager Add USB and SATA support
Message-Id: <54101AAF.90700@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387370660-20481-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387370660-20481-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Hi Hiep-san, Sakato-san,

Sorry for interruption.

Could you also confirm performance of SATA driver
in case that CPUFreq uses performance governor ?

If SATA performance is degraded in that case,
I guess we still need countermeasure. 
(because CPUFreq will definitely be enabled in multi-platform defconfig.)

Thanks.

Best regards,
KHIEM Nguyen

On 9/10/2014 6:16 PM, カオ　ミン　ヒェップ wrote:
> Hi Sakato-san
> 
> On 09/10/2014 04:15 PM, Ryusuke Sakato wrote:
>> Hi Hiep-san,
>>
>>
>> I believe that I should unite the conditions of the performance test of "CONFIG_CPU_FREQ is not set" on Upstream-v3.16-rc5,
>>   and "CONFIG_CPU_FREQ=y" on uptream-v3.17-rc2.
>>
>>
>>> # cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
>>> ondemand
>> In order that you may not be subject to the influence of cpufreq, you should change
>>   "CONFIG_CPU_FREQ is not set", or should perform the following setup.
>>
>> 　echo -n performance > /sys/device/system/cpu/cpu0/cpufreq/scaling_governor
>> 　echo -n performance > /sys/device/system/cpu/cpu1/cpufreq/scaling_governor
>> 　echo -n performance > /sys/device/system/cpu/cpu2/cpufreq/scaling_governor
>> 　echo -n performance > /sys/device/system/cpu/cpu3/cpufreq/scaling_governor
>>
> As you pointed out, I changed "CONFIG_CPU_FREQ=y" to "CONFIG_CPU_FREQ is not set" on uptream-v3.17-rc2 ,
> I saw that the writing speed on v3.17-rc2 and is same writing speed on v3.16-rc5.
> 
> # mount -t tmpfs -o size@0m tmpfs /tmp
> root@linaro-nano:~# dd if=/dev/urandom of=/tmp/file-350mb bs=1M count50
> 350+0 records in
> 350+0 records out
> 367001600 bytes (367 MB) copied, 90.2065 s, 4.1 MB/s
> root@linaro-nano:~# mount /dev/sda1 /mnt/
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs (sda1): using internal journal
> EXT3-fs (sda1): recovery complete
> EXT3-fs (sda1): mounted filesystem with ordered data mode
> root@linaro-nano:~# time cp /tmp/file-350mb /mnt/file; time umount /mnt/
> 
> real    0m5.386s
> user    0m0.010s
> sys     0m5.200s
> 
> real    0m1.078s
> user    0m0.020s
> sys     0m0.510s
> 
> Thanks you for your help!
> 
> 
> 
> Cao Minh Hiep.
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
