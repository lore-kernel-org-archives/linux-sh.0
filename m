From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 07 Apr 2015 18:39:19 +0000
Subject: [PATCH] spi: Make master->handle_err() callback optional to avoid crashes
Message-Id: <1428431959-23935-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

If a driver doesn't implement the master->handle_err() callback and an
SPI transfer fails, the kernel will crash with a NULL pointer
dereference:

    Unable to handle kernel NULL pointer dereference at virtual address 000=
00000
    pgd =3D c0003000
    [00000000] *pgd=80000040004003, *pmd=00000000
    Internal error: Oops: 80000206 [#1] SMP ARM
    Modules linked in:
    CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.0.0-rc7-koelsch-05861-g1fc9=
fdd4add4f783 #1046
    Hardware name: Generic R8A7791 (Flattened Device Tree)
    task: eec359c0 ti: eec54000 task.ti: eec54000
    PC is at 0x0
    LR is at spi_transfer_one_message+0x1cc/0x1f0

Make the master->handle_err() callback optional to avoid the crash.

Also fix a spelling mistake in the callback documentation while we're at
it.

Fixes: b716c4ffc6a2b0bf ("spi: introduce master->handle_err() callback")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi.c       | 2 +-
 include/linux/spi/spi.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 04e9d9262711a56e..d5d7d2235163f9ef 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -736,7 +736,7 @@ out:
 	if (msg->status =3D -EINPROGRESS)
 		msg->status =3D ret;
=20
-	if (msg->status)
+	if (msg->status && master->handle_err)
 		master->handle_err(master, msg);
=20
 	spi_finalize_current_message(master);
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 57a89347b038e611..d673072346f2e041 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -290,7 +290,7 @@ static inline void spi_unregister_driver(struct spi_dri=
ver *sdrv)
  *                    transfer_one_message are mutually exclusive; when bo=
th
  *                    are set, the generic subsystem does not call your
  *                    transfer_one callback.
- * @handle_err: the subsystem calls the driver to handle and error that oc=
curs
+ * @handle_err: the subsystem calls the driver to handle an error that occ=
urs
  *		in the generic implementation of transfer_one_message().
  * @unprepare_message: undo any work done by prepare_message().
  * @cs_gpios: Array of GPIOs to use as chip select lines; one per CS
--=20
1.9.1

