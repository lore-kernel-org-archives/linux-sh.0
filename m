From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Date: Mon, 30 Nov 2015 00:15:58 +0000
Subject: [PATCH] i2c: emev2: add slave support
Message-Id: <1448842558-18654-2-git-send-email-niklas.soderlund@ragnatech.se>
List-Id: <linux-sh.vger.kernel.org>
References: <1448842558-18654-1-git-send-email-niklas.soderlund@ragnatech.se>
In-Reply-To: <1448842558-18654-1-git-send-email-niklas.soderlund@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org
Cc: ian.molton@codethink.co.uk, laurent.pinchart@ideasonboard.com, magnus.damm@gmail.com, linux-sh@vger.kernel.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>

Add I2C slave provider using the generic slave interface.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund@ragnatech.se>
---
 drivers/i2c/busses/i2c-emev2.c | 110 +++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 109 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-emev2.c b/drivers/i2c/busses/i2c-emev2.c
index 192ef6b..ad87b5a 100644
--- a/drivers/i2c/busses/i2c-emev2.c
+++ b/drivers/i2c/busses/i2c-emev2.c
@@ -71,6 +71,7 @@ struct em_i2c_device {
 	struct i2c_adapter adap;
 	struct completion msg_done;
 	struct clk *sclk;
+	struct i2c_client *slave;
 };
=20
 static inline void em_clear_set_bit(struct em_i2c_device *priv, u8 clear, =
u8 set, u8 reg)
@@ -226,22 +227,129 @@ static int em_i2c_xfer(struct i2c_adapter *adap, str=
uct i2c_msg *msgs,
 	return num;
 }
=20
+static bool em_i2c_slave_irq(struct em_i2c_device *priv)
+{
+	u8 status, value;
+
+	if (!priv->slave)
+		return false;
+
+	status =3D readb(priv->base + I2C_OFS_IICSE0);
+
+	/* Extension code, do not participate */
+	if (status & I2C_BIT_EXC0) {
+		em_clear_set_bit(priv, 0, I2C_BIT_LREL0, I2C_OFS_IICC0);
+		return true;
+	}
+
+	/* Stop detected, we don't know if it's for slave or master */
+	if (status & I2C_BIT_SPD0) {
+		/* Notify slave device */
+		i2c_slave_event(priv->slave, I2C_SLAVE_STOP, &value);
+		/* Pretend we did not handle the interrupt */
+		return false;
+	}
+
+	/* Only handle interrupts addressed to us */
+	if (!(status & I2C_BIT_COI0))
+		return false;
+
+	/* Enable stop interrupts */
+	em_clear_set_bit(priv, 0, I2C_BIT_SPIE0, I2C_OFS_IICC0);
+
+	/* Transmission or Reception */
+	if (status & I2C_BIT_TRC0) {
+		if (status & I2C_BIT_ACKD0) {
+			/* 9 bit interrupt mode */
+			em_clear_set_bit(priv, 0, I2C_BIT_WTIM0, I2C_OFS_IICC0);
+
+			/* Send data */
+			enum i2c_slave_event event =3D status & I2C_BIT_STD0 ?
+				I2C_SLAVE_READ_REQUESTED :
+				I2C_SLAVE_READ_PROCESSED;
+			i2c_slave_event(priv->slave, event, &value);
+			writeb(value, priv->base + I2C_OFS_IIC0);
+		} else {
+			/* NACK, stop transmitting */
+			em_clear_set_bit(priv, 0, I2C_BIT_LREL0, I2C_OFS_IICC0);
+		}
+	} else {
+		/* 8 bit interrupt mode */
+		em_clear_set_bit(priv, I2C_BIT_WTIM0, I2C_BIT_ACKE0,
+				I2C_OFS_IICC0);
+		em_clear_set_bit(priv, I2C_BIT_WTIM0, I2C_BIT_WREL0,
+				I2C_OFS_IICC0);
+
+		if (status & I2C_BIT_STD0) {
+			i2c_slave_event(priv->slave, I2C_SLAVE_WRITE_REQUESTED,
+					&value);
+		} else {
+			/* Recv data */
+			value =3D readb(priv->base + I2C_OFS_IIC0);
+			int ret =3D i2c_slave_event(priv->slave,
+					I2C_SLAVE_WRITE_RECEIVED, &value);
+			if (ret < 0)
+				em_clear_set_bit(priv, I2C_BIT_ACKE0, 0,
+						I2C_OFS_IICC0);
+		}
+	}
+
+	return true;
+}
+
 static irqreturn_t em_i2c_irq_handler(int this_irq, void *dev_id)
 {
 	struct em_i2c_device *priv =3D dev_id;
=20
+	if (em_i2c_slave_irq(priv))
+		return IRQ_HANDLED;
+
 	complete(&priv->msg_done);
+
 	return IRQ_HANDLED;
 }
=20
 static u32 em_i2c_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_SLAVE;
+}
+
+static int em_i2c_reg_slave(struct i2c_client *slave)
+{
+	struct em_i2c_device *priv =3D i2c_get_adapdata(slave->adapter);
+
+	if (priv->slave)
+		return -EBUSY;
+
+	if (slave->flags & I2C_CLIENT_TEN)
+		return -EAFNOSUPPORT;
+
+	priv->slave =3D slave;
+
+	/* Set slave address */
+	writeb(slave->addr << 1, priv->base + I2C_OFS_SVA0);
+
+	return 0;
+}
+
+static int em_i2c_unreg_slave(struct i2c_client *slave)
+{
+	struct em_i2c_device *priv =3D i2c_get_adapdata(slave->adapter);
+
+	WARN_ON(!priv->slave);
+
+	writeb(0, priv->base + I2C_OFS_SVA0);
+
+	priv->slave =3D NULL;
+
+	return 0;
 }
=20
 static struct i2c_algorithm em_i2c_algo =3D {
 	.master_xfer =3D em_i2c_xfer,
 	.functionality =3D em_i2c_func,
+	.reg_slave      =3D em_i2c_reg_slave,
+	.unreg_slave    =3D em_i2c_unreg_slave,
 };
=20
 static int em_i2c_probe(struct platform_device *pdev)
--=20
2.6.2

