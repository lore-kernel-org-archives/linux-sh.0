From: Carmelo Amoroso <carmelo73@gmail.com>
Date: Thu, 27 Dec 2007 17:12:50 +0000
Subject: Cache coherency problem in do_execve while passing arguments
Message-Id: <4773DD12.9000001@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,
a customer of us (STLinux) found a problem running a simple
testcase.
The test simply runs forever in a loop doing modprobe and rmmod
on a dummy kernel module.
After a few loops, it failed because the module arguments passed were corrupted.

In this case, both modprobe and rmmod are symlinks to busybox.
In particular, modprobe (bb), to insert module use the execvp libc
call to execute insmod (it doesn't care if insmod is bb or not).

The problem is due to the fact that into do_execve in kernel 2.6.23.1
the page used for arguments is not flashed from cache in memory
being flush_kernel_dcache_page a NOP.

This is an extract of the do_execve code flow

do_execve flow for argument setup: kernel 2.6.23.1 (STLinux2.3)

do_execve
|---> copy_strings(argc, argv, bprm)
|     |---> page = get_arg_page()
|     |            |---> get_user_pages(&page)
|     |            |---> return page
|     |---> kmapped_page = page
|     |---> flush_kernel_dcache_page(kmapped_page) /* THIS IS CURRENTLY a NOP */
|
|---> search_binary_handler
       |---> load_elf_binary
             |---> setup_arg_page(bprm,...)
                    |---> current->mm->arg_start = bprm->p
                    |---> expand_stack


While in previous kernel the test passed. Indeed, looking at the old code

do_execve flow for argument setup: kernel 2.6.17 (STLinux2.2)

do_execve
|---> copy_strings(argc, argv, bprm)
|---> search_binary_handler
       |---> load_elf_binary
             |---> setup_arg_page(bprm,...)
                    |---> current->mm->arg_start = bprm->p
                    |---> install_arg_page(page)
                          |---> flush_dcache_page(page) /* THIS DO THE TRICK */

As you can see, in the old code flush_dcache_page was explicitly called, while in never kernel
isn't.

The following patch into cacheflush.h solves the problem and the test ran for 2 days without problem

I'm not sure if this fix should be applied to the common header include/asm-sh/cacheflush.h (being valid for all
sh subarch) or to the sh4 specific one include/asm-sh/cpu-sh4/cacheflush.h

+#define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
+static inline void flush_kernel_dcache_page(struct page *page)
+{
+   flush_dcache_page(page);
+}
+

Your comments are welcome

Happy new year
Carmelo
