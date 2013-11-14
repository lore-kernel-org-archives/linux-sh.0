From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Date: Thu, 14 Nov 2013 00:26:25 +0000
Subject: Re: [PATCH] sh: fix kernel build error
Message-Id: <528418B1.6090507@cn.fujitsu.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1384353504-21886-1-git-send-email-gaowanlong@cn.fujitsu.com> <5283C19D.4050601@cogentembedded.com>
In-Reply-To: <5283C19D.4050601@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-sh@vger.kernel.org, lethal@linux-sh.org
Cc: linux-kernel@vger.kernel.org, fengguang.wu@intel.com, kbuild-all@01.org, Wanlong Gao <gaowanlong@cn.fujitsu.com>

On 11/14/2013 02:14 AM, Sergei Shtylyov wrote:
> Hello.
> 
> On 11/13/2013 05:38 PM, Wanlong Gao wrote:
> 
>>     arch/sh/kernel/kgdb.c: In function 'sleeping_thread_to_gdb_regs':
>>>> arch/sh/kernel/kgdb.c:225:32: error: implicit declaration of function 'task_stack_page' [-Werror=implicit-function-declaration]
>>>> arch/sh/kernel/kgdb.c:242:23: error: dereferencing pointer to incomplete type
>>>> arch/sh/kernel/kgdb.c:243:22: error: dereferencing pointer to incomplete type
>>     arch/sh/kernel/kgdb.c: In function 'singlestep_trap_handler':
>>>> arch/sh/kernel/kgdb.c:310:27: error: 'SIGTRAP' undeclared (first use in this function)
>>     arch/sh/kernel/kgdb.c:310:27: note: each undeclared identifier is reported only once for each function it appears in
>>     cc1: all warnings being treated as errors
> 
>    Strange quoting...

Strange? It's the build error log.

> 
>> This is introduced by commit 16559ae.
> 
>    Please also specify that commit's summary line in parens.

commit 16559ae48c76f1ceb970b9719dea62b77eb5d06b
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Mon Feb 4 15:35:26 2013 -0800

    kgdb: remove #include <linux/serial_8250.h> from kgdb.h
    
    There's no reason kgdb.h itself needs to include the 8250 serial port
    header file.  So push it down to the _very_ limited number of individual
    drivers that need the values in that file, and fix up the places where
    people really wanted serial_core.h and platform_device.h.
    
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


And the line caused this build error is:

diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 4dff0c6..c6e091b 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -13,7 +13,6 @@
 #ifndef _KGDB_H_
 #define _KGDB_H_
 
-#include <linux/serial_8250.h>
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <linux/atomic.h>


Thanks,
Wanlong Gao

> 
>> CC: kbuild-all@01.org
>> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
>> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> 
> WBR, Sergei
> 
> 

