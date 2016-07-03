From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 03 Jul 2016 11:36:36 +0000
Subject: Re: [PATCH v4 19/22] sh: IO-DATA HDL-U (a,k.a landisk) IRQCHIP driver
Message-Id: <87twg7rm0r.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1467207667-15768-1-git-send-email-ysato@users.sourceforge.jp>
	<1467207667-15768-20-git-send-email-ysato@users.sourceforge.jp>
	<20160701014853.GA29009@rob-hp-laptop>
In-Reply-To: <20160701014853.GA29009@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 01 Jul 2016 10:48:53 +0900,
Rob Herring wrote:
> 
> On Wed, Jun 29, 2016 at 10:41:04PM +0900, Yoshinori Sato wrote:
> > Changes v4
> > - split patches
> > - remove unneeded line
> > - example update
> > 
> > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> > ---
> >  .../interrupt-controller/iodata-landisk.txt        | 31 ++++++++++
> >  drivers/irqchip/Makefile                           |  2 +-
> >  drivers/irqchip/irq-io-landisk.c                   | 72 ++++++++++++++++++++++
> >  3 files changed, 104 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/iodata-landisk.txt
> >  create mode 100644 drivers/irqchip/irq-io-landisk.c
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/iodata-landisk.txt b/Documentation/devicetree/bindings/interrupt-controller/iodata-landisk.txt
> > new file mode 100644
> > index 0000000..cf461dc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/iodata-landisk.txt
> > @@ -0,0 +1,31 @@
> > +DT bindings for the I/O DATA HDL-U interrupt controller
> > +
> > +Required properties:
> > +
> > +  - compatible: has to be "iodata,landisk-intc".
> > +
> > +  - reg: Base address and length of interrupt controller register.
> > +
> > +  - interrupt-controller: Identifies the node as an interrupt controller.
> > +
> > +  - #interrupt-cells: has to be <1>: an interrupt index.
> > +
> > +  - interrupt-map: Interrupt mapping on parent controller.
> 
> interrupt-controller and interrupt-map are supposed to be mutually 
> exclusive, so you should probably drop interrupt-controller.

Yes. This logic is not interrupt controller.
Remove this line.

> Rob
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>
