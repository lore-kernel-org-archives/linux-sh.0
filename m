From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Sat, 22 Mar 2008 21:28:04 +0000
Subject: Please add ack in intc
Message-Id: <20080322222933.af8a3f29.Kristoffer.Ericson@Gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Magnus could you please add an ack into the intc IRQ code, so far I've been unable to silence the interrupts (IRQ0->IRQ5) by any
other means. This should affect 7705-7709-7729 atleast, so would be worth it.

Ive tried all modes (level / edge) but it only seems to work right when I use edge and ack the interrupt. without it I get endless
interrupts that basicly freeze the hardware.

-- 
Kristoffer Ericson <Kristoffer.Ericson@Gmail.com>
