From: "Francis Moreau" <francis.moro@gmail.com>
Date: Fri, 29 Feb 2008 13:08:21 +0000
Subject: Questions about the interrupt controller
Message-Id: <38b2ab8a0802290508t5e20a0cmfd04e35f0fc533a3@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

I read the sh4 core peripherals manual avalaible on renesas web site
(BTW do you know other 'good' documentations on the sh4 architecture ?)
in order to understand how the 'intc' works.

My question is: are there any examples in the linux kernel which use the
IRL interrupts when *not* configured as 4 independent interrupt requests ?

Do such interrupts need to use make_imask_irq() ?

The documentation says: "Other compatible interrupt controllers can be
cascaded with INTC.". Where can I find some details about that ?

Thanks !
-- 
Francis
