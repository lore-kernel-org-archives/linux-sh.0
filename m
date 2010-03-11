From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 11 Mar 2010 10:06:02 +0000
Subject: [PATCH 02/03] i2c: i2c-sh_mobile support for new ICIC bits
Message-Id: <20100311100602.15227.88236.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
References: <20100311100526.15227.50813.sendpatchset@t400s>
In-Reply-To: <20100311100526.15227.50813.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nishimoto.hiroki-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, morimoto.kuninori-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

From: Magnus Damm <damm@opensource.se>

Add support for a new version of the IIC block
found in the SH-Mobile ARM line of processors.

Prototype patch written by Nishimoto-san.
Tested on sh7377 and sh7372.

Signed-off-by: NISHIMOTO Hiroki <nishimoto.hiroki@renesas.com>
Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/i2c/busses/i2c-sh_mobile.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

--- 0026/drivers/i2c/busses/i2c-sh_mobile.c
+++ work/drivers/i2c/busses/i2c-sh_mobile.c	2010-03-11 15:33:09.000000000 +0900
@@ -118,8 +118,10 @@ struct sh_mobile_i2c_data {
 	struct i2c_adapter adap;
 
 	struct clk *clk;
+	u_int8_t icic;
 	u_int8_t iccl;
 	u_int8_t icch;
+	u_int8_t flags;
 
 	spinlock_t lock;
 	wait_queue_head_t wait;
@@ -128,6 +130,8 @@ struct sh_mobile_i2c_data {
 	int sr;
 };
 
+#define IIC_FLAG_HAS_ICIC67	(1 << 0)
+
 #define NORMAL_SPEED		100000 /* FAST_SPEED 400000 */
 
 /* Register offsets */
@@ -154,6 +158,8 @@ struct sh_mobile_i2c_data {
 #define ICSR_WAIT		0x02
 #define ICSR_DTE		0x01
 
+#define ICIC_ICCLB8		0x80
+#define ICIC_ICCHB8		0x40
 #define ICIC_ALE		0x08
 #define ICIC_TACKE		0x04
 #define ICIC_WAITE		0x02
@@ -161,6 +167,9 @@ struct sh_mobile_i2c_data {
 
 static void iic_wr(struct sh_mobile_i2c_data *pd, int offs, unsigned char data)
 {
+	if (offs = ICIC)
+		data |= pd->icic;
+
 	iowrite8(data, pd->reg + offs);
 }
 
@@ -202,6 +211,14 @@ static void activate_ch(struct sh_mobile
 	else
 		pd->iccl = (u_int8_t)(num/denom);
 
+	/* one more bit of ICCL in ICIC */
+	if (pd->flags & IIC_FLAG_HAS_ICIC67) {
+		if ((num/denom) > 0xff)
+			pd->icic |= ICIC_ICCLB8;
+		else
+			pd->icic &= ~ICIC_ICCLB8;
+	}
+
 	/* Calculate the value for icch. From the data sheet:
 	   icch = (p clock / transfer rate) * (H / (L + H)) */
 	num = i2c_clk * 4;
@@ -211,6 +228,14 @@ static void activate_ch(struct sh_mobile
 	else
 		pd->icch = (u_int8_t)(num/denom);
 
+	/* one more bit of ICCH in ICIC */
+	if (pd->flags & IIC_FLAG_HAS_ICIC67) {
+		if ((num/denom) > 0xff)
+			pd->icic |= ICIC_ICCHB8;
+		else
+			pd->icic &= ~ICIC_ICCHB8;
+	}
+
 	/* Enable channel and configure rx ack */
 	iic_set_clr(pd, ICCR, ICCR_ICE, 0);
 
@@ -591,6 +616,12 @@ static int sh_mobile_i2c_probe(struct pl
 		goto err_irq;
 	}
 
+	/* The IIC blocks on SH-Mobile ARM processors
+	 * come with two new bits in ICIC.
+	 */
+	if (size > 0x17)
+		pd->flags |= IIC_FLAG_HAS_ICIC67;
+
 	/* Enable Runtime PM for this device.
 	 *
 	 * Also tell the Runtime PM core to ignore children
