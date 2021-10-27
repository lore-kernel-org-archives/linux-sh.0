Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F3EC433F5
	for <linux-sh@archiver.kernel.org>; Wed, 27 Oct 2021 05:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D944C601FC
	for <linux-sh@archiver.kernel.org>; Wed, 27 Oct 2021 05:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239332AbhJ0FY2 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 27 Oct 2021 01:24:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:12647 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238090AbhJ0FY0 (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Wed, 27 Oct 2021 01:24:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="229935285"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="gz'50?scan'50,208,50";a="229935285"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 22:22:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="gz'50?scan'50,208,50";a="597222262"
Received: from lkp-server01.sh.intel.com (HELO ed9880660fb6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Oct 2021 22:21:58 -0700
Received: from kbuild by ed9880660fb6 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mfbNo-00002C-W6; Wed, 27 Oct 2021 05:21:52 +0000
Date:   Wed, 27 Oct 2021 13:21:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     kbuild-all@lists.01.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH] ftrace/sh: Add arch_ftrace_ops_list_func stub to have
 compressed image still link
Message-ID: <202110271330.lRxAh9CZ-lkp@intel.com>
References: <20211021221627.5d7270de@rorschach.local.home>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20211021221627.5d7270de@rorschach.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Steven,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on hnaz-mm/master linus/master v5.15-rc7 next-20211026]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Steven-Rostedt/ftrace-sh-Add-arch_ftrace_ops_list_func-stub-to-have-compressed-image-still-link/20211022-101651
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2f111a6fd5b5297b4e92f53798ca086f7c7d33a4
config: sh-se7705_defconfig (attached as .config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/67866b4041f96ae1a8bc1b0b0d077c13c59a0e24
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Steven-Rostedt/ftrace-sh-Add-arch_ftrace_ops_list_func-stub-to-have-compressed-image-still-link/20211022-101651
        git checkout 67866b4041f96ae1a8bc1b0b0d077c13c59a0e24
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/sh/boot/compressed/misc.c:109:6: warning: no previous prototype for '__stack_chk_fail' [-Wmissing-prototypes]
     109 | void __stack_chk_fail(void)
         |      ^~~~~~~~~~~~~~~~
   arch/sh/boot/compressed/misc.c:115:6: warning: no previous prototype for 'ftrace_stub' [-Wmissing-prototypes]
     115 | void ftrace_stub(void)
         |      ^~~~~~~~~~~
>> arch/sh/boot/compressed/misc.c:118:6: warning: no previous prototype for 'arch_ftrace_ops_list_func' [-Wmissing-prototypes]
     118 | void arch_ftrace_ops_list_func(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/sh/boot/compressed/misc.c:128:6: warning: no previous prototype for 'decompress_kernel' [-Wmissing-prototypes]
     128 | void decompress_kernel(void)
         |      ^~~~~~~~~~~~~~~~~


vim +/arch_ftrace_ops_list_func +118 arch/sh/boot/compressed/misc.c

   113	
   114	/* Needed because vmlinux.lds.h references this */
   115	void ftrace_stub(void)
   116	{
   117	}
 > 118	void arch_ftrace_ops_list_func(void)
   119	{
   120	}
   121	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--J/dobhs11T7y2rNN
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--J/dobhs11T7y2rNN--
