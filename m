From: Yusuke Goda <goda.yusuke@renesas.com>
Date: Mon, 29 Mar 2010 02:29:29 +0000
Subject: Re: [PATCH] sh: Update ecovec_defconfig
Message-Id: <4BB01089.4060509@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4BA9CAF7.1040200@renesas.com>
In-Reply-To: <4BA9CAF7.1040200@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi

Conrad Parker wrote:
> 2010/3/24 Yusuke Goda <goda.yusuke@renesas.com>:
>>  CONFIG_SYSFS_DEPRECATED=y
> 
> perhaps we should set this to n to work with newer udev, eg. with the
> current binaries from debian-sh (ie. if a user takes the existing
> Ecovec BSP and does an apt-get upgrade, which is required in order to
> install things like gstreamer).
> 
> Conrad.
Thank for your indication.
I revise it.

Thanks,
Goda

