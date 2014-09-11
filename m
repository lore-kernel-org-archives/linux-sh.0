From: =?UTF-8?B?44Kr44Kq44CA44Of44Oz44CA44OS44Kn44OD44OX?=  <cm-hiep@jinso.co.jp>
Date: Thu, 11 Sep 2014 11:26:18 +0000
Subject: Re: [PATCH 0/5] arm: shmobile: Lager Add USB and SATA support
Message-Id: <541186DA.1030905@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1387370660-20481-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387370660-20481-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Khiem-san

> It seems SATA performance (write speed) is degraded after CPUFreq is enabled
> (even performance governor is selected).
>
> Base on your test result so far:
> T1 Upstream-v3.16-rc5: 66 MB/s
> T2 v3.17-rc2 (CPUFreq disabled): ~ 66 MB/s
> T3 v3.17-rc2 (CPUFreq enable / on-demand governor): 42.61MB/s
> T4 v3.17-rc2 (CPUFreq disabled / performance governor ): 58.3MB/s
>
> The diff between T2 and T4 is ~8 MB/s (or 8% of 66 MB/s).
> I guess we should try to find the cause of this regression.
> (I wonder similar phenomenon occurs in backport version ...)
>
> (I added Inami-san, CPUFreq developer for his info.)
Have some miss in my way of the report yesterday.
As yesterday results, T2 v3.17-rc2 (CPUFreq disabled) should be 
(367MB/(5.3s+1.0s)) ->58.2MB/s

Here is yesterday's report:
  > As you pointed out, I changed "CONFIG_CPU_FREQ=y" to 
"CONFIG_CPU_FREQ is not set" on uptream-v3.17-rc2 ,
(snip)
 >root@linaro-nano:~# dd if=/dev/urandom of=/tmp/file-350mb bs=1M count50
 >350+0 records in
 >350+0 records out
 >367001600 bytes (367 MB) copied, 90.2065 s, 4.1 MB/s
 >root@linaro-nano:~# time cp /tmp/file-350mb /mnt/file; time umount /mnt/
 >real    0m5.386s
 >user    0m0.010s
 >sys     0m5.200s

 >real    0m1.078s
 >user    0m0.020s
 >sys     0m0.510s

And I have just re-confirmed T1 (Upstream-v3.16-rc5),
On upstream-v3.16-rc5 SATA's writing speed should be 55.6MB/s as below.
There is no uniformity in the speed calculation of SATA in our test team.
That 66MB/s only is result of copy to SATA-HDD without umount the device 
before finish.
Sorry for the inconvenience.

Here is the test results of v3.16-rc5:
root@linaro-nano:~# uname -a
Linux linaro-nano 3.16.0-rc5 #4 SMP Thu Sep 11 20:01:58 JST 2014 armv7l 
armv7l ax
root@linaro-nano:~# mount -t tmpfs -o size@0m tmpfs /tmp
root@linaro-nano:~# dd if=/dev/urandom of=/tmp/file-350mb bs=1M count50
350+0 records in
350+0 records out
367001600 bytes (367 MB) copied, 115.374 s, 3.2 MB/s
root@linaro-nano:~# mount /dev/sda1 /mnt/sata/
kjournald starting.  Commit interval 5 seconds
EXT3-fs (sda1): using internal journal
EXT3-fs (sda1): mounted filesystem with ordered data mode
root@linaro-nano:~# rm /mnt/sata/file-350mb
root@linaro-nano:~# time cp /tmp/file-350mb /mnt/sata/; time umount 
/mnt/sata/

real    0m5.473s
user    0m0.020s
sys     0m5.430s

real    0m1.149s
user    0m0.000s
sys     0m0.510s


Speed: 55.6MB/s


>>
>> Thank you!
>> Cao Minh Hiep.

