From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Tue, 19 Feb 2008 12:59:45 +0000
Subject: hp6xx touchscreen problems revisited
Message-Id: <20080219135945.05e4f78b.Kristoffer.ericson@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Greetings,

I've done alot of checking to see exactly what is being done when it requested interrupt. In short I've found that its the excess triggering of IRQ3 that causes the freeze and not the request_int as such.

I've reimplemented the delayed_work to get the driver started without freezing at bootup. when catting /dev/input/event1 I get touchscreen input mixed with something else. It outputs data even when touchscreen isn't being used.

IPRC is used to set IRQ0->IRQ3 and I can't say that I got anything working with those IRQ's. Powerbutton seems to have similiar issues (IRQ2). As paul pointed out it seems to be a problem disabling the interrupt. Everything aside from IRQ0->IRQ3 seems to work well.

IRQ3 is set to use level interrupts as it should and I've double checked magnus IRL->IRQ mode code and looks fine.

From manual Concerning IRQ0->IRQ3:

ICR1:
Bit 14 - Interrupt Request Level Detect (IRQLVL): Select wether the IRQ3-IRQ0 pins are used as four independent interrupt pins or as 15-level interrupt pins encoded as IRL3-IRL0.

0 = Used as four independent interrupt request pins IRQ3-IRQ0
1 = used as encoded 15-level interrupt pins as IRL3-IRL0

Magnus sets this using ctrl_outb(ctrl_inb(ICR1) & ~IRQLEVEL, ICR1)); where IRQLEVEL = (1 << 14);

Anyhow, I was hoping the priority setting perhaps could be the cause of the matter? But I assume that setting a lower priority will not act as a filter?

In short:
IRQ0->IRQ3 are set to use level
IRQ0->IRQ3 have correct vector values
IRQ0->IRQ3 doesn't seem to get disabled
IRQ0->IRQ3 is triggerd by other source than designed



/Kristoffer




