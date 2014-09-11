From: =?UTF-8?B?44Kr44Kq44CA44Of44Oz44CA44OS44Kn44OD44OX?=  <cm-hiep@jinso.co.jp>
Date: Thu, 11 Sep 2014 09:35:33 +0000
Subject: Re: [PATCH 0/5] arm: shmobile: Lager Add USB and SATA support
Message-Id: <54116CE5.5090706@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1387370660-20481-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387370660-20481-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Khiem-san

Sorry for late replying!

On 09/10/2014 06:32 PM, Khiem Nguyen wrote:
> Hi Hiep-san, Sakato-san,
>
> Sorry for interruption.
>
> Could you also confirm performance of SATA driver
> in case that CPUFreq uses performance governor ?
>
> If SATA performance is degraded in that case,
> I guess we still need countermeasure.
> (because CPUFreq will definitely be enabled in multi-platform defconfig.)
Here is the results of SATA driver writing speed in case CPUFreq uses 
governor:
Data size: 350MB,
root@linaro-nano:~# uname -a
Linux linaro-nano 3.17.0-rc2 #3 SMP Thu Sep 11 17:15:17 JST 2014 armv7l 
armv7l armv7l GNU/Lix
root@linaro-nano:~# cat 
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
ondemand
root@linaro-nano:~# cat 
/sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
ondemand
root@linaro-nano:~# cat 
/sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
ondemand
root@linaro-nano:~# cat 
/sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
ondemand

# mount -t tmpfs -o size@0m tmpfs /tmp
root@linaro-nano:~# dd if=/dev/urandom of=/tmp/file-350mb bs=1M count50

350+0 records in
350+0 records out
367001600 bytes (367 MB) copied, 88.5655 s, 4.1 MB/s
root@linaro-nano:~# mount /dev/sda1 /mnt/sata/
kjournald starting.  Commit interval 5 seconds
EXT3-fs (sda1): using internal journal
EXT3-fs (sda1): mounted filesystem with ordered data mode
  oot@linaro-nano:~# time cp /tmp/file-350mb /mnt/sata/; time umount 
/mnt/sata/

real    0m6.665s
user    0m0.020s
sys     0m5.690s

real    0m1.243s
user    0m0.010s
sys     0m0.660s

Total: 7.9s
Speed: 46.45MB/s
=========================

root@linaro-nano:~# cat 
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
performance
root@linaro-nano:~# cat 
/sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
performance
root@linaro-nano:~# cat 
/sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
performance
root@linaro-nano:~# cat 
/sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
performance
# time cp /tmp/file-350mb /mnt/sata/; time umount /mnt/sata/

real    0m5.331s
user    0m0.010s
sys     0m5.250s

real    0m1.084s
user    0m0.030s
sys     0m0.500s

Total: 6.3s
Speed: 58.3MB/s


Thank you!
Cao Minh Hiep.
