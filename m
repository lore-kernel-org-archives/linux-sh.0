From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 11 Mar 2014 16:15:02 +0000
Subject: rcar-i2c: always reads a byte
Message-Id: <531F3686.7050808@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>

I have noticed the following behaviour with the i2c-rcar driver
with the following single i2c_msg structure:

	msg[0].addr = 0x12;
	msg[0].flags = I2C_M_RD;
	msg[0].len = 0;
	msg[0].buf = data;

The system issues an address transaction followed by a single byte
read.

I have tried changing the code to not ack the read after the address
interrupt, however this causes the i2c block to hang forever.

i2c_recv_irq():

	if (priv->pos + 1 >= msg->len) {
		rcar_i2c_bus_phase(priv, RCAR_BUS_PHASE_STOP);
		if (msg->len != 0)
			rcar_i2c_status_bit_clear(priv, MAT | MDR);
		else
			rcar_i2c_status_bit_clear(priv, MAT);
	} else {
		rcar_i2c_bus_phase(priv, RCAR_BUS_PHASE_DATA);
		rcar_i2c_recv_restart(priv);
	}

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
