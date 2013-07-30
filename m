From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Tue, 30 Jul 2013 17:57:27 +0000
Subject: [RFC 5/5] arm: boot: kzm9g: raise core voltage
Message-Id: <1375207047-8655-6-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This is part of a fix from upstream u-boot that raises the core voltage
to correct SDRAM failures on certain kzm9g boards. I have wedged it in
here because by this time we have a stack set up, and I won't have to
translate the C code to assembler. At any rate it doesn't do anything
for the stability of the RAM on my board...
---
 arch/arm/boot/compressed/misc.c |  204 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 204 insertions(+)

diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 0c54a3d..40dcd44 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -204,6 +204,204 @@ static void morse_bits(unsigned int bits)
 	led_set(3, 0);
 }
 
+#define CONFIG_SH_I2C_8BIT
+
+/* Every register is 32bit aligned, but only 8bits in size */
+#define ureg(name) u8 name; u8 __pad_##name##0; u16 __pad_##name##1;
+struct sh_i2c {
+	ureg(icdr);
+	ureg(iccr);
+	ureg(icsr);
+	ureg(icic);
+	ureg(iccl);
+	ureg(icch);
+};
+#undef ureg
+
+struct sh_i2c *base;
+/* ICCR */
+#define SH_I2C_ICCR_ICE		(1 << 7)
+#define SH_I2C_ICCR_RACK	(1 << 6)
+#define SH_I2C_ICCR_RTS		(1 << 4)
+#define SH_I2C_ICCR_BUSY	(1 << 2)
+#define SH_I2C_ICCR_SCP		(1 << 0)
+
+/* ICSR / ICIC */
+#define SH_IC_BUSY	(1 << 4)
+#define SH_IC_TACK	(1 << 2)
+#define SH_IC_WAIT	(1 << 1)
+#define SH_IC_DTE	(1 << 0)
+
+#ifdef CONFIG_SH_I2C_8BIT
+/* store 8th bit of iccl and icch in ICIC register */
+#define SH_I2C_ICIC_ICCLB8	(1 << 7)
+#define SH_I2C_ICIC_ICCHB8	(1 << 6)
+#endif
+
+u16 iccl, icch;
+#define CONFIG_SH_I2C_BASE0     (0xE6820000)
+#define CONFIG_SH_I2C_CLOCK     (104000000) /* 104 MHz */
+#define CONFIG_SH_I2C_DATA_HIGH (4)
+#define CONFIG_SH_I2C_DATA_LOW  (5)
+
+#define CONFIG_SYS_I2C_SPEED    (100000) /* 100 kHz */
+#define CONFIG_SYS_I2C_SLAVE    (0x7F)
+
+#define IRQ_WAIT 1000
+
+#define clrbits_8(addr, val) *((u8 *)(addr)) &= ~(val)
+#define setbits_8(addr, val) *((u8 *)(addr)) |= (val)
+#define writeb(val, addr) *((u8 *)(addr)) = (val)
+#define readb(addr) (*((u8 *)(addr)))
+
+static void udelay(int n)
+{
+	n *= 100;
+	int i = 0;
+	for (i = 0; i < n; i++) {
+		asm("nop");
+	}
+}
+
+
+static void irq_dte(struct sh_i2c *base)
+{
+	int i;
+
+	for (i = 0 ; i < IRQ_WAIT ; i++) {
+		if (SH_IC_DTE & readb(&base->icsr))
+			break;
+		udelay(10);
+	}
+}
+
+static int irq_dte_with_tack(struct sh_i2c *base)
+{
+	int i;
+
+	for (i = 0 ; i < IRQ_WAIT ; i++) {
+		if (SH_IC_DTE & readb(&base->icsr))
+			break;
+		if (SH_IC_TACK & readb(&base->icsr))
+			return -1;
+		udelay(10);
+	}
+	return 0;
+}
+
+static void irq_busy(struct sh_i2c *base)
+{
+	int i;
+
+	for (i = 0 ; i < IRQ_WAIT ; i++) {
+		if (!(SH_IC_BUSY & readb(&base->icsr)))
+			break;
+		udelay(10);
+	}
+}
+
+static void i2c_finish(struct sh_i2c *base)
+{
+	writeb(0, &base->icsr);
+	clrbits_8(&base->iccr, SH_I2C_ICCR_ICE);
+}
+
+void i2c_init(int speed, int slaveaddr)
+{
+	int num, denom, tmp;
+
+#ifdef CONFIG_I2C_MULTI_BUS
+	current_bus = 0;
+#endif
+	base = (struct sh_i2c *)CONFIG_SH_I2C_BASE0;
+
+	/*
+	 * Calculate the value for iccl. From the data sheet:
+	 * iccl = (p-clock / transfer-rate) * (L / (L + H))
+	 * where L and H are the SCL low and high ratio.
+	 */
+	num = CONFIG_SH_I2C_CLOCK * CONFIG_SH_I2C_DATA_LOW;
+	denom = speed * (CONFIG_SH_I2C_DATA_HIGH + CONFIG_SH_I2C_DATA_LOW);
+	tmp = num * 10 / denom;
+	if (tmp % 10 >= 5)
+		iccl = (u16)((num/denom) + 1);
+	else
+		iccl = (u16)(num/denom);
+
+	/* Calculate the value for icch. From the data sheet:
+	   icch = (p clock / transfer rate) * (H / (L + H)) */
+	num = CONFIG_SH_I2C_CLOCK * CONFIG_SH_I2C_DATA_HIGH;
+	tmp = num * 10 / denom;
+	if (tmp % 10 >= 5)
+		icch = (u16)((num/denom) + 1);
+	else
+		icch = (u16)(num/denom);
+}
+
+
+static int i2c_set_addr(struct sh_i2c *base, u8 id, u8 reg, int stop)
+{
+	u8 icic = SH_IC_TACK;
+
+	clrbits_8(&base->iccr, SH_I2C_ICCR_ICE);
+	setbits_8(&base->iccr, SH_I2C_ICCR_ICE);
+
+	writeb(iccl & 0xff, &base->iccl);
+	writeb(icch & 0xff, &base->icch);
+#ifdef CONFIG_SH_I2C_8BIT
+	if (iccl > 0xff)
+		icic |= SH_I2C_ICIC_ICCLB8;
+	if (icch > 0xff)
+		icic |= SH_I2C_ICIC_ICCHB8;
+#endif
+	writeb(icic, &base->icic);
+
+	writeb((SH_I2C_ICCR_ICE|SH_I2C_ICCR_RTS|SH_I2C_ICCR_BUSY), &base->iccr);
+	irq_dte(base);
+
+	clrbits_8(&base->icsr, SH_IC_TACK);
+	writeb(id << 1, &base->icdr);
+	if (irq_dte_with_tack(base) != 0)
+		return -1;
+
+	writeb(reg, &base->icdr);
+	if (stop)
+		writeb((SH_I2C_ICCR_ICE|SH_I2C_ICCR_RTS), &base->iccr);
+
+	if (irq_dte_with_tack(base) != 0)
+		return -1;
+	return 0;
+}
+
+static int i2c_raw_write(struct sh_i2c *base, u8 id, u8 reg, u8 val)
+{
+	int ret = -1;
+	if (i2c_set_addr(base, id, reg, 0) != 0)
+		goto exit0;
+	udelay(10);
+
+	writeb(val, &base->icdr);
+	if (irq_dte_with_tack(base) != 0)
+		goto exit0;
+
+	writeb((SH_I2C_ICCR_ICE | SH_I2C_ICCR_RTS), &base->iccr);
+	if (irq_dte_with_tack(base) != 0)
+		goto exit0;
+	irq_busy(base);
+	ret = 0;
+exit0:
+	i2c_finish(base);
+	return ret;
+}
+
+int i2c_write(u8 chip, u32 addr, int alen, u8 *buffer, int len)
+{
+	int i = 0;
+	for (i = 0; i < len ; i++)
+		if (i2c_raw_write(base, chip, addr + i, buffer[i]) != 0)
+			return -1;
+	return 0;
+}
 
 void
 decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
@@ -211,6 +409,7 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 		int arch_id)
 {
 	int ret;
+	u8 data;
 
 	output_data		= (unsigned char *)output_start;
 	free_mem_ptr		= free_mem_ptr_p;
@@ -223,6 +422,11 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 	led_set(1, 1);
 	led_set(2, 1);
 	led_set(3, 1);
+	
+	i2c_init(CONFIG_SYS_I2C_SPEED, CONFIG_SYS_I2C_SLAVE);
+	data = 0x35;
+	if (i2c_write(0x40, 3, 1, &data, 1) < 0)
+		led_set(3, 0);
 
 	led_set(0, 0);
 #if 1
-- 
1.7.10.4

