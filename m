From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Tue, 25 Nov 2008 16:37:59 +0000
Subject: Re: [Qemu-devel] Re: Qemu SH4 status #2
Message-Id: <20081125163759.GC3112@game.jcrosoft.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20081110233926.3d8c7fd1.kristoffer.ericson@gmail.com>
	<20081111141335.3c869c26.yoshii.takashi@gmail.com>
	<20081111122700.79906a33.kristoffer.ericson@gmail.com>
	<20081112133313.967c82e2.yoshii.takashi@gmail.com>
	<492A5377.6080802@juno.dti.ne.jp>
In-Reply-To: <492A5377.6080802@juno.dti.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: qemu-devel@nongnu.org
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>, takasi-y@ops.dti.ne.jp, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On 16:10 Mon 24 Nov     , Shin-ichiro KAWASAKI wrote:
> Hi,
>
> Aurelien committed Volodya's MMU patch kindly.  
> http://lists.gnu.org/archive/html/qemu-devel/2008-11/msg01182.html
>
> So some part of the big patch is not necessary now.
> I omitted the part and generated new big patch and attach it to this mail,
> which can be applied to QEMU rev5786.  I hope it helps.
>
>
> yoshii.takashi@gmail.com wrote:
>> Another file "linuxconfig_r2d_qemu.diff" is diff for linux kernel
>>  configuretion. It changes following parameters from r2d+'s defconfig.
>> - Cache -> off (qemu has no cache)
>
> It seems the kernel with cache works fine.  Even though qemu has no cache
> emulation, there is no need to tell it to qemu users, I think.
>
>> - commandline change (for debugging)
>> - 8139too -> 8139cp (qemu's default is c+, still thinking how to switch)
>
>> - SH SPI -> off (sci emulation is not mature enough to handle it)
> I hope my small patch avoid SPI config problem.
>  http://lists.gnu.org/archive/html/qemu-devel/2008-11/msg01229.html
>
> Anyway, your patches on MMIO/ATA and PCI works fine!
> Thank you.
>
> Regards,
> Shin-ichiro KAWASAKI
>
>
>
> yoshii.takashi@gmail.com wrote:


> Index: trunk/target-sh4/helper.c
tested on u-boot
we can detect the RTL

Best Regards,
J.
