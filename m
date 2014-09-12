From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Date: Fri, 12 Sep 2014 00:39:59 +0000
Subject: Re: [PATCH 0/5] arm: shmobile: Lager Add USB and SATA support
Message-Id: <541240DF.6020604@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387370660-20481-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387370660-20481-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Hi Hiep-san,

Thanks for your update.

On 9/11/2014 8:26 PM, カオ　ミン　ヒェップ wrote:
> Hi Khiem-san
> 
>> It seems SATA performance (write speed) is degraded after CPUFreq is enabled
>> (even performance governor is selected).
>>
>> Base on your test result so far:
>> T1 Upstream-v3.16-rc5: 66 MB/s
>> T2 v3.17-rc2 (CPUFreq disabled): ~ 66 MB/s
>> T3 v3.17-rc2 (CPUFreq enable / on-demand governor): 42.61MB/s
>> T4 v3.17-rc2 (CPUFreq disabled / performance governor ): 58.3MB/s
>>
>> The diff between T2 and T4 is ~8 MB/s (or 8% of 66 MB/s).
>> I guess we should try to find the cause of this regression.
>> (I wonder similar phenomenon occurs in backport version ...)

[snip]

> Have some miss in my way of the report yesterday.
> As yesterday results, T2 v3.17-rc2 (CPUFreq disabled) should be (367MB/(5.3s+1.0s)) ->58.2MB/s

[snip]

> And I have just re-confirmed T1 (Upstream-v3.16-rc5),
> On upstream-v3.16-rc5 SATA's writing speed should be 55.6MB/s as below.
> There is no uniformity in the speed calculation of SATA in our test team.
> That 66MB/s only is result of copy to SATA-HDD without umount the device before finish.
> Sorry for the inconvenience.
[snip] 

It makes sense now.
SATA performance does not degrade after CPUFreq is enabled (select performance governor).
>> T1 Upstream-v3.16-rc5 (CPUFreq disabled by default): -> 55.6MB/s
>> T2 v3.17-rc2 (CPUFreq disabled)                    : -> 58.2MB/s
>> T3 v3.17-rc2 (CPUFreq enable / on-demand governor) : 42.61MB/s
>> T4 v3.17-rc2 (CPUFreq disabled / performance governor ): 58.3MB/s

And we should take note SATA performance
when CPUfreq/on-demand governor is selected.
(perhaps, CPUFreq parameters should be tuned)

Thanks for your testing, Hiep-san.

>>>
>>> Thank you!
>>> Cao Minh Hiep.


-- 
Best regards,
KHIEM Nguyen
