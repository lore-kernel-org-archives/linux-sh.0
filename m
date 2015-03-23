From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 23 Mar 2015 08:26:37 +0000
Subject: [PATCH v2 2/4] Documentation: i2c: describe the new slave mode
Message-Id: <1427099199-3628-3-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1427099199-3628-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1427099199-3628-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Changes since V1:
* fixed all minor issues found by Geert
* fixed all minor issues found by Uwe
* made clear that NULL is not allowed as third parameter
* reworded the paragraph about I2C_SLAVE_READ_REQUESTED

 Documentation/i2c/slave-interface | 179 ++++++++++++++++++++++++++++++++++++++
 Documentation/i2c/summary         |   4 -
 2 files changed, 179 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/i2c/slave-interface

diff --git a/Documentation/i2c/slave-interface b/Documentation/i2c/slave-interface
new file mode 100644
index 00000000000000..389bb5d618549e
--- /dev/null
+++ b/Documentation/i2c/slave-interface
@@ -0,0 +1,179 @@
+Linux I2C slave interface description
+==================+
+by Wolfram Sang <wsa@sang-engineering.com> in 2014-15
+
+Linux can also be an I2C slave in case I2C controllers have slave support.
+Besides this HW requirement, one also needs a software backend providing the
+actual functionality. An example for this is the slave-eeprom driver, which
+acts as a dual memory driver. While another I2C master on the bus can access it
+like a regular EEPROM, the Linux I2C slave can access the content via sysfs and
+retrieve/provide information as needed. The software backend driver and the I2C
+bus driver communicate via events. Here is a small graph visualizing the data
+flow and the means by which data is transported. The dotted line marks only one
+example. The backend could also use e.g. a character device, be in-kernel
+only, or something completely different:
+
+
+              e.g. sysfs        I2C slave events        I/O registers
+  +-----------+   v    +---------+     v     +--------+  v  +------------+
+  | Userspace +........+ Backend +-----------+ Driver +-----+ Controller |
+  +-----------+        +---------+           +--------+     +------------+
+                                                                | |
+  ----------------------------------------------------------------+--  I2C
+  --------------------------------------------------------------+----  Bus
+
+Note: Technically, there is also the I2C core between the backend and the
+driver. However, at this time of writing, the layer is transparent.
+
+
+User manual
+=====+
+I2C slave backends behave like standard I2C clients. So, you can instantiate
+them like described in the document 'instantiating-devices'. A quick example
+for instantiating the slave-eeprom driver from userspace:
+
+  # echo 0-0064 > /sys/bus/i2c/drivers/i2c-slave-eeprom/bind
+
+Each backend should come with separate documentation to describe its specific
+behaviour and setup.
+
+
+Developer manual
+========
+
+I2C slave events
+----------------
+
+The bus driver sends an event to the backend using the following function:
+
+	ret = i2c_slave_event(client, event, &val)
+
+'client' describes the i2c slave device. 'event' is one of the special event
+types described hereafter. 'val' holds an u8 value for the data byte to be
+read/written and is thus bidirectional. The pointer to val must always be
+provided even if val is not used for an event, i.e. don't use NULL here. 'ret'
+is the return value from the backend. Mandatory events must be provided by the
+bus drivers and must be checked for by backend drivers.
+
+Event types:
+
+* I2C_SLAVE_WRITE_REQUESTED (mandatory)
+
+'val': unused
+'ret': always 0
+
+Another I2C master wants to write data to us. This event should be sent once
+our own address and the write bit was detected. The data did not arrive yet, so
+there is nothing to process or return. Wakeup or initialization probably needs
+to be done, though.
+
+* I2C_SLAVE_READ_REQUESTED (mandatory)
+
+'val': backend returns first byte to be sent
+'ret': always 0
+
+Another I2C master wants to read data from us. This event should be sent once
+our own address and the read bit was detected. After returning, the bus driver
+should transmit the first byte.
+
+* I2C_SLAVE_WRITE_RECEIVED (mandatory)
+
+'val': bus driver delivers received byte
+'ret': 0 if the byte should be acked, some errno if the byte should be nacked
+
+Another I2C master has sent a byte to us which needs to be set in 'val'. If 'ret'
+is zero, the bus driver should ack this byte. If 'ret' is an errno, then the byte
+should be nacked.
+
+* I2C_SLAVE_READ_PROCESSED (mandatory)
+
+'val': backend returns next byte to be sent
+'ret': always 0
+
+The bus driver requests the next byte to be sent to another I2C master in
+'val'. Important: This does not mean that the previous byte has been acked, it
+only means that the previous byte is shifted out to the bus! To ensure seamless
+transmission, most hardware requests the next byte when the previous one is
+still shifted out. If the master sends NACK and stops reading after the byte
+currently shifted out, this byte requested here is never used. It very likely
+needs to be sent again on the next I2C_SLAVE_READ_REQUEST, depending a bit on
+your backend, though.
+
+* I2C_SLAVE_STOP (mandatory)
+
+'val': unused
+'ret': always 0
+
+A stop condition was received. This can happen anytime and the backend should
+reset its state machine for I2C transfers to be able to receive new requests.
+
+
+Software backends
+-----------------
+
+If you want to write a software backend:
+
+* use a standard i2c_driver and its matching mechanisms
+* write the slave_callback which handles the above slave events
+  (best using a state machine)
+* register this callback via i2c_slave_register()
+
+Check the i2c-slave-eeprom driver as an example.
+
+
+Bus driver support
+------------------
+
+If you want to add slave support to the bus driver:
+
+* implement calls to register/unregister the slave and add those to the
+  struct i2c_algorithm. When registering, you probably need to set the i2c
+  slave address and enable slave specific interrupts. If you use runtime pm, you
+  should use pm_runtime_forbid() because your device usually needs to be powered
+  on always to be able to detect its slave address. When unregistering, do the
+  inverse of the above.
+
+* Catch the slave interrupts and send appropriate i2c_slave_events to the backend.
+
+Check the i2c-rcar driver as an example.
+
+
+About ACK/NACK
+--------------
+
+It is good behaviour to always ACK the address phase, so the master knows if a
+device is basically present or if it mysteriously disappeared. Using NACK to
+state being busy is troublesome. SMBus demands to always ACK the address phase,
+while the I2C specification is more loose on that. Most I2C controllers also
+automatically ACK when detecting their slave addresses, so there is no option
+to NACK them. For those reasons, this API does not support NACK in the address
+phase.
+
+Currently, there is no slave event to report if the master did ACK or NACK a
+byte when it reads from us. We could make this an optional event if the need
+arises. However, cases should be extremely rare because the master is expected
+to send STOP after that and we have an event for that. Also, keep in mind not
+all I2C controllers have the possibility to report that event.
+
+
+About buffers
+-------------
+
+During development of this API, the question of using buffers instead of just
+bytes came up. Such an extension might be possible, usefulness is unclear at
+this time of writing. Some points to keep in mind when using buffers:
+
+* Buffers should be opt-in and slave drivers will always have to support
+  byte-based transactions as the ultimate fallback because this is how the
+  majority of HW works.
+
+* For backends simulating hardware registers, buffers are not helpful because
+  on writes an action should be immediately triggered. For reads, the data in
+  the buffer might get stale.
+
+* A master can send STOP at any time. For partially transferred buffers, this
+  means additional code to handle this exception. Such code tends to be
+  error-prone.
+
diff --git a/Documentation/i2c/summary b/Documentation/i2c/summary
index 13ab076dcd9248..809541ab352f03 100644
--- a/Documentation/i2c/summary
+++ b/Documentation/i2c/summary
@@ -41,7 +41,3 @@ integrated than Algorithm and Adapter.
 
 For a given configuration, you will need a driver for your I2C bus, and
 drivers for your I2C devices (usually one driver for each device).
-
-At this time, Linux only operates I2C (or SMBus) in master mode; you can't
-use these APIs to make a Linux system behave as a slave/device, either to
-speak a custom protocol or to emulate some other device.
-- 
2.1.4

