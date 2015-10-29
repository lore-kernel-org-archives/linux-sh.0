From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 29 Oct 2015 08:31:57 +0000
Subject: Re: Salvator-X I2C is working on HI speed on renesas-drivers-2015-10-27-v4.3-rc7
Message-Id: <87si4uyta0.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <877fm61988.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877fm61988.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert, Wolfram

> > If /sys/kernel/debug/clk/clk_summary doesn't show differences (it
> > shouldn't ;-), please try reverting more i2c commits.
> > 
> > git log --oneline
> > renesas-drivers-2015-09-29-v4.3-rc3..renesas-drivers-2015-10-27-v4.3-rc7
> > -- drivers/i2c/busses/i2c-rcar.c | tac
> > 93c659d820ef291f i2c: rcar: rework hw init
> > 59daef909d9ac2ca i2c: rcar: remove unused IOERROR state
> > 738206dec9354817 i2c: rcar: remove spinlock
> > 344beeb23bfc1150 i2c: rcar: refactor setup of a msg
> > 2bc3c5a8631db6d8 i2c: rcar: init new messages in irq
> > 315a1736a2f2d9ad i2c: rcar: don't issue stop when HW does it automatically
> > 2151ba7584b73255 i2c: rcar: check master irqs before slave irqs
> > e5a7effa09e25743 i2c: rcar: revoke START request early
> > 708ca40841266927 i2c: rcar: clean up after refactoring
> > 4f7effddf4549d57 i2c: rcar: enable RuntimePM before registering to the core
> > ecc749660556e02a Merge branch 'i2c/for-current' into i2c/for-next
> > e7db0d34b38d56bb i2c: rcar: add support for r8a7795 (R-Car H3)
> > c6f1891323e6a259 i2c: rcar: Remove obsolete platform data support
> > 6e82f74d11c8c33d Merge branch 'i2c/for-4.4' into i2c/for-next
> 
> Oops, I thought that there is no difference between 09-29 <-> 10-27.
> OK, I will try

Thanks!!

I2C clock can be sane if I reverted this commit (= oops, 1st patch).
Correct speed is 100kHz, broken speed was 1.5MHz

commit 93c659d820ef291f6ca5e628f44b26cfb2226aba
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Thu Sep 3 22:20:05 2015 +0200

    i2c: rcar: rework hw init
    
    We don't need to init HW before every transfer since we know the HW
    state then. HW init at probe time is enough. While here, add setting the
    clock register which belongs to init HW. Also, set MDBS bit since not
    setting it is prohibited according to the manual.
    
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
