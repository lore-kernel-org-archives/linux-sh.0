From: kbuild test robot <lkp@intel.com>
Date: Tue, 20 Feb 2018 05:22:23 +0000
Subject: Re: [PATCH v9 07/11] media: i2c: ov772x: Support frame interval handling
Message-Id: <201802201353.dQxggfw5%fengguang.wu@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1519059584-30844-8-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1519059584-30844-8-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Jacopo,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linuxtv-media/master]
[also build test WARNING on v4.16-rc2 next-20180220]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jacopo-Mondi/Renesas-Capture-Engine-Unit-CEU-V4L2-driver/20180220-101027
base:   git://linuxtv.org/media_tree.git master
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/media/i2c/ov772x.c:386:3: sparse: symbol 'ov772x_pll' was not declared. Should it be
>> drivers/media/i2c/ov772x.c:535:14: sparse: symbol 'ov772x_frame_intervals' was not declared. Should it be
   drivers/media/i2c/ov772x.c: In function 'ov772x_set_frame_rate.isra.2':
   drivers/media/i2c/ov772x.c:643:7: warning: 'fsize' may be used uninitialized in this function
    pclk = fps COPYING CREDITS Documentation Kbuild Kconfig LICENSES MAINTAINERS Makefile README arch block certs crypto drivers firmware fs include init ipc kernel lib mm net samples scripts security sound tools usr virt fsize;
    ~~~~~^~~~~~~~~~~~~

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
