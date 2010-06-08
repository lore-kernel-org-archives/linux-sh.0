From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Date: Tue, 08 Jun 2010 10:06:12 +0000
Subject: Re: [PATCH 1/4] Add the directory mach-sh2007 for SH-2007 board support
Message-Id: <4C0E1614.4030703@dcl.info.waseda.ac.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1275292796-26602-2-git-send-email-mitake@dcl.info.waseda.ac.jp>
In-Reply-To: <1275292796-26602-2-git-send-email-mitake@dcl.info.waseda.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 06/08/10 13:00, Paul Mundt wrote:
 > On Tue, Jun 08, 2010 at 12:06:32AM +0900, Hitoshi Mitake wrote:
 >> On 06/07/10 12:02, Paul Mundt wrote:
 >>> If you read through arch/sh/kernel/cpu/sh4a/setup-sh7780.c you can see
 >>> that everything is already centrally managed by the CPU, so the only
 >>> thing you need to take care of is the IRQ mapping and IRQ mode pins
 >>> setting.
 >>>
 >>> If your board has an FPGA that's chained off of the IRLs then you 
can set
 >>> the controller in to IRL mode, or if you're simply using them as IRQ0-7
 >>> directly and letting the CPU controller take care of the masking, then
 >>> you can simply throw the controller in to IRQ mode.
 >>>
 >>> Simply grep for plat_irq_setup_pins() to see how the CPU/board
 >>> interaction works for this, you'll likely want IRQ_MODE_IRQ for this
 >>> case.
 >>
 >> Ah, I noticed my misunderstanding.
 >>   plat_irq_setup_pins(IRQ_MODE_IRQ);
 >> is enough for me to init ICR.
 >> Thanks for your correcting!
 >>
 >> And I have a question,
 >> Can I set evt2irq(INTEVT) to struct resource.start directly?
 >> # INTEVT is the value like 0x220
 >> If I do so, mv_irq_demux can be NULL because
 >> evt2irq(INTEVT) is equal to the first argument of do_IRQ().
 >>
 >> I don't know the traditional way of SH board support,
 >> and it seems that there is no board takes the way I described above.
 >> So I cannot judge this way is correct or not...
 >
 > There is no real rule for this, on some parts we've opted for open-coding
 > the vector directly simply because it's immediately visible in the data
 > sheet, while for others (especially the SH-2 and SH-2A parts) which don't
 > really have anything to do for evt2irq() we just omit it entirely.
 >
 > The data sheets for the newer CPUs all seem to prefer the event code
 > numbering, so you can see that there are already a few boards that are
 > using evt2irq() in their resource assignments directly, such as sdk7786.

I missed sdk7786, it did the way I'm considering.

 >
 > So of course you can use whatever format you like.
 >

Thanks, I'll setting evt2irq(INTEVT) like sdk7786.
