From: Hideo Saito <saito@densan.co.jp>
Date: Tue, 01 Jul 2008 04:24:39 +0000
Subject: decrease of performance on linux-2.6.25.9
Message-Id: <20080701.132439.68562265.saito@densan.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi all,

I have a question as to performance of kernel on linux-2.6.25.9, but this may be off-topic, because the problem is not related to the SH architecture directly.

When I tested Hackbench benchmark test on our platform(SH7780, 400MHz), the performance decreases as follows.

The result on linux-2.6.25.9:
#tcsh> ./hackbench 40 ; time ./hackbench 40 ; time ./hackbench 40
Time: 69.858
Time: 69.810
Time: 70.356

The result on linux-2.6.25.8:
#tcsh> ./hackbench 40 ; time ./hackbench 40 ; time ./hackbench 40
Time: 65.353
Time: 65.622
Time: 65.413

I confirmed that the cause is in the following changes. Isn't this decrease of performance avoided, though it seems that this code is changed in order to handle ZERO_PAGE?

--- a/mm/memory.c
+++ b/mm/memory.c
    pte = *ptep;
    if (!pte_present(pte))
-       goto unlock;
+       goto no_page;
    if ((flags & FOLL_WRITE) && !pte_write(pte))
        goto unlock;
    page = vm_normal_page(vma, address, pte);
    if (unlikely(!page))
-       goto unlock;
+       goto bad_page;

    if (flags & FOLL_GET)
        get_page(page);
