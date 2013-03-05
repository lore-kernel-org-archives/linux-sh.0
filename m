From: Bastian Hecht <hechtb@gmail.com>
Date: Tue, 05 Mar 2013 13:40:15 +0000
Subject: Power management test code samples
Message-Id: <CABYn4sypQ2VzigxmRwiqWnDim1zPiAcb_NrYbBxnRt0FMCq0vA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

hereby I ask officially if there is some test code available regarding
the power management of the SoCs r8a7740 and sh73a0.

I'm interested in the exact handling of the different caches (L1, L2,
TLB) and shutdown/wakeup procedures. Sample code would help a lot so I
can compare what the v7_cpu_suspend code already does and what is
needed in the SoC-specific code.

Thanks,

 Bastian
